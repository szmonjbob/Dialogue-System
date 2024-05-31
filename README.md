Hello!
If you're here to review my code, allow me to give you a rundown of what to look for!

There are 4 main files that are very important to the functioning of this system.

textFunctions is a script and it is the most important file in this game.
if contains two functions, both of which are equally important

1:newTextBox is the function responsible for generating new text boxes.
  it creates a new object, and turns it into an oTextQueued if a textbox is already present.
  if there isn't one, that object becomes an oTextBox instead.
  all but one of it's arguments are optional, but each one grants more customizability. They are as follows:
  newTextBox("desired text string" , number of lines that string contains , selected background sprite , [any number of dialogue options] , dice roll difficulty class , dice win case , dice loss case)

2:dialogueResponses is the function that figures out how to respond to your choices.
  it is a long switch statement where each case is a response to certain dialogue options.
  most responses wind up calling newTextBox and populating its arguments.


Next most important is oTextBox, which is responsible for drawing the entire UI, as well as handling dice rolls.
while it's create event is does establish important variables, the step and draw events are the most important.
The step event is responsible for handling which dialogue option you pick and, determining if it calls for dice, and a bunch of other things. 
Its main if statement carries the weight of the game on it's shoulders.

oPlayer isn't super important, it's only responsible for initiating dialogue and nothing else.

You'll likely see reference to pSpeaker instances a fair amount. 
It's barely an object, it's more like 9 fluctuating variable definitions in a trenchcoat.
it is used to create the contents of the first dialogue box.
it has no code attached to it, everything it does is because other objects and scripts are telling it to.
  
