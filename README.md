# Schedule reboot or shutdown and send email with scedule status

Set parameter (seconds) to wait for reboot (eg.30)
```
.\RebootMailer.ps1 -RebTimer seconds -action [reboot o shutdown]
```

Can be run as schedule task using SYSTEM user.

```
powershell -ExecutionPolicy Bypass -command \\shared\Updater\RebootMailer.ps1 -RebTimer XX -action YY
```
