$ErrorActionPreference = 'Stop'

$newestRelease = 'https://github.com/OpenNBS/OpenNoteBlockStudio/releases/download/v3.10.0'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url = $newestRelease + '/Minecraft.Note.Block.Studio.zip'
$checksum = 'C6074646FA0774CA4A33EF258CA003428FD2916A5755F1E7C832F56950415350'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  softwareName   = 'OpenNBS*'
  unzipLocation  = $toolsDir

  url            = $url
  checksum       = $checksum

  checksumType   = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

Write-Host "Creating Start Menu and Desktop shortcuts"

$startmenu = Join-Path $env:programdata "Microsoft\Windows\Start Menu\Programs"
Install-ChocolateyShortcut -shortcutFilePath $(Join-Path $startmenu "Minecraft Note Block Studio.lnk") -TargetPath $([IO.Path]::Combine($toolsDir, "Minecraft Note Block Studio.exe"))
$desktop = [Environment]::GetFolderPath("Desktop")
Install-ChocolateyShortcut -shortcutFilePath $(Join-Path $desktop "Minecraft Note Block Studio.lnk") -TargetPath $([IO.Path]::Combine($toolsDir, "Minecraft Note Block Studio.exe"))