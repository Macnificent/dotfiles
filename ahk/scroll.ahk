#Persistent

sleepAmount = 50;

F3::
While (GetKeyState("F3","P"))
{
	send {WheelDown} 
	sleep %sleepAmount%
}
Return

F4::
While (GetKeyState("F4","P"))
{
	send {WheelUp} 
	sleep %sleepAmount%
}
Return
