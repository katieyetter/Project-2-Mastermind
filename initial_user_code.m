%Written by Madison Ewing
%April 3, 2021

%User Code

%Randomly generated ordered sequence of four colors
%Should be saved for entire game
color_vec = strings(1,4);
generatedcolors = randi (4,4,1);
for ii = 1:4
    if generatedcolors(ii) == 1
        color_vec(ii) = "red";
    elseif generatedcolors(ii) == 2
        color_vec(ii) = "blue";
    elseif generatedcolors(ii) == 3
        color_vec(ii) = "purple";
    elseif generatedcolors(ii) == 4
        color_vec(ii) = "orange";
    end
end
disp(color_vec);
numguesses = 1;
code_guess = 0;

disp('Welcome to Mastermind.');
disp('I have chosen four colors.');
disp('Guess the color and the position. You have ten tries.');

while (numguesses < 11 && ~code_guess)
    disp('Please input your guess for the colors one at a time from left to right');
    disp('Colors may appear more than once and your choices are:');
    disp('red, blue, purple, and orange');

    user_guess = strings(1,4);
    user_guess(1) = input('Color 1: ','s');
    user_guess(2) = input('Color 2: ','s');
    user_guess(3) = input('Color 3: ','s');
    user_guess(4) = input('Color 4: ','s');
    disp(user_guess)

    green_dots = zeros(1,4);
    for ii = 1:4
        green_dots (ii) = strcmp(user_guess(ii),color_vec(ii));
    
    end
    disp('green dots are')
    disp(green_dots); %correct color and position
    disp('num green is')
    num_green = sum(green_dots);
    disp(num_green);

    unmatch_guess = strings(1,(4-num_green));
    unmatch_vec = strings(1,(4-num_green));
    incorrect_vec = find(~green_dots);
    disp('incorrect vec is');
    disp(incorrect_vec);

    vec_count = 1;
    for ii = 1:length(incorrect_vec)
        unmatch_guess(vec_count) = user_guess(incorrect_vec(ii));
        unmatch_vec (vec_count) = color_vec(incorrect_vec(ii));
        vec_count = vec_count + 1;
    end

    num_red = 0;
    for ii = 1:length(unmatch_guess)
        for jj = 1:length(unmatch_vec)
            if strcmp(unmatch_guess(ii), unmatch_vec(jj))
                num_red = num_red + 1;
                unmatch_vec(jj) = "";
            end
        end
    end
    disp('num green is');
    disp(num_green);
    disp('num red is');
    disp(num_red);
    
    if num_green == 4
        disp('You won!');
        disp(append('It took you ',string(numguesses),' guesses.'));
        code_guess = 1;
        
    elseif numguesses == 10
        disp('You lost')
        disp('The correct sequence of colors is:')
        disp(color_vec);
        code_guess = 1;
    end
    numguesses = numguesses + 1;
end
