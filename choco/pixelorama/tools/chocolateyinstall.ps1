$ErrorActionPreference = 'Stop'

$version='v0.11.3'

$newestRelease = 'https://github.com/Orama-Interactive/Pixelorama/releases/download/' + $version

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url = $newestRelease + '/Pixelorama.Windows-32bit.zip'
$checksum = '080828364FB1C731EF28913D3461E0F709710779955189EB11CD77B9685E3A37'

$url64bit = $newestRelease + '/Pixelorama.Windows-64bit.zip'
$checksum64 = 'AC0F27DF7AD14D8AA19AD7608B4D6506D189391E7CED2081A9D06FF61E3E1A67'

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