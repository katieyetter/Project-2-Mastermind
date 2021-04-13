%for PTB to run this line is needed
Screen('Preference','SkipSyncTests',1);
ScreenTest;

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
keylegend = '\n click y for a yellow circle \n click r for a red circle \n click b for a blue circle \n click g for a green circle';
[screenXpixels, screenYpixels] = Screen('WindowSize', window);
Screen('TextSize', window, 30);
Screen('TextFont', window);
DrawFormattedText(window, [instructions,keylegend],...
screenXpixels * 0.1, screenYpixels * 0.3, white);
%%button for how to play


%board game 
%%rectangle outline
% Get the centre coordinate of the window
[xCenter, yCenter] = RectCenter(windowRect);
% Make a base Rect of 200 by 200 pixels
baseRect = [0 0 200 280];
% Screen X positions of our three rectangles
squareXpos = [screenXpixels * 0.5];
numSqaures = length(squareXpos);
% Make a multiplier to modulate the size of our squares
sizeChanger = [3];
% Make our rectangle coordinates
Rect = nan(4, 3);
for i = 1:numSqaures
    Rect(:, i) = CenterRectOnPointd(baseRect .* sizeChanger(i),...
        squareXpos(i), yCenter);
end
% Draw the rect to the screen
Screen('FillRect', window, black, Rect);


%circles and keys that correspond to each color
dotXpos = screenXpixels * 0.8;
dotYpos = screenYpixels + 290;
buttonSize = 50;
Screen('DrawDots', window, [dotXpos + 50; dotYpos], buttonSize, [0 1 0]);
Screen('DrawDots', window, [dotXpos + 100; dotYpos], buttonSize, [1 0 0]);
Screen('DrawDots', window, [dotXpos + 150; dotYpos], buttonSize, [0 0 1]);
Screen('DrawDots', window, [dotXpos + 175; dotYpos], buttonSize, [0 1 1]);

Screen('Flip', window);

%exit button 