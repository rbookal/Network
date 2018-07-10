param (
[string]$strIPAddress
)

function Set-StaticIPAddress ($strIPAddress, $strSubnet, $strGateway, $strDNSServer1, $strDNSServer2) {
    $NetworkConfig = Get-WmiObject Win32_NetworkAdapterConfiguration -Filter "IpEnabled = 'True'"
    $NetworkConfig.EnableStatic($strIPAddress, $strSubnet)
    $NetworkConfig.SetGateways($strGateway, 1)
    $NetworkConfig.SetDNSServerSearchOrder(@($strDNSServer1, $strDNSServer2))
}

Set-StaticIPAddress $strIPAddress "255.255.255.0" "192.168.137.1" "192.168.137.100" "192.168.137.101"