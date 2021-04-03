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
'center', screenYpixels * 0.5, [0 0 1]);
Screen('Flip', window);
KbStrokeWait;

%board game 

%keys that correspond to each color