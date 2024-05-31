//here we set lerpProgress to slow as it approaches 1 by adding half of the difference between 1 and itself each frame.
	lerpProgress += (1 - lerpProgress) / 50;

//here we update textProgress by adding textSpeed each frame. This creates the text scroll effect.
	textProgress += textSpeed;

//here we update the dimensions of the text box with a linear interpolation(lerp) according to lerpProgress
	x1 = lerp(x1, x1Target, lerpProgress);
	x2 = lerp(x2, x2Target, lerpProgress);
	y1 = lerp(y1, y1Target, lerpProgress);
	y2 = lerp(y2, y2Target, lerpProgress);


//Grab a inputs for up and down.
	upKey = keyboard_check_pressed(ord("W")) + keyboard_check_pressed(vk_up)+ gamepad_button_check_pressed(4, gp_padu);
		upKey = clamp(upKey, 0, 1);
	downKey = keyboard_check_pressed(ord("S")) + keyboard_check_pressed(vk_down)+ gamepad_button_check_pressed(4, gp_padd);
		downKey = clamp(downKey, 0, 1);
		
	//Grab the result from our inputs to decide on a selected response if a dice roll isn't happening.
	if (!diceRollStart){responseSelected += (downKey - upKey);};
	
	//Wrap the text so you cannot select responses that don't exist.
	var _max = array_length(responses) - 1;
	var _min = 0;
	if (responseSelected > _max) {responseSelected = _min;}
	if (responseSelected < _min) {responseSelected = _max;}
	
	

//Here we give the spacebar two major functions.
if (keyboard_check_pressed(vk_space))
{

	//Here we establish a responseScripts value that will trigger a dice roll to decide an outcome.
	if (responseScripts[responseSelected] == 777)
	{
		//We set diceRollStart to true to start a bit of code in our Draw GUI event.
		//That code draws two d6s according to some randomly generated numbers stored in 2 diceRoll variables from the create event.
		diceRollStart = true;
		
		//We then grab the sum of both dice and see if it meets or beats the set difficulty class
		if (diceTotal >= difficultyClass)
		//If the dice are higher or lower, we'll change the number we feed into our dialogueResponses function accordingly
		{responseScripts[responseSelected] = successCase;}
		else {responseScripts[responseSelected] = failureCase;};
	}
	//NEW---------------
	else
	{
		//This local variable stores the length of the desired message.
		var _messageLength = string_length(messageText);
		//If the text scroll is complete when spacebar is pressed, we can run our code.
		if (textProgress >= _messageLength)
		{
			//if there are dialogue options...
			if (responses[0] != -1)
			{
				//tell the instance that created this textbox to run the dialogueResponses function...
				//and feed it the response we had selected when the key was pressed.
				with (originInstance) {dialogueResponses(other.responseScripts[other.responseSelected]);};
			}
		
			//once the function has or hasn't run, destroy the current instance.
			instance_destroy();
		
			//once the object is destroyed, check for queued text and decrement their queue placement.
			//This should cause the next queued text to become a textbox.
			if (instance_exists(oTextQueued))
			{
				with(oTextQueued) {ticket--;};
			}
		
		}
		else
		{
			//If the text scroll isn't complete, we skip the scrolling and complete the message.
			if (textProgress > 2) {textProgress = _messageLength;};
		}
	}
}

