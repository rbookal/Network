#get network card 
Get-NetAdapter |select name,status,speed,fullduplex

#get network card that's up
Get-NetAdapter |select name,status,speed,fullduplex | where status -EQ 'up'