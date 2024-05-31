function newTextBox( )
{
	//inititialize the new text box as a variable called _obj.
	var _obj;
	//if a textbox already exists, set _obj as a queued textbox.
	if (instance_exists(oTextBox)) 
	{_obj = oTextQueued;} 
	//otherwise set _obj to be a textbox
	else {_obj = oTextBox;}
	//create _obj as an instance with the following properties
	with (instance_create_layer(0,0, "Instances", _obj))
	{
		//Establish argument 0 as message text.
		messageText = argument[0];
		//Establish the speaker instance responsible for creating the text box.
		//We do this because the oPlayer doesn't create the text boxes, it simply urges speaker instances to do so.
		if (instance_exists(other)) {originInstance = other.id;}
		else {originInstance = noone;};
	
		//Establish the potential argument 1 as the number of lines present in the text box, we'll use this for box height
		if (argument_count > 1) {lineCount = argument[1];}
		else {lineCount = 1;};
	
		//Establish the potential Argument 2 as the number that stores your selected text box sprite.
		//If there is no argument 1 to grab, set background to 1.
		if (argument_count > 2) {background = argument[2];}
		else {background = 1;};
		
		//Establish the potential Argument 3 of the function as an array of responses.
		if (argument_count > 3)
		{
			//argument 3 being an array causes game maker to fall apart when attempting to set (responses = argument[3])...
			//So instead we use array_copy to steal the contents of argument[3] and place them inside of responses.
			responses = [];
			array_copy(responses, 0, argument[3], 0, array_length(argument[3]));
			
			//Trim the script markers from the responses
			//i increments through the strings in the array and performs the following actions...
			for (var i = 0; i < array_length(responses); i++)
			{
				//We set the position of the script markers by finding a colon on response[i]
				var _markerPosition = string_pos(":", responses[i]);
				//We then get a copy of the text preceeding the colon, and store it in responseScripts[i]
				responseScripts[i] = string_copy(responses[i], 1, _markerPosition-1);
				//We turn that copy of text into a number that can be used later and update responseScript[i]
				responseScripts[i] = real(responseScripts[i]);
				//and finally we cut the script markers by deleting every character until the marker position.
				responses[i] = string_delete(responses[i], 1, _markerPosition);
			}
			
			//NEW-------------------
			if (argument_count > 4){
				difficultyClass = argument[4];
				successCase = argument[5];
				failureCase = argument[6];
			}
			//NEW---------------------
		}
		else
		{
			//If there isn't an argument 2 present, then set responses and responseScripts to null.
			//otherwise they would be fed into the dialogue responses function and cause issues.
			responses = [-1];
			responseScripts = [-1];
			diceRollStart = false;
		}
	}
}



function dialogueResponses()
{
	//This function determines how the game will respond to your dialogue choices!
	//It does so by grabbing the number we stored in responseScripts to select one of the following cases...
	//each of which either run the newTextBox function or break the dialogue sequence.
	switch(argument0)
	{
		case 0: break;
		//INTRO QUESTIONS!!!!
		//Response to being asked who is there.
			case 1: newTextBox("oh, you know, just a disembodied voice hiding behind the thin transparent barrier \nthat seperates you from the untold horrors that lie in the barren, data based \nwasteland beyond the scope of your small, mortal mind.", 2);
					newTextBox("It's not terribly important. Just pretend that I live in your computer. \nNow answer the question!", 1, 0, ["2:Please leave me alone.", "4:What was the question?","10:I'm doing well","11:I'm barely holding it together."]); break;
					
		//Response to being asked to leave the player alone.
			case 2: newTextBox("Uh..."); 
					newTextBox("Sure man, whatever you want."); 
					newTextBox("..."); 
					newTextBox("..."); 
					newTextBox("..."); 
					newTextBox("Okay please talk to me, it's extremely boring out here in the untold horrors.", 0, 0, ["3:I really just want you to stop.","4:Okay fine, what do you want?"]); break;
					
		//Response to the player reaffirming their desire to be left alone.
			case 3: newTextBox("Suit yourself."); 
					newTextBox("Ya big 'ol jerk."); break;
			
		//Response to being asked to reask the question.
			case 4: newTextBox("I just want to know how you're doing!", 0, 0, ["10:I'm doing well, I suppose.","11:I'm barely holding it together."]); break;
			
		//The actual meat of the dialogue begins!
		//If the player is doing well
			case 10: newTextBox("That's great to hear! Care to roll some dice?", 0, 0, ["20:Ooh, I love gambling!", "12:I'm not sure, sell me on the concept.","16:Nah, I'm good"]); break;
		//If the player is not doing well
			case 11: newTextBox("That isn't concerning at all!"); 
					 newTextBox("Care to roll some dice to lighten your spirits?", 0, 0, ["21:I have nothing left to lose", "17:Why are you so sure it'll lift my spirits?", "19:Nothing can help me."]); break;
			
		//Response to being asked to sell them on rolling dice.
			case 12: newTextBox("Well first of all, it's fun!", 0, 0, ["20:That's all I need! Lets roll!", "13:Tell me more...","14:Nah, I'm not a fan of fun personally"]); break;
		//When being urged to continue selling.
			case 13: newTextBox("Do you really need more than fun to be sold?", 0, 0, ["20:Nah, you're right. Let's get rolling!","14:Yes, I don't like fun."]); break;
		//When being told the player doesn't enjoy fun.
			case 14: newTextBox("..."); 
					 newTextBox("Are you being serious?", 0, 0, ["15:Deadly.","20:Nah, I'm just messing with you. Let's roll some dice!"]); break;
		//When being told that the player really doesn't enjoy fun. RESULTS IN CONVO END
			case 15: newTextBox("..."); 
					 newTextBox("Well."); 
					 newTextBox("This has been nice.");
					 newTextBox("But I think I'd rather deal with the horrors than you."); break;
		//When being told outright they aren't interested.
			case 16: newTextBox("Fair enough, I guess I'll talk to you later!"); break;
			
			
			
		//When being asked to elaborate by a sad person
			case 17: newTextBox("Okay..."); 
					 newTextBox("Well first of all, it's fun."); 
					 newTextBox("And you look like you could use some fun.", 0, 0, ["21:If this doesn't work, it's your fault.", "18:What do you mean by that?"]); break;
		//When asked what they mean by that
			case 18: newTextBox("Nothing."); 
					 newTextBox("Nothing at all."); 
					 newTextBox("Anyways, wanna roll some dice?", 0, 0, ["21:I have nothing better to do.", "19:No, I'd rather wallow."]); break;
		//When told that nothing can help them.
			case 19: newTextBox("I'm starting to think that maybe you're right.");
					 newTextBox("It's been nice talking to ya, I guess."); break;
			
			
			
		//Positive Dice Roll
			case 20: newTextBox("Lets roll!", 0, 0, ["777:Roll those dice!(DC = 5)"], 5, 23, 24); break;
		//Negative Dice Roll
			case 21: newTextBox("Okay, how about you give them a roll!", 0, 0, ["777:Roll the dice sadly.(DC = 3)"], 3, 23, 24); break;
		//Dice Roll Win
			case 23: newTextBox("ooh, nice luck!"); break;
		//Dice Roll Lose
			case 24: newTextBox("better luck next time!"); break;
		
		
		default: newTextBox("YOU FUCKED IT UP BRO!!"); break;
	}
}