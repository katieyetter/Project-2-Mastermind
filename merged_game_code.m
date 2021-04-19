%Merge of code written by Katie Yetter and Madison Ewing
%April 14, 2021

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
        guessColors(1) = input('Color 1: ','s');
        guessColors(2) = input('Color 2: ','s');
        guessColors(3) = input('Color 3: ','s');
        guessColors(4) = input('Color 4: ','s');
    
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
        elseif validInput == 4
            %Print colors and allow user to check that they inputted as
            %intended, with option to re-enter if not
            fprintf(2,'%s ',guessColors');
            colorCheck = input('\nAre these the correct colors you want to guess? (type c if correct, n if incorrect)', 's');
                if strcmp(colorCheck,'c')
                    checked = 1;
                end
        end
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
    fprintf('\nNumber of green dots (correct color and position) is %s \n', string(correctPosition));
    fprintf('Number of red dots (correct color but not position) is %s \n\n', string(correctColor));
    
    %Message if user wins with number of rounds it took
    if correctPosition == 4
        %if user guesses correctly
        fprintf('You won!\nIt took you %s guesses\n',string(numguesses));
        code_guess = 1;
        youwin == 1;   
    %Message if user fails to guess within 10 rounds
    elseif numguesses == 10
        %if user fails to guess correctly after 10 rounds
        fprintf('You lost\nThe correct sequence of colors is:\n')
        fprintf('%s ',generatedColors);
        code_guess = 1;
        youlose == 1;
    end
    
    %Option to play again; if yes, generates new pattern of colors to guess
    if code_guess == 1
        play_again = input('\nWould you like to play again? (y/n):','s');
        if strcmp(play_again,'y')
            code_guess = 0;
            numguesses = 0;
            
            pattern = randi(length(setColors), 1, 4);
            generatedColors = strings(1,4);
            for value = 1:length(pattern)
                generatedColors(value) = setColors(pattern(value));
            end
        else
            fprintf('Thank you for playing Mastermind. Goodbye!\n');
        end
    end
    numguesses = numguesses + 1;
end
