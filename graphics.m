%Written by Maria Rodriguez
%debugged by Katie Yetter 

% make other keys invalid, how to restart game when you lose
% Clear the workspace and the screen
sca;
close all;
clearvars;

%for PTB to run this line is needed
Screen('Preference', 'SkipSyncTests', 1);
PsychDefaultSetup(2);
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
DrawFormattedText(window, 'Mastermind','center', screenYpixels * 0.1, white);

%board game 
%%rectangle outline
[xCenter, yCenter] = RectCenter(windowRect);
baseRect = [0 0 400 640];
Rect = nan(4, 3);
Rect = CenterRectOnPointd(baseRect, screenXpixels * 0.5, yCenter);
Screen('FillRect', window, black, Rect);

%%trial rectangles
eachrect = [0 0 380 55];
ycor = yCenter * 0.3;
trialRect = nan(4,3);
for i = 1:10 
    trialRect(:,i) = CenterRectOnPointd(eachrect, screenXpixels * 0.5, ycor);
    ycor = ycor + 60;
end 
Screen('FillRect', window, white, trialRect);


%circles and keys that correspond to each color
%"full red" is [1 0 0]. "Full green" [0 1 0] and "full blue" [0 0 1]
buttonSize = 70;
Screen('DrawDots', window, [screenXpixels * 0.2; screenYpixels * 0.95], buttonSize, [1 0 0], [], 2);
Screen('DrawDots', window, [screenXpixels * 0.4; screenYpixels * 0.95], buttonSize, [0 1 0], [], 2);
Screen('DrawDots', window, [screenXpixels * 0.6; screenYpixels * 0.95], buttonSize, [0 0 1], [], 2);
Screen('DrawDots', window, [screenXpixels * 0.8; screenYpixels * 0.95], buttonSize, [1 1 0], [], 2);

%game logistics
% r = 21  g =  10   b = 5    y = 28 keyNames
clicks = 0;
tries = 0;


%%assing keys to colors
KbName('UnifyKeyNames');
yellowKey = KbName('y');
blueKey = KbName('b');
greenKey = KbName('g');
redKey = KbName('r');
no = KbName('n');
xpos = screenXpixels * 0.38;
ypos = yCenter * 0.3;


Screen('Flip', window);
%%how to draw circles when key pressed in correct location 
colorpressed = [];
colorxpos = [];
colorypos = [];
while tries < 10
    
for i = 1:4
[secs, keyCode, deltaSecs] = KbWait(-1);
%display the name of game on top of the screen
%%store pixels of screen
[screenXpixels, screenYpixels] = Screen('WindowSize', window);
Screen('TextSize', window, 70);
Screen('TextFont', window, 'Times');
DrawFormattedText(window, 'Mastermind',...
'center', screenYpixels * 0.1, white);

%board game 
%%rectangle outline
[xCenter, yCenter] = RectCenter(windowRect);
baseRect = [0 0 400 640];
Rect = nan(4, 3);
Rect = CenterRectOnPointd(baseRect, screenXpixels * 0.5, yCenter);
Screen('FillRect', window, black, Rect);

%%trial rectangles
eachrect = [0 0 380 55];
ycor = yCenter * 0.3;
trialRect = nan(4,3);
for i = 1:10 
    trialRect(:,i) = CenterRectOnPointd(eachrect, screenXpixels * 0.5, ycor);
    ycor = ycor + 60;
end 
Screen('FillRect', window, white, trialRect);


%circles and keys that correspond to each color
%"full red" is [1 0 0]. "Full green" [0 1 0] and "full blue" [0 0 1]
buttonSize = 70;
Screen('DrawDots', window, [screenXpixels * 0.2; screenYpixels * 0.95], buttonSize, [1 0 0], [], 2);
Screen('DrawDots', window, [screenXpixels * 0.4; screenYpixels * 0.95], buttonSize, [0 1 0], [], 2);
Screen('DrawDots', window, [screenXpixels * 0.6;screenYpixels * 0.95], buttonSize, [0 0 1], [], 2);
Screen('DrawDots', window, [screenXpixels * 0.8;screenYpixels * 0.95], buttonSize, [1 1 0], [], 2);


if keyCode(redKey) 
    colorpressed = [colorpressed,'r'];
    colorxpos = [colorxpos, xpos];
    colorypos = [colorypos, ypos];
    xpos = xpos + 100;
    clicks = clicks + 1;
    
elseif keyCode(greenKey)  
    colorpressed = [colorpressed,'g'];
    colorxpos = [colorxpos, xpos];
    colorypos = [colorypos, ypos];
	xpos = xpos + 100;
	clicks = clicks + 1;
elseif keyCode(yellowKey)
    colorpressed = [colorpressed,'y'];
    colorxpos = [colorxpos, xpos];
    colorypos = [colorypos, ypos];
	xpos = xpos + 100;
	clicks = clicks + 1;

elseif keyCode(blueKey)
    colorpressed = [colorpressed,'b'];
    colorxpos = [colorxpos, xpos];
    colorypos = [colorypos, ypos];
	xpos = xpos + 100;
	clicks = clicks + 1;
elseif keyCode(no)
    colorpressed = colorpressed(1:end-4)%delete the last four
    xpos = xpos - 400
    clicks = clicks - 4;
    tries = tries - 1;
end

for n = 1:length(colorpressed)
    buttonSize = 50;
    if colorpressed(n) == 'r'
        Screen('DrawDots', window, [colorxpos(n); colorypos(n)], buttonSize, [1 0 0], [], 2);
    elseif colorpressed(n) == 'g'
        Screen('DrawDots', window, [colorxpos(n); colorypos(n)], buttonSize, [0 1 0], [], 2);
    elseif colorpressed(n) == 'y'
        Screen('DrawDots', window, [colorxpos(n); colorypos(n)], buttonSize, [1 1 0], [], 2);
    elseif colorpressed(n) == 'b'
        Screen('DrawDots', window, [colorxpos(n); colorypos(n)], buttonSize, [0 0 1], [], 2);
    end

end
Screen('Flip', window);
WaitSecs(.3);
end
ypos = ypos + 60;
tries = tries + 1;
clicks = 0;
disp(tries)
xpos = screenXpixels * 0.38;

%Screen('Flip',window);
end
if tries >= 10 || youlose == 1
    Screen('TextFont', window, 'Courier');
    lost = 'You Lost! :(';   
    DrawFormattedText(window, lost, 'center', 'center', white);
    %code to play again 
end
Screen('Flip', window);

if youwin == 1
    Screen('TextFont', window, 'Courier');
    win = 'You Won! :) \n Number of tries:';
    numguesses = string(numguesses);
    DrawFormattedText(window, [win,numguesses], 'center', 'center', white);
    tries = 0;
end
Screen('Flip', window);

    
    

