% Clear the workspace and the screen
sca;
close all;
clearvars;

%for PTB to run this line is needed
PsychDefaultSetup(2);

%set background to a gray screen
screens = Screen('Screens');
screenNumber = max(screens);
white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);
grey = white / 2;
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, grey);


%display the name of game on top of the screen
%%store pixels of screen
[screenXpixels, screenYpixels] = Screen('WindowSize', window);
Screen('TextSize', window, 70);
Screen('TextFont', window, 'Times');
DrawFormattedText(window, 'Mastermind',...
'center', screenYpixels * 0.1, white);


%how to play button and script
%%script
instructions = 'You have 10 opportunities \n to guess the code! \n After every try \n you will see a green dot \n if you guessed the \n correct position and color \n or a white dot if \n you guessed incorrectly';
keylegend = '\n\n Click y for a yellow circle \n Click r for a red circle \n Click b for a blue circle \n Click g for a green circle';
[screenXpixels, screenYpixels] = Screen('WindowSize', window);
Screen('TextSize', window, 30);
Screen('TextFont', window, 'Courier');
DrawFormattedText(window, [instructions,keylegend],...
screenXpixels * 0.05, screenYpixels * 0.3, white);
%%button for how to play
htprec = [0 0 200 75];
sideRect = CenterRectOnPointd(htprec, 1580, 350);
Screen('FillRect', window, white, sideRect);
%%text for how to play button
DrawFormattedText(window, 'How to Play', 1500, 358, black);

%exit button 
exrec = [0 0 200 75];
sideRect = CenterRectOnPointd(exrec, 1580, 600);
Screen('FillRect', window, white, sideRect);
%text that says exit
DrawFormattedText(window, 'Exit', 1540, 605, black);


%board game 
%%rectangle outline
[xCenter, yCenter] = RectCenter(windowRect);
baseRect = [0 0 600 840];
Rect = nan(4, 3);
Rect = CenterRectOnPointd(baseRect, screenXpixels * 0.5, yCenter);
Screen('FillRect', window, black, Rect);

%%trial rectangles
eachrect = [0 0 380 75];
ycor = 170;
trialRect = nan(4,3);
for i = 1:10 
    trialRect(:,i) = CenterRectOnPointd(eachrect, 866, ycor);
    ycor = ycor + 80;
end 
Screen('FillRect', window, white, trialRect);


%%dots to give feedback
feedbackSize = 20;
xscor = 1125;
yscor = 154;
for i = 1:10
    %top right
    Screen('DrawDots', window,[xscor; yscor], feedbackSize, [1 1 1], [], 2);
    %top left
    Screen('DrawDots', window,[xscor; yscor + 25], feedbackSize, [1 1 1], [], 2);
    %bottom left
    Screen('DrawDots', window,[xscor + 25; yscor], feedbackSize, [1 1 1], [], 2);
    %bottom right
    Screen('DrawDots', window,[xscor + 25; yscor+ 25], feedbackSize, [1 1 1], [], 2);
    yscor = yscor + 80;
end



%circles and keys that correspond to each color
%"full red" is [1 0 0]. "Full green" [0 1 0] and "full blue" [0 0 1]
buttonSize = 70;
Screen('DrawDots', window, [700; 1020], buttonSize, [1 0 0], [], 2);
Screen('DrawDots', window, [880; 1020], buttonSize, [0 1 0], [], 2);
Screen('DrawDots', window, [1060; 1020], buttonSize, [0 0 1], [], 2);
Screen('DrawDots', window, [1240; 1020], buttonSize, [1 1 0], [], 2);

%game logistics
% r = 21  g =  10   b = 5    y = 28 keyNames
clicks = 0;
tries = 0; 
%assing keys to colors
KbName('UnifyKeyNames');
yellow = KbName(28);
blue = KbName(5);
green = KbName(10);
red = KbName(21);
xpos = 700;
ypos = 120;
%how to draw circles when key pressed in correct location 
[keyIsDown,secs, keyCode] = KbCheck;
if keyIsDown && keyCode(red)
    Screen('DrawDots', window, [xpos; ypos], buttonSize, [1 0 0], [], 2);
    xpos = xpos + 150;
    clicks = clicks + 1;
elseif keyCode(yellow)
	Screen('DrawDots', window, [xpos; ypos], buttonSize, [1 0 0], [], 2); 
	x = x + 15;
	click = clicks + 1;
elseif keyCode(green)
	Screen('DrawDots', window, [xpos; ypos], buttonSize, [1 0 0], [], 2); 
	x = x + 15;
	click = clicks + 1;
elseif keyCode(blue)
	Screen('DrawDots', window, [xpos; ypos], buttonSize, [1 0 0], [], 2); 
	x = x + 15;
	click = clicks + 1;
%elseif keyCode(backspace) clicked
%	clicks = clicks - 1
%	delete circle at x y made
elseif clicks == 4
    ypos = ypos + 80;
%			    compare code to input
%				if code = input
%					display “you won”
%					display “play again” button
%               end
%				if code =~ input
%					num_greencircles = number of correct color + position 
%					chose random circles out of four possible circles and make them green							…
%					tries = tries +1 
%                   y = + 30
%               end
%           end
%if tries > 10
%	display “you lost”
%	display “play again” button 

Screen('Flip', window);

