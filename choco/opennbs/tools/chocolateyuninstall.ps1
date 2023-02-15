$ErrorActionPreference = 'Stop'

Write-Host "Removing Start Menu and Desktop shortcuts"
$StartMenuShortcut = Join-Path $env:programdata "Microsoft\Windows\Start Menu\Programs\Minecraft Note Block Studio.lnk"
$DesktopShortcut = Join-Path $([Environment]::GetFolderPath("Desktop")) "Minecraft Note Block Studio.lnk"
if (Test-Path $StartMenuShortcut)
{
  Remove-Item $StartMenuShortcut
}
if (Test-Path $DesktopShortcut)
{
  Remove-Item $DesktopShortcut
}