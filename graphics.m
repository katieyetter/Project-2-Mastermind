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
Screen('TextFont', window, 'Courier');
DrawFormattedText(window, 'Mastermind',...
'center', screenYpixels * 0.3, [0 0 1]);
Screen('Flip', window);
KbStrokeWait;

%how to play button and script


%board game 

%%rectangle outline

%%rectangle for each try
% Get the centre coordinate of the window
[xCenter, yCenter] = RectCenter(windowRect);

% Make a base Rect of 200 by 200 pixels
baseRect = [0 0 200 200];

% Screen X positions of our three rectangles
squareXpos = [screenXpixels * 0.25...
    screenXpixels * 0.5 screenXpixels * 0.75];
numSqaures = length(squareXpos);

% Set the colors to Red, Green and Blue
allColors = [1 0 0; 0 1 0; 0 0 1];

% Make a multiplier to modulate the size of our squares
sizeChanger = [1 3 1];
% Make our rectangle coordinates
allRects = nan(4, 3);
for i = 1:numSqaures
    allRects(:, i) = CenterRectOnPointd(baseRect .* sizeChanger(i),...
        squareXpos(i), yCenter);
end
% Draw the rect to the screen
Screen('FillRect', window, allColors, allRects);


%%four dots per try
dotColor = [1 0 0];
dotXpos = rand * screenXpixels;
dotYpos = rand * screenYpixels;
dotSizePix = 20;
%top left
Screen('DrawDots', window, [dotXpos; dotYpos], dotSizePix, dotColor, [],2);
%top right 
Screen('DrawDots', window, [dotXpos dotXpos + 15; dotYpos dotYpos],dotSizePix, dotColor, [], 2);
Screen('Flip', window);


%circles and keys that correspond to each color

%exit button 