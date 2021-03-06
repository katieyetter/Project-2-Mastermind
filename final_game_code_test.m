%Merge of code written by Katie Yetter, Maria Rodriguez, and Madison Ewing
%April 19, 2021

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
DrawFormattedText(window, 'Mastermind',...
'center', screenYpixels * 0.1, white);

%board game 
%%rectangle outline
[xCenter, yCenter] = RectCenter(windowRect);
baseRect = [0 0 400 640];
Rect = nan(4, 3);
Rect = CenterRectOnPointd(baseRect, screenXpixels * 0.5, yCenter -30);
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
restartKey = KbName('p');
no = KbName('n');
xpos = screenXpixels * 0.38;
ypos = yCenter * 0.3;

Screen('Flip', window);
%%how to draw circles when key pressed in correct location 
colorpressed = [];
colorxpos = [];
colorypos = [];

%First: initiate random generated color sequence, new with each game
% r=red; b=blue; g=green; y=yellow;

setColors = ['r', 'b', 'g', 'y'];
pattern = randi(length(setColors), 1, 4);
generatedColors = strings(1,4);
for value = 1:length(pattern)
  generatedColors(value) = setColors(pattern(value));
end

numguesses = 1;
code_guess = 0;
checked = 0;

%Game introduction printed for user
fprintf('Welcome to Mastermind.\nI have chosen four colors.\nGuess the color and position.\nYou have 10 tries.\n\n');

while (numguesses < 11 && ~code_guess)
    checked = 0;
    
    while ~checked
        fprintf('Round %s \nPlease input your guess for the colors one at a time from left to right.\nColors may appear more than once and your choices are:\nr = red, b = blue, g = green, and y = yellow\n', string(numguesses));
        
        %Input user guesses as strings
        guessColors = strings(1,4);
      for ii = 1:4
        guessColors(ii) = input('Color: ','s');
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
        Rect = CenterRectOnPointd(baseRect, screenXpixels * 0.5, yCenter - 30);
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
        
        colorpressed = [colorpressed, guessColors(ii)];
        colorxpos = [colorxpos, xpos];
        colorypos = [colorypos, ypos];
        xpos = xpos + 100;
        clicks = clicks + 1;


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
    
            validInput = 0;
        
            %Make sure user made valid input
            for jj = 1:4
                for ii = 1:4
                compareInput = strcmp(guessColors(jj), setColors(ii));
                    if compareInput
                        validInput = validInput + 1;
                    end
                end
            end
        
        %If invalid input, error message and chance for user to re-enter
        %colors for this round
        if validInput ~= 4
            fprintf(2,'One or more entries was not a valid color.\nPlease re-enter colors, using only r b g or y\n\n');
            xpos = xpos - 400;
            clicks = clicks - 4;
            tries = tries - 1;
        elseif validInput == 4
            %Print colors and allow user to check that they inputted as
            %intended, with option to re-enter if not
            fprintf(2,'%s ',guessColors');
            colorCheck = input('\nAre these the correct colors you want to guess? (type c if correct, n if incorrect)', 's');
                if strcmp(colorCheck,'c')
                    checked = 1;
                else
                    colorpressed = colorpressed(1:end-4);
                    xpos = xpos - 400;
                    clicks = clicks - 4;
                    tries = tries - 1;
                    colorxpos(end-3:end) = [];
                    colorypos(end-3:end) = [];
                end
        end
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
        Rect = CenterRectOnPointd(baseRect, screenXpixels * 0.5, yCenter -30);
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
    
    correctPosition = 0;
    greenDots = zeros(1,4);
    %Find number of green dots - match color and position
    for ii = 1:4
        if strcmp(guessColors(ii),generatedColors(ii))
            correctPosition = correctPosition + 1;
            greenDots (ii) = 1;
        end
    end
    
    unmatchGuess = strings(1,(4-correctPosition));
    unmatchVec = strings(1,(4-correctPosition));
    incorrectVec = find(~greenDots);

    for ii = 1:length(incorrectVec)
        unmatchGuess(ii) = guessColors(incorrectVec(ii));
        unmatchVec (ii) = generatedColors(incorrectVec(ii));
    end

    correctColor = 0;
    %For any that didn't match, determine number of red dots - right color,
    %but in wrong position
    for ii = 1:length(unmatchGuess)
        for jj = 1:length(unmatchVec)
            if strcmp(unmatchGuess(ii), unmatchVec(jj))
                correctColor = correctColor + 1;
                unmatchVec(jj) = "";
            end
        end
    end

    %Output number of green and red dots to user
     %Output number of green and red dots to user
    fprintf('\nNumber of green dots (correct color and position) is %s \n', string(correctPosition));
    script = append('Number of green dots (correct color and position) is \n', string(correctPosition));
    fprintf('Number of red dots (correct color but not position) is %s \n\n', string(correctColor));
    green = 'Number of green dots';
    next = string(correctPosition); 
    Screen('TextSize', window, 70);
    DrawFormattedText(window, [green, next] ,screenXpixels * 0.1, screenYpixels * 0.4, white);
            %redraw everything 
        %board game 
        %display the name of game on top of the screen
        %%store pixels of screen
        [screenXpixels, screenYpixels] = Screen('WindowSize', window);
        Screen('TextSize', window, 70);
        Screen('TextFont', window, 'Times');
        DrawFormattedText(window, 'Mastermind',...
        'center', screenYpixels * 0.1, white);
        %%rectangle outline
        [xCenter, yCenter] = RectCenter(windowRect);
        baseRect = [0 0 400 640];
        Rect = nan(4, 3);
        Rect = CenterRectOnPointd(baseRect, screenXpixels * 0.5, yCenter - 30);
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
    fprintf('\nNumber of dots with correct color and position is %s \n', string(correctPosition));
    fprintf('Number of dots with correct color but not position) is %s \n\n', string(correctColor));
    
    %Message if user wins with number of rounds it took
    if correctPosition == 4
        %if user guesses correctly
        fprintf('You won!\nIt took you %s guesses\n',string(numguesses));
        code_guess = 1;
        youwin = 1;   
        Screen('TextFont', window, 'Courier');
        DrawFormattedText(window, 'You Won! :)', 'center', 'center', white);
        Screen('Flip', window);
        tries = 0;
        
    %Message if user fails to guess within 10 rounds
    elseif numguesses == 10
        %if user fails to guess correctly after 10 rounds
        fprintf('You lost\nThe correct sequence of colors is:\n')
        fprintf('%s ',generatedColors);
        code_guess = 1;
        Screen('TextFont', window, 'Courier');
        DrawFormattedText(window, 'You Lost! :(', 'center', 'center', white);
        Screen('Flip', window);
       
    end
    %Option to play again; if yes, generates new pattern of colors to guess
    if code_guess == 1
        play_again = input('\nWould you like to play again? (y/n):','s');
        if strcmp(play_again,'y')
            code_guess = 0;
            numguesses = 0;
            
            xpos = 710;
            ypos = 170-60;
            tries = -1;
            
            %%how to draw circles when key pressed in correct location 
            colorpressed = [];
            colorxpos = [];
            colorypos = [];
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
            Rect = CenterRectOnPointd(baseRect, screenXpixels * 0.5, yCenter -30);
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
           
            
            pattern = randi(length(setColors), 1, 4);
            generatedColors = strings(1,4);
            for value = 1:length(pattern)
                generatedColors(value) = setColors(pattern(value));
            end
        else
            fprintf('Thank you for playing Mastermind. You may exit the game now. Goodbye!\n');
        end
    end
    numguesses = numguesses + 1;
    ypos = ypos + 60;
    tries = tries + 1;
    clicks = 0;
    xpos = screenXpixels * 0.38;
end
Screen('Flip', window);