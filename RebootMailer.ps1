# uso: .\RebootMailer.ps1 -RebTimer seconds -action [reboot o shutdown]
# Variabili
param ($RebTimer,$action)
#write-host $RebTimer,$action
$Machine = $env:computername
$textEncoding = [System.Text.Encoding]::UTF8
$EmailFrom = "rebooter@server"
$EmailTo = "mail@server"
$SubjectOK =$action+" "+$Machine
$SubjectFAIL ="FAILED Reboot "+$Machine
$BodyOK = $action+" della macchina "+$Machine+" fra "+$RebTimer+" secondi"
$BodyFAIL = "FALLITO "+$action+" della macchina "+$Machine
$SMTPServer = "mail.server"

#Verifica se è compilato il campo action
if ( $action -eq "shutdown" )
{
    $command = "/s"
} elseif ( $action -eq "reboot" )
{
    $command = "/r"
} else
{
    echo "no action specified, use shutdown or reboot"
    exit
}

#Verifica se è compilato il campo RebTimer
if ( $RebTimer -lt 60 )
{
    echo "RebTimer no specified or less then 60"
    exit
}


#Setto timeout di shutdown
shutdown.exe $command /t $RebTimer

#Verifica se il comando shutdown ha esito positivo 0
if ( $LASTEXITCODE -eq "0" )
{
    Send-Mailmessage -smtpServer $SMTPServer -from $EmailFrom -to $EmailTo -subject $SubjectOK -body $BodyOK -Encoding $textEncoding -ErrorAction Stop -ErrorVariable err
} else
{
    Send-Mailmessage -smtpServer $SMTPServer -from $EmailFrom -to $EmailTo -subject $SubjectFAIL -body $BodyFAIL -Encoding $textEncoding -priority High -ErrorAction Stop -ErrorVariable err
}
