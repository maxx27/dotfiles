import sublime, sublime_plugin, time
class InsertDatetimeCommand(sublime_plugin.TextCommand):
    def run(self, edit):
        sel = self.view.sel()
        for s in sel:
            d = time.strftime("%Y.%m.%d %H:%M")
            self.view.replace(edit, s, d)
