//Before we do anything fun, we have to resize the application surface to match camera size.
//If we don't, the text boxes will only draw in the top corner of the window.
	surface_resize(application_surface, camera_get_view_width(view_camera[0]),camera_get_view_height(view_camera[0]));

//Now for the fun stuff!
//When a textbox appears, we want it to do a little animation rather than just appearing out of nowhere.
	//Next We set the starting coordinates and store them in variables we'll use for the current dimensions.
	x1 = (camera_get_view_width(view_camera[0])/2);//x1 is the left side of the textbox
	y1 = (camera_get_view_height(view_camera[0])-10);//y1 is the top of the textbox
	x2 = (camera_get_view_width(view_camera[0])/2);//x2 is the right side of the text box
	y2 = (camera_get_view_height(view_camera[0]));//y2 is the bottom of the text box
	
	//As well as the ending coordinates
	x1Target = 0;//where we want the left side to go
	x2Target = (camera_get_view_width(view_camera[0]));//where we want the right side to go
	y1Target = 0;//where we want the top to go
	y2Target = 30;//where we want the bottom to go


//lerpProgress represents the progress in the linear interpolation we're using to animate the text box.
	lerpProgress = 0;
//These variables will handle the text scrolling
	//The speed at which our characters will be drawn.
	textSpeed = .35;
	//textProgress represents the amount of characters that have been drawn.
	textProgress = 0;


//Set a the default for dialogue options
	responseSelected = 0;
	
	
//DICE CODE
//this function randomizes the seed for the game, making sure the dice rolls are actually random.
randomize();
//This variable will be used to trigger dice rolls when the game calls for them.
diceRollStart = false;
//These lines will create two random whole numbers between 1 and 6.
diceRoll1 = ceil(random(6));
diceRoll2 = ceil(random(6));
//This is the sum of those two dice.
diceTotal = diceRoll1 + diceRoll2;

//These lines of code are all for dice UI placement.
//Dice Box UI
	diceBoxX = (camera_get_view_width(view_camera[0]) * (9/24));//Dice box x-axis placement
	diceBoxWidth = (camera_get_view_width(view_camera[0]) * (1/4));//width of the dice box
	diceBoxY = 80;//Dice box y-axis placement
	diceBoxHeight = 40;//Height of the dice box
//Difficulty Class UI
	dcX = (camera_get_view_width(view_camera[0]) * (5/12));//diffculty class display box x-axis placement
	dcWidth = (camera_get_view_width(view_camera[0]) * (1/6));//width of the box
	dcY = 120;//diffculty class display box x-axis placement
	dcHeight = 30;//height of the box.
//Dice 
	diceX = (camera_get_view_width(view_camera[0])/2);//base x value for dice and text values.
	diceY = 100; //y value for both dice.