(* AppleScript to set system volume according to input. 
Take volume as argument and process.
In case no argument given, it use default value as 5 *)

on run argv
	if (count of argv) > 0 then
		set volume (item 1 of argv)
	else
		-- Set default volume to 5 in case of no input is given
		set volume 5
	end if
end run
