$ErrorActionPreference = 'Stop'

$version='v0.11.4'

$newestRelease = 'https://github.com/Orama-Interactive/Pixelorama/releases/download/' + $version

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url = $newestRelease + '/Pixelorama.Windows-32bit.zip'
$checksum = '2F807B053842541F865580D201672FCB3C15391A4AB069D7FC96EF267A1E709B'

$url64bit = $newestRelease + '/Pixelorama.Windows-64bit.zip'
$checksum64 = 'BB10303181CE0A588311E6FC5E37CC2466B27F82868D83B0886A7299CDE1DED0'

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