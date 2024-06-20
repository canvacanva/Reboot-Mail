# uso: .\RebootMailer.ps1 -RebTimer seconds
# Variabili
param ($RebTimer)
write-host $RebTimer 
$Machine = $env:computername
$textEncoding = [System.Text.Encoding]::UTF8
$EmailFrom = "rebooter@company.1"
$EmailTo = "recipier@company.2"
$SubjectOK ="Reboot "+$Machine
$SubjectFAIL ="FAILED Reboot "+$Machine
$BodyOK = "Riavvio della Macchina "+$Machine+" fra "+$RebTimer+" secondi"
$BodyFAIL = "FALLITO Riavvio della Macchina "+$Machine
$SMTPServer = "smtp.relay.com"



#Setto timeout di schutdown
shutdown.exe /r /t $RebTimer

#Ridando shutdown verifico che il comando sia stato recepito, in questo caso avrò il codice di uscita 1190 e dovrò inviare una mail di conferma
shutdown.exe /r /t 31536000

if ( 1190 -eq $LASTEXITCODE )
{
    Send-Mailmessage -smtpServer $SMTPServer -from $EmailFrom -to $EmailTo -subject $SubjectOK -body $BodyOK -Encoding $textEncoding -ErrorAction Stop -ErrorVariable err
} else
{
    Send-Mailmessage -smtpServer $SMTPServer -from $EmailFrom -to $EmailTo -subject $SubjectFAIL -body $BodyFAIL -Encoding $textEncoding -priority High -ErrorAction Stop -ErrorVariable err
}
