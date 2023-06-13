$ErrorActionPreference = 'Stop'

$newestRelease = 'https://github.com/Orama-Interactive/Pixelorama/releases/download/v0.11'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url = $newestRelease + '/Pixelorama.Windows-32bit.zip'
$checksum = '369A3B418B71CAAC8E9B652B1F6000B6E19E6DA85E6338AD91542670FCED5B28'

$url64bit = $newestRelease + '/Pixelorama.Windows-64bit.zip'
$checksum64 = '25FAEBF6CB3EC823A477EF09EC84ED8095AA18BC0C9993DB8696E7440225AA19'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  softwareName   = 'Pixelorama*'
  unzipLocation  = $toolsDir

  url            = $url
  checksum       = $checksum

  url64bit       = $url64bit
  checksum64     = $checksum64

  checksumType   = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

Write-Host "Creating Start Menu and Desktop shortcuts"

if (Get-OSArchitectureWidth -Compare 64) {
  $specificFolder = "windows-64bit"
}
else {
  $specificFolder = "windows-32bit"
}

$startmenu = Join-Path $env:programdata "Microsoft\Windows\Start Menu\Programs"
Install-ChocolateyShortcut -shortcutFilePath $(Join-Path $startmenu "Pixelorama.lnk") -TargetPath $([IO.Path]::Combine($toolsDir, $specificFolder, "Pixelorama.exe"))
$desktop = [Environment]::GetFolderPath("Desktop")
Install-ChocolateyShortcut -shortcutFilePath $(Join-Path $desktop "Pixelorama.lnk") -TargetPath $([IO.Path]::Combine($toolsDir, $specificFolder, "Pixelorama.exe"))