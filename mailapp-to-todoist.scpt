on run argv
-- Send links to selected Mail.app messages to Todoist
set messageList to {}
tell application "Mail"
	set todoistToken to (system attribute "todoistToken")
	set mailMessages to the selection	
	repeat with theMessage in the mailMessages
		set messageSubject to the subject of the theMessage
		copy messageSubject to end of messageList
		set messageUrl to "message://%3c" & theMessage's message id & "%3e"
				
		set task to argv & " [" & messageSubject & "]" & "(" & messageUrl & ") "

		set curl_command to "curl https://todoist.com/api/v8/quick/add -d token=" & todoistToken & " -d text='" & task & "'"

		do shell script curl_command
		
	end repeat
end tell
return messageList
end run