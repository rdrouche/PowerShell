#
#	@author: Romain Drouche
#	@Description : Exporte le champs proxyAddresses des utilisateurs de l'OU cible $contactou
#	@website : http://blog.rdr-it.com
#	@original source : https://241931348f64b1d1.wordpress.com/2015/10/21/how-to-dump-users-proxyaddresses-attribute-with-powershell/ 
#
cls
$contactou = "OU=users ,DC=mondomaine,DC=intra"
cd C:\
Import-Csv "alldominocontacts.csv" -delimiter ";" | ForEach-Object{
    $guid = $_.ObjectGUID
    $proxyAddresses = $_.proxyaddresses -split ';'
     
    $find = Get-ADObject -filter {(objectGUID -eq $guid)} -searchbase $contactou -Properties Name,ProxyAddresses
    Write-Host "Utilisateur:"
    Write-Host $find.Name
    Write-Host "Current ProxyAddresses:" $find.proxyaddresses
    Write-Host "Old ProxyAddresses    :" $proxyAddresses
    Set-ADObject -Identity $guid -Replace @{proxyAddresses=$proxyAddresses}    
    Write-Host "-----------------"
    Write-Host
}