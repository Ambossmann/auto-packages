$ErrorActionPreference = 'Stop'

Write-Host "Removing Start Menu and Desktop shortcuts"
$StartMenuShortcut = Join-Path $env:programdata "Microsoft\Windows\Start Menu\Programs\Pixelorama.lnk"
$DesktopShortcut = Join-Path $([Environment]::GetFolderPath("Desktop")) "Pixelorama.lnk"
if (Test-Path $StartMenuShortcut)
{
  Remove-Item $StartMenuShortcut
}
if (Test-Path $DesktopShortcut)
{
  Remove-Item $DesktopShortcut
}