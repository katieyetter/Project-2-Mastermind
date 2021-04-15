%Merge of code written by Katie Yetter and Madison Ewing
%April 14, 2021

%First: initiate random generated color sequence
% r=red; b=blue; g=green; y=yellow;

setColors = ['r', 'b', 'g', 'y'];
pattern = randi(length(setColors), 1, 4);
generatedColors = strings(1,4);
for value = 1:length(pattern)
  generatedColors(value) = setColors(pattern(value));
end

numguesses = 1;
code_guess = 0;

disp('Welcome to Mastermind.');
disp('I have chosen four colors.');
disp('Guess the color and the position. You have ten tries.');

while (numguesses < 11 && ~code_guess)
    disp(append('Round ',string(numguesses)));
    disp('Please input your guess for the colors one at a time from left to right');
    disp('Colors may appear more than once and your choices are:');
    disp('r = red, b = blue, g = green, and y = yellow');

    guessColors = strings(1,4); %input user guesses as strings
    guessColors(1) = input('Color 1: ','s');
    guessColors(2) = input('Color 2: ','s');
    guessColors(3) = input('Color 3: ','s');
    guessColors(4) = input('Color 4: ','s');
    
    correctPosition = 0;
    greenDots = zeros(1,4);
    for ii = 1:4 %find number of green dots - match color and position
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
    %for any that didn't match, determine number of red dots - right color,
    %but in wrong position
    for ii = 1:length(unmatchGuess)
        for jj = 1:length(unmatchVec)
            if strcmp(unmatchGuess(ii), unmatchVec(jj))
                correctColor = correctColor + 1;
                unmatchVec(jj) = "";
            end
        end
    end
    
    disp(append('Number of green dots (correct color and position) is ', string(correctPosition)));
    disp(append('Number of red dots (correct color but not position) is ', string(correctColor)));
    
    if correctPosition == 4
        %if user guesses correctly
        disp('You won!');
        disp(append('It took you ',string(numguesses),' guesses.'));
        code_guess = 1;
        
        
    elseif numguesses == 10
        %if user fails to guess correctly after 10 rounds
        disp('You lost')
        disp('The correct sequence of colors is:')
        disp(generatedColors);
        code_guess = 1;
    end
    if code_guess == 1
        play_again = input('Would you like to play again? (y/n):','s');
        if strcmp(play_again,'y')
            code_guess = 0;
            numguesses = 0;
            
            pattern = randi(length(setColors), 1, 4);
            generatedColors = strings(1,4);
            for value = 1:length(pattern)
                generatedColors(value) = setColors(pattern(value));
            end
        else
            disp('Thank you for playing Mastermind. Goodbye!');
        end
    end
    numguesses = numguesses + 1;
end
