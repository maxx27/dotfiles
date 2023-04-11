$packageXml = ''
choco list -lo -r | % { $_ -split '\|' | select -first 1 } | % { $packageXml += "`n`t<package Id=""$_"" />" }
Set-Content "<packages>$packageXml`n</packages>" .\packages.config