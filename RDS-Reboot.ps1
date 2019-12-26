#
# RDR-IT
# Get close and active sessions of a desktop session host server remotely and reboot the server
# Compatible with RDS farms 2012R2 / 2016/2019
#

$ServerBroker = ""
$ServerHost = ""

# Get sessions from broker
$Sessions = Get-RDUserSession -ConnectionBroker $ServerBroker

# Browse all open sessions and close sessions on the session host server configured in parameter
foreach($Session in $Sessions){

    #Write Event
    Write-EventLog -LogName "System" -Source "EventLog" -EventId 6013 -EntryType Information -Message "$Session.UserName close session"

	# Write-Host $Session.UnifiedSessionID -ForegroundColor Red
	Invoke-RDUserLogoff -HostServer $ServerHost -UnifiedSessionID $Session.UnifiedSessionID -Force
}

Restart-Computer
