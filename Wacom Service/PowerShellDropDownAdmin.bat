:: Add value for UAC shield icon:
REG ADD "HKCR\Microsoft.PowerShellScript.1\Shell\runas" /v HasLUAShield /t REG_SZ /d "" /f
:: Add value to create context menu item:
REG ADD "HKCR\Microsoft.PowerShellScript.1\Shell\runas\command" /ve /t REG_EXPAND_SZ /d "\"%%SYSTEMROOT%%\System32\WindowsPowerShell\v1.0\powershell.exe\" -executionpolicy bypass -nologo -file \"%%1\"" /f

:: Delete command to reset:
:: REG DELETE "HKCR\Microsoft.PowerShellScript.1\Shell\runas" /f

PAUSE