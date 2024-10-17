#!/usr/bin/python3
# Based on https://stackoverflow.com/questions/35658887/git-pre-commit-or-update-hook-for-stopping-commit-with-branch-names-having-case
import hashlib
import os
import subprocess
import sys

"""
Запускается программа

$ ~/bin/linux/develop/git/git_case_dups.py

Потом по выводу принимается решение. Автоматически тут трудно принимать решение.

Found duplicate names:
- [repo] Tech/OS/Linux/programs/process/Htop.md 696da1b73b0dbd3dfca25ea4484562d1199b87f13f06e68192e3d02901b6976e
- [repo] Tech/OS/Linux/programs/process/htop.md 696da1b73b0dbd3dfca25ea4484562d1199b87f13f06e68192e3d02901b6976e
- [disk] Tech/OS/Linux/programs/process/Htop.md 696da1b73b0dbd3dfca25ea4484562d1199b87f13f06e68192e3d02901b6976e

Тут все файлы с одинаковым содержимым.
Правильное имя (после гугления) htop.md - поэтому на диске надо переименовать Htop.md -> htop.md, удалить из репозитория Htop.md.

Found duplicate names:
- [repo] Tech/OS/Tools/Cloud-init.md 30d744d349017a7b47ea7cb2c8c22f09084492049f5498c6754346d45d217f79
- [repo] Tech/OS/Tools/cloud-init.md 30d744d349017a7b47ea7cb2c8c22f09084492049f5498c6754346d45d217f79
- [disk] Tech/OS/Tools/cloud-init.md 30d744d349017a7b47ea7cb2c8c22f09084492049f5498c6754346d45d217f79

Тут все файлы с одинаковым содержимым.
Правильное имя cloud-init.md, поэтому на диске оставляем, а из репы удаляем Cloud-init.md.

Если содержимое файлов разное, то их надо сохранять на диске с суффиксами .1, .2 и так далее, чтобы понять как сливать вместе.

TODO: Русская буква `й` по-разному воспринимается Python:
- 'Список изменений и TO DO.docx' <-- взято из Git
- 'Список изменений и TO DO.docx' <-- прочитано с os.listdir
"""

def calc_content_digest(content: bytes) -> str:
    h = hashlib.sha256()
    h.update(content)
    return h.hexdigest()

def calc_file_digest(filename: str) -> str:
    with open(filename, "rb") as f:
        return calc_content_digest(f.read())

def get_file_realcase(filename: str, dir_: str = '') -> str:
    """Получить реальный путь в регистронезависимой файловой системе.

    Путь разбивается на элементы и слева направо проверяется наличие каждого из них.
    Если элемент найден, то он заменяется тем, как найден на диске. Иначе возбуждается исключение.

    Args:
        filename (str): проверяемый путь
        dir_ (str, optional): путь с которого ищется. Defaults to ''.

    Raises:
        FileNotFoundError: Если часть не найдена

    Returns:
        str: Путь с учётом реального регистра.

    TODO: доделать и запостить сюда https://stackoverflow.com/questions/2113822/python-getting-filename-case-as-stored-in-windows
    """

    if filename == '':
        return dir_

    def split(filename: str) -> tuple[str, str]:
        pos = filename.find("/")
        if pos == -1:
            return filename, ''
        return filename[:pos], filename[pos+1:]

    part1, part2 = split(filename)
    for file_ in os.listdir(dir_ or '.'):
        if file_.lower() == part1.lower():
            dir_ = '/'.join([dir_, file_]) if dir_ else file_
            return get_file_realcase(part2, dir_)

    raise FileNotFoundError(f"dir '{dir_}' does not contain '{part1}'")

def found_dups():
    p = subprocess.run([
            "git",
            # раскомментировать для отладки и подставить свою папку
            "-C",
            "/Users/m.suslov/Data/Notes",
            "rev-parse",
            "--show-toplevel",
        ], capture_output=True)
    os.chdir(p.stdout.strip())

    # Собрать информацию об именах файлах в репозитории
    p = subprocess.run(["git", "ls-files"], capture_output=True)
    lower_names: dict[str, list[str]] = {}
    for line in p.stdout.splitlines():
        filename = line.decode('utf-8').strip()
        names = lower_names.get(filename.lower(), [])
        names.append(filename)
        lower_names[filename.lower()] = names

    for lower_name in lower_names:
        if len(lower_names[lower_name]) < 2:
            # Проверить наличие на диске с таким регистром
            filename = lower_names[lower_name][0]
            try:
                real_filename = get_file_realcase(filename)
            except FileNotFoundError as e:
                print(f"FileNotFoundError: {str(e)}", file=sys.stderr)
                continue
            if real_filename != filename:
                print("Found different case:")
                print(f"- [repo] {filename}")
                print(f"- [disk] {real_filename}")
            continue

        print("Found duplicate names:")

        # Вывести информацию о том, что в репозитории
        files_digests = {'repo': {}, 'disk': {}}
        for filename in lower_names[lower_name]:
            p = subprocess.run(["git", "show", f"HEAD:{filename}"], capture_output=True)
            assert p.returncode == 0
            digest = calc_content_digest(p.stdout)
            files_digests["repo"][filename] = digest
            print(f"- [repo] {filename} {digest}")
        del filename, digest, p

        # Понять, какая версия на диске
        for filename in lower_names[lower_name]:
            # NOTE: Windows и Mac OS позволяют обращаться к файлам вне зависимости от регистра
            # TODO: учесть Linux, где нет такого
            if not os.path.exists(filename):
                raise FileNotFoundError(f"{filename} does not exist")

            real_filename = get_file_realcase(filename)
            real_filename = real_filename[-len(filename):]
            # если файл не совпадает с тем, что есть на диске, то игнорируем его (будет взять что есть на диске)
            if real_filename != filename:
                continue
            digest = calc_file_digest(filename)
            files_digests["disk"][real_filename] = digest
            print(f"- [disk] {real_filename} {digest}")

        # TODO: если содержимое отличается, то надо сохранить на диск, чтобы человек посмотрел.
        # i = 1
        # for filename in lower_names[lower_name]:
        #     print(f"- {filename}.{i}")
        #     p = subprocess.run(
        #         ["git", "show", f"HEAD:{filename}"], capture_output=True
        #     )
        #     assert p.returncode == 0
        #     # TODO: прежде чем доставать проверить на одинаковое содержимое, а еще лучше с тем, что сейчас на диске
        #     with open(f"{filename}.{i}", 'wb') as f:
        #         f.write(p.stdout)

        #     i += 1
        print()

    return

if __name__ == "__main__":
    found_dups()
