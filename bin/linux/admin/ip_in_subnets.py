import ipaddress

def check_ips_in_ranges(ip_ranges, ip_list):
    results = {}
    for ip in ip_list:
        results[ip] = []
        try:
            ip_obj = ipaddress.ip_address(ip)
            for ip_range in ip_ranges:
                try:
                    network = ipaddress.ip_network(ip_range, strict=False)
                    if ip_obj in network:
                        results[ip].append(ip_range)
                except ValueError:
                    pass  # Пропускаем некорректный диапазон
        except ValueError:
            results[ip] = None  # Некорректный IP
    return results

if __name__ == "__main__":
    # Указанные диапазоны в формате CIDR
    ip_ranges = [
        # cloudflare https://www.cloudflare.com/ips-v4/
        "103.21.244.0/22",
        "103.22.200.0/22",
        "103.31.4.0/22",
        "104.16.0.0/13",
        "104.24.0.0/14",
        "108.162.192.0/18",
        "131.0.72.0/22",
        "141.101.64.0/18",
        "162.158.0.0/15",
        "172.64.0.0/13",
        "173.245.48.0/20",
        "188.114.96.0/20",
        "190.93.240.0/20",
        "197.234.240.0/22",
        "198.41.128.0/17",
    ]

    # Список IP-адресов для проверки
    ip_list = [
        "1.95.159.116",
        "102.212.216.147",
        "103.102.230.8",
        "98.80.104.243",
    ]

    # Проверка IP-адресов
    results = check_ips_in_ranges(ip_ranges, ip_list)

    # Вывод результатов
    for ip, matching_ranges in results.items():
        if matching_ranges is None:
            print(f"IP {ip} имеет некорректный формат")
        elif matching_ranges:
            print(f"IP {ip} принадлежит диапазонам: {', '.join(matching_ranges)}")
        # else:
        #     print(f"IP {ip} не принадлежит ни одному из заданных диапазонов")
