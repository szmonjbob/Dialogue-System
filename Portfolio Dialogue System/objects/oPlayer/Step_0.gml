//We create a variable that stores whether or not there is already a textbox.
var _textPresent = instance_exists(oTextBox);
//Then we create a keybind that will trigger any pSpeaker instances to create or queue text boxes.
activateKey = (keyboard_check_pressed(ord("E")));

//if the key is pressed, the game will check if there is already a textbox.
//if there's a textbox, nothing will happen. If not, it asks pSpeaker to create one.
if (activateKey) && (!_textPresent)
{
	//this variable checks whether a pSpeaker instance is present.
	var _activate = instance_exists(pSpeaker);
	//if there isn't one, or it doesn't have an activation script, nothing happens.
	if (_activate == noone) or (_activate.speakerActivateScript == -1)
	{
		//DO NOTHING
	} 
	//but if there is one and it has an activation script, oPlayer will tell it to run it.
	else 
	{
		script_execute_ext(_activate.speakerActivateScript, _activate.speakerActivateArgs);
	}
	
}