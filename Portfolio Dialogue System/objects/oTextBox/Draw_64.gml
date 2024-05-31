//This tells the object how to draw the background sprite for the text box
//It stretches the center nine slices of the sprite to fit within the following coordinates.
var _textboxBottom = (y2Target + (lineCount*15));
{draw_sprite_stretched
(
	sTextBoxBg/*chosen sprite*/,
	background/*chosen frame within that sprite*/,
	x1/*left side of the text box*/,
	y1/*top of the text box*/,
	(x2-x1)/*width of the textbox*/,
	_textboxBottom/*height of the textbox*/
);}
//Here we set the font, alignment and color of the text and dropshadow.
draw_set_font(fText);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_gray);

//Here we grab a copy of the amount of text that has been scrolled through and store it in _print.
var _print = string_copy(messageText, 1, textProgress);

//Here we set the font, alignment and color of the text and dropshadow.
draw_set_font(fText);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_gray);
//here we draw the amount of text stored within _print, and set the color of the main text.
draw_text(x1+10, y1+8, _print);
draw_set_color(c_white);
draw_text(x1+10, y1+7, _print);


//All of the following code is responsible 
//if there are responses to the message, AND the text has finished scrolling....
if (responses[0] != -1) && (textProgress >= string_length(messageText))
{
	//using the array of responses, go through them each individually every frame.
	for (var i = 0; i < array_length(responses); i++)
	{
		{draw_sprite_stretched
			(
				sTextBoxBg/*chosen sprite*/,
				background/*chosen frame within that sprite*/,
				x1/*left side of the text box*/,
				_textboxBottom/*top of the text box*/,
				((x2-x1)/2)/*width of the textbox*/,
				(15 + (array_length(responses)*15))/*height of the textbox*/
			);}
		
		//Here we create an empty string and store it in a variable we are going to use for drawing text.
		//We do this because in order to add a selection marker to the beginning, we need to add it to the string first.
		var _printResponses = "";
		
		//if this response is the one we have selected...
		if (i == responseSelected)
		{
		//here is where we add our first selection marker to the beginning of our empty string
			if (i == responseSelected) {_printResponses += "> ";}
		//we add the response here to make sure it shows up between the selection markers
			_printResponses += responses[i];
		//here is where we add our last selection marker to the end of our string
			if (i == responseSelected) {_printResponses += " <"}
			
		//Here we draw the selected response and its drop shadow
			draw_set_color(c_gray);
			draw_text(x1+10, (_textboxBottom+(i*15)+6), _printResponses);
		//We set the text colour to Yellow on the selected response to make it stand out!
			draw_set_color(c_yellow);
			draw_text(x1+10, (_textboxBottom+(i*15)+5), _printResponses);
		}
		else
		{
		//if the response ISN'T the one we have selected, we add - to both ends of the response
			if (i != responseSelected) {_printResponses += "- ";}
		//add the response to our text storage variable.
			_printResponses += responses[i];
			if (i != responseSelected) {_printResponses += " -";}
		
		//Here we draw the selected response and its drop shadow
			draw_set_color(c_gray);
			draw_text(x1+10, (_textboxBottom+(i*15)+6), _printResponses);
		//We set the text colour on non-selected responses to white
			draw_set_color(c_white);
			draw_text(x1+10, (_textboxBottom+(i*15)+5), _printResponses);
		}
	}

	
	
	if (diceRollStart)
	{
		//Draw the dice box
			draw_sprite_stretched(sTextBoxBg, background, diceBoxX, diceBoxY, diceBoxWidth, diceBoxHeight);
		//Draw the dice
			draw_sprite(sDice, diceRoll1-1, diceX - 40, diceY);
			draw_sprite(sDice, diceRoll2-1, diceX, diceY);
			//draw_text_transformed(diceX - 40, diceY + textOffset, string(diceRoll1), 1.5, 1.5, 0);
			//draw_text_transformed(diceX, (diceY + textOffset), string(diceRoll2), 1.5, 1.5, 0);
		//Text Alignment and colour
			draw_set_halign(fa_center);
			draw_set_valign(fa_middle);
			draw_set_color(c_white);
		//Draw the Equation text
			draw_text_transformed(diceX - 20, diceY-3, "+", 2, 2, 0);
			draw_text_transformed(diceX + 20, diceY-3, "=", 2, 2, 0);
			draw_text_transformed(diceX + 40, diceY-3, string(diceTotal), 2, 2, 0);
		//Draw the difficulty class UI
			draw_sprite_stretched(sTextBoxBg, background, dcX, dcY, dcWidth, dcHeight);
			draw_text_transformed(diceX, dcY + 10, "DC = " + string(difficultyClass), 2, 2, 0);
			
			
	}
	
}


