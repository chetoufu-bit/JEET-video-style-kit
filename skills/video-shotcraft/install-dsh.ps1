[CmdletBinding()]
param(
    [string]$DshHome,
    [switch]$Force
)

$ErrorActionPreference = "Stop"
$Repo = $PSScriptRoot
$PythonExe = $null
$PythonPrefix = @()
if (Get-Command python -ErrorAction SilentlyContinue) {
    $PythonExe = (Get-Command python).Source
} elseif (Get-Command py -ErrorAction SilentlyContinue) {
    $PythonExe = (Get-Command py).Source
    $PythonPrefix = @("-3")
} else {
    throw "Python 3.10+ is required by the DSH package manager."
}
foreach ($Command in @("node", "npm", "npx")) {
    if (-not (Get-Command $Command -ErrorAction SilentlyContinue)) { throw "$Command is required." }
}

$ArgsList = @($PythonPrefix) + @("$Repo\scripts\dsh_manager.py")
if ($DshHome) { $ArgsList += @("--dsh-home", $DshHome) }
$ArgsList += "install"
if ($Force) { $ArgsList += "--force" }
& $PythonExe @ArgsList

$DoctorArgs = @($PythonPrefix) + @("$Repo\scripts\dsh_manager.py")
if ($DshHome) { $DoctorArgs += @("--dsh-home", $DshHome) }
$DoctorArgs += "doctor"
& $PythonExe @DoctorArgs
