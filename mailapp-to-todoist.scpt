on run argv
-- Send links to selected Mail.app messages to Todoist
set messageList to {}
tell application "Mail"
	set todoistToken to (system attribute "todoistToken")
	set mailMessages to the selection	
	repeat with theMessage in the mailMessages
		-- strip single quotes - TODO, figure out how to gracefully escape them
		set messageSubject to my replace_chars(the subject of the theMessage, "'", "")
		copy messageSubject to end of messageList
		set messageUrl to "message://%3c" & theMessage's message id & "%3e"
				
		set task to argv & " [" & messageSubject & "]" & "(" & messageUrl & ") "

		set curl_command to "curl https://todoist.com/api/v8/quick/add -d token=" & todoistToken & " -d text='" & task & "'"

		do shell script curl_command
		
	end repeat
end tell
return messageList
end run

on replace_chars(this_text, search_string, replacement_string)
	set AppleScript's text item delimiters to the search_string
	set the item_list to every text item of this_text
	set AppleScript's text item delimiters to the replacement_string
	set this_text to the item_list as string
	set AppleScript's text item delimiters to ""
	return this_text
end replace_chars