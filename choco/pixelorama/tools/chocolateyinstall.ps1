$ErrorActionPreference = 'Stop'

$version='v0.11.2'

$newestRelease = 'https://github.com/Orama-Interactive/Pixelorama/releases/download/' + $version

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url = $newestRelease + '/Pixelorama.Windows-32bit.zip'
$checksum = '23A97F902B3D38395CC92EC493E36E0E161DE7326D6EEB77DBBC4FD353923C99'

$url64bit = $newestRelease + '/Pixelorama.Windows-64bit.zip'
$checksum64 = 'C80144086C263BD8CEF6B0C0E76F43B18E229E3F12CCF37C8B328DFF9ABCC729'

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