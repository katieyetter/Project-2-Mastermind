%Written by Madison Ewing
%April 3, 2021

%User Code

%First: initiate random generated color sequence
% r=red; b=blue; p=purple; o=orange;
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
disp(user_guess);

for ii = 1:4
    white_dots = strcmp(user_guess(ii),color_vec(ii));
    disp(white_dots);
end