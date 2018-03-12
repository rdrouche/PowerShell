#
#	@author: Romain Drouche
#	@Description : Exporte le champs proxyAddresses des utilisateurs de l'OU cible $contactou
#	@website : http://blog.rdr-it.com
#	@original source : https://241931348f64b1d1.wordpress.com/2015/10/21/how-to-dump-users-proxyaddresses-attribute-with-powershell/ 
#
ipmo activedirectory
cls 
cd C:\
$contactou = "OU=users ,DC=mondomaine,DC=intra"
$datesuffix = get-date -Format yyy-MM-dd_HHmmss
 
$allcontacts = get-adobject -filter {objectclass -eq "user" } -searchbase $contactou -property DistinguishedName,ObjectGUID,proxyaddresses
 
$allcontacts | select DistinguishedName,ObjectGUID,@{Name='proxyAddresses';Expression={[string]::join(";", $($_.proxyAddresses))}} | export-csv -delimiter ";" -notype alldominocontacts_$($datesuffix).csv
Write-Host "-----------------"
Write-Host "Export termine"