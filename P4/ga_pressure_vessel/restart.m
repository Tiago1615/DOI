function restart()

clc   % Clear Command Window.
clear % Clear variables and functions from memory.
close all

% One simple way to avoid repeating the same random numbers in a new MATLAB session is 
% to choose a different seed for the random number generator. rng gives you an easy way 
% to do that, by creating a seed based on the current time. Each time you use 'shuffle', 
% it reseeds the generator with a different seed. You can call rng with no inputs to see 
% what seed it actually used.
rng shuffle 

end