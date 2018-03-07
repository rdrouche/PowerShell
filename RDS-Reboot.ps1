#
# RDR
# Recupere et fermer les sessions actives et reboot le serveur
# Compatible RDS 2012 avec serveur BROKER
#
#

$ServerBroker = ""
$ServerHost = ""

$Sessions = Get-RDUserSession -ConnectionBroker $ServerBroker

foreach($Session in $Sessions){

    #Write Event
    Write-EventLog -LogName "System" -Source "EventLog" -EventId 6013 -EntryType Information -Message "$Session.UserName close session"

	# Write-Host $Session.UnifiedSessionID -ForegroundColor Red
	Invoke-RDUserLogoff -HostServer $ServerHost -UnifiedSessionID $Session.UnifiedSessionID -Force
}

Restart-Computer
