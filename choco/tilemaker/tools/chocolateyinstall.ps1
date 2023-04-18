$ErrorActionPreference = 'Stop'


$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url = 'https://github.com/systemed/tilemaker/releases/download/v2.4.0/tilemaker-windows.zip'
$checksum = '280451DA4549176F17AA698B94F570BC0834349DA90FF6B343B9D80A5BBE4D65'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  softwareName   = 'Tilemaker*'
  unzipLocation  = $toolsDir

  url            = $url
  checksum       = $checksum

  checksumType   = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs