-- stuff that needs to be done before I disconnect the laptop
try
	tell application "Finder" to eject disk "Tony Backup"
on error
	log "Error unloading Tony Backup"
end try
-- quit chrome because it stalls sleep
tell application "Google Chrome" to quit
-- unload mds to save battery
do shell script "sudo launchctl unload /System/Library/LaunchDaemons/com.apple.metadata.mds.plist"
