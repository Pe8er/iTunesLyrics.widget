if isMusicPlaying() is true then
	try
		tell application "iTunes" to set {artistName, songName, albumName, lyricsRaw} to {artist, name, album, lyrics} of current track
	on error e
		logEvent(e)
		return
	end try
	
	set myLyrics to {}
	set lyricsRaw to paragraphs of lyricsRaw
	
	repeat with aLine in lyricsRaw
		set myLyrics to myLyrics & aLine & "<br />" & return
	end repeat
	
	if myLyrics is not {} then
		return artistName & "~" & songName & "~" & myLyrics as string
	else
		return
	end if
else
	return
end if

on isMusicPlaying()
	set answer to false
	tell application "System Events" to set isRunning to (name of processes) contains "iTunes"
	if isRunning is true then
		try
			tell application "iTunes" to if player state is playing then set answer to true
		on error e
			my logEvent(e)
		end try
	end if
	return answer
end isMusicPlaying

on logEvent(e)
	tell application "Finder" to set myName to (name of file (path to me))
	do shell script "echo '" & (current date) & space & quoted form of (e as string) & "' >> ~/Library/Logs/" & myName & ".log"
end logEvent