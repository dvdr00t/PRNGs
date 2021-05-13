%% LOGISTIC CHAOTIC MAP ANALYSIS
% This script provides the figure of the dynamic behavior under different
% seed parameters
%
% @author Davide Arcolini
% @email s256671@studenti.polito.it
% @date 13/05/2021
% -----------------------------------------------------------------------------
clear all
close all
clc

%% DATA GIVEN
% -----------------------------------------------------------------------------
iterations = [120, 110, 100];
initial_value = [0.4002, 0.4001, 0.4000];
mu = [3.8002, 3.8001, 3.8000];
values_BLU = zeros(1, iterations(1));
values_RED = zeros(1, iterations(2));
values_GREEN = zeros(1, iterations(3));


%% SIMULATING DYNAMIC SYSTEM
% -----------------------------------------------------------------------------
old_value = initial_value;
for i = 1:iterations(1)
    new_value = mu.*old_value.*(1-old_value);
    old_value = new_value;
    values_BLU(i) = new_value(1);
    if (i <= iterations(2))
        values_RED(i) = new_value(2);
    end
    if (i <= iterations(3))
        values_GREEN(i) = new_value(3);
    end 
end

%% PLOTTING RESULTS
% -----------------------------------------------------------------------------
x_BLU = 1:iterations(1);
x_RED = 1:iterations(2);
x_GREEN = 1:iterations(3);

figure(1)
hold on
box on
plot(x_GREEN, values_GREEN, 'g')
plot(x_RED, values_RED, 'r')
plot(x_BLU, values_BLU, 'b')
xlim([0 130])
xlabel('Iterations')
ylabel('Numbers')
title('Simulation of the system')
legend('\mu = 3.8000, x_0 = 0.4000, I = 100', ...
        '\mu = 3.8001, x_0 = 0.4001, I = 110', ...
        '\mu = 3.8002, x_0 = 0.4002, I = 120', ...
        'Location', 'SouthEast')

