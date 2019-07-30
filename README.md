# SCCM

This repository contains some functions, i use regularly

## Invoke-SCCMScript

this function allows to invoke a CMScript and pass parameters to it.

(the builtin cmdlet Invoke-CMScript doesn't allow to pass parameters)

```PowerShell
# parameters to send to the script
$InputParameters = @{
    param1 = 'Test 1'
    param2 = 'Test 2'
}

$Params = @{
    SiteServer        = 'server.fqdn.net'
    SiteCode          = 'P00'
    ScriptName        = 'Test Script'
    TargetResourceIDs = '11111111'
    InputParameters   = $InputParameters
}
Invoke-SCCMScript @Params
```