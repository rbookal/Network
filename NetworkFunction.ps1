Function ConvertTo-BinaryIP {
    #.Synopsis
    # Convert an IP address to binary
    #.Example
    # ConvertTo-BinaryIP -IP 192.168.1.1
    Param (
        [string]
        $IP
    )
    Process {
        $out = @()
        Foreach ($octet in $IP.split('.')) {
            $strout = $null
            0..7|% {
                IF (($octet - [math]::pow(2,(7-$_)))-ge 0) {
                    $octet = $octet - [math]::pow(2,(7-$_))
                    [string]$strout = $strout + "1"
                } else {
                    [string]$strout = $strout + "0"
                }  
            }
            $out += $strout
        }
        return [string]::join('.',$out)
    }
}
 
Function ConvertFrom-BinaryIP {
    #.Synopsis
    # Convert from Binary to an IP address
    #.Example
    # Convertfrom-BinaryIP -IP 11000000.10101000.00000001.00000001
    Param (
        [string]
        $IP
    )
    Process {
        $out = @()
        Foreach ($octet in $IP.split('.')) {
            $strout = 0
            0..7|% {
                $bit = $octet.Substring(($_),1)
                IF ($bit -eq 1) {
                    $strout = $strout + [math]::pow(2,(7-$_))
                }
            }
            $out += $strout
        }
        return [string]::join('.',$out)
    }
}
 
Function ConvertTo-MaskLength {
    #.Synopsis
    # Convert from a netmask to the masklength
    #.Example
    # ConvertTo-MaskLength -Mask 255.255.255.0
    Param (
        [string]
        $mask
    )
    Process {
        $out = 0
        Foreach ($octet in $Mask.split('.')) {
            $strout = 0
            0..7|% {
                IF (($octet - [math]::pow(2,(7-$_)))-ge 0) {
                    $octet = $octet - [math]::pow(2,(7-$_))
                    $out++
                }
            }
        }
        return $out
    }
}
 
Function ConvertFrom-MaskLength {
    #.Synopsis
    # Convert from masklength to a netmask
    #.Example
    # ConvertFrom-MaskLength -Mask /24
    #.Example
    # ConvertFrom-MaskLength -Mask 24
    Param (
        [int]
        $mask
    )
    Process {
        $out = @()
       
        [int]$wholeOctet = ($mask - ($mask % 8))/8
        if ($wholeOctet -gt 0) {
            1..$($wholeOctet) |%{
                $out += "255"
            }
        }
        $subnet = ($mask - ($wholeOctet * 8))
        if ($subnet -gt 0) {
            $octet = 0
            0..($subnet - 1) | %{
                 $octet = $octet + [math]::pow(2,(7-$_))
                 
            }
            $out += $octet
        }
        for ($i=$out.count;$i -lt 4; $I++) {
            $out += 0
        }
        return [string]::join('.',$out)
    }
}
 