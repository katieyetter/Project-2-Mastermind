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
screenXpixels * 0.1, screenYpixels * 0.1, white);


%how to play button and script
%%script
instructions = 'You have 10 opportunities \n to guess the code! \n After every try \n you will see a green dot \n if you guessed the \n correct position and color \n or a white dot if \n you guessed incorrectly';
keylegend = '\n\n Click y for a yellow circle \n Click r for a red circle \n Click b for a blue circle \n Click g for a green circle';
[screenXpixels, screenYpixels] = Screen('WindowSize', window);
Screen('TextSize', window, 30);
Screen('TextFont', window);
DrawFormattedText(window, [instructions,keylegend],...
screenXpixels * 0.1, screenYpixels * 0.3, white);
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
baseRect = [0 0 200 280];
squareXpos = [screenXpixels * 0.5];
numSqaures = length(squareXpos);
sizeChanger = [3];
% Make our rectangle coordinates
Rect = nan(4, 3);
for i = 1:numSqaures
    Rect(:, i) = CenterRectOnPointd(baseRect .* sizeChanger(i),...
        squareXpos(i), yCenter);
end
% Draw the rect to the screen
Screen('FillRect', window, black, Rect);

%%trial rectangles
eachrect = [0 0 150 75];
ycor = 717;
for i = 1:10 
centeredRect = CenterRectOnPointd(eachrect, xCenter, ycor + 80);
end 
Screen('FillRect', window, white, centeredRect);



%circles and keys that correspond to each color
%"full red" is [1 0 0]. "Full green" [0 1 0] and "full blue" [0 0 1]
buttonSize = 70;
Screen('DrawDots', window, [700; 1020], buttonSize, [1 0 0], [], 2);
Screen('DrawDots', window, [880; 1020], buttonSize, [0 1 0], [], 2);
Screen('DrawDots', window, [1060; 1020], buttonSize, [0 0 1], [], 2);
Screen('DrawDots', window, [1240; 1020], buttonSize, [1 1 0], [], 2);

%figure out how to draw circle when click
% r = 21  g =  10   b = 5    y = 28 keyNames
clicks = 0 
tries = 0 

%while tries <= 10 
%			if r clicked
%				draw red circle in position x y
%				x = x + 15
%				click = clicks + 1
%           elseif y clicked
%				yellow circle in position x y 
%				x = x + 15
%				click = clicks + 1
%           elseif g clicked
%				green circle in position x y 
%				 x = x + 15
%				click = clicks + 1
%           elseif b clicked
%				blue circle in position x y 
%				x = x + 15
%				click = clicks + 1	
%           elseif backspace clicked
%			    clicks = clicks - 1
%			    delete circle at x y made
%            elseif clicks = 4 
%			    compare code to input
%				if code = input
%					display “you won”
%					display “play again” button
%				if code =~ input
%					num_greencircles = number of correct color + position 
%					chose random circles out of four possible circles and make them green							…
%					tries = tries +1 
%                   y = + 30
%if tries > 10
%	display “you lost”
%	display “play again” button 

Screen('Flip', window);

