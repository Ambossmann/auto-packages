$ErrorActionPreference = 'Stop'

$newestRelease = 'https://github.com/Orama-Interactive/Pixelorama/releases/download/v0.11.1'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url = $newestRelease + '/Pixelorama.Windows-32bit.zip'
$checksum = 'D3478A6DBB8AA4B895910C485BF5ECD4C80250029F5CAAC75250FEDDF1D2F171'

$url64bit = $newestRelease + '/Pixelorama.Windows-64bit.zip'
$checksum64 = '215E3A6DAFFF6A7D883CFE5EE7AB54150B63E5ECDD0F5764C05A9E1706E2CBB6'

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