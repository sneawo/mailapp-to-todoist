on run argv
-- Send links to selected Mail.app messages to Todoist
tell application "Mail"
	set todoistToken to (system attribute "todoistToken")
	set mailMessages to the selection	
	repeat with theMessage in the mailMessages
		set messageSubject to the subject of the theMessage
		set messageUrl to "message://%3c" & theMessage's message id & "%3e"
				
		set task to "[" & messageSubject & "]" & "(" & messageUrl & ")"

		set curl_command to "curl https://beta.todoist.com/API/v8/tasks?token=" & todoistToken & " -X POST --data '{\"content\": \"" & task & "\"}' " & " -H \"Content-Type: application/json\" -H \"X-Request-Id: $(uuidgen)\" "
		do shell script curl_command
		
	end repeat
end tell
end run