$cert = Get-Item -Path Cert:\CurrentUser\My\B347BACF66A37708C4F62B1D717C3EA67C494B81
$certFile = 'exported.cer'

$content = @(
    '-----BEGIN CERTIFICATE-----'
    [System.Convert]::ToBase64String($cert.RawData, 'InsertLineBreaks')
    '-----END CERTIFICATE-----'
)

$content | Out-File -FilePath $certFile -Encoding ascii
