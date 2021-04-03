%Written by Madison Ewing
%April 3, 2021

%User Code

%Randomly generated ordered sequence of four colors
%Should be saved for entire game
color_vec = strings(1,4);
generatedcolors = randi (4,4,1);
for ii = 1:4
    if generatedcolors(ii) == 1;
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
numguesses = 0;

disp('Welcome to Mastermind.');
disp('I have chosen four colors.');
disp('Guess the color and the position. You have ten tries.');
disp('Please input your guess for the colors one at a time from left to right');
disp('Colors may appear more than once and your choices are:');
disp('red, blue, purple, and orange');

user_guess = strings(1,4);
user_guess(1) = input('Color 1: ','s');
user_guess(2) = input('Color 2: ','s');
user_guess(3) = input('Color 3: ','s');
user_guess(4) = input('Color 4: ','s');
disp(user_guess)

white_dots = zeros(1,4);
for ii = 1:4
    white_dots (ii) = strcmp(user_guess(ii),color_vec(ii));
    
end
disp('white dots are')
disp(white_dots); %correct color and position
disp('num white is')
num_white = sum(white_dots);
disp(num_white);

unmatch_guess = strings(1,(4-num_white));
unmatch_vec = strings(1,(4-num_white));
incorrect_vec = find(~white_dots);
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
disp('num white is');
disp(num_white);
disp('num red is');
disp(num_red);

