%% LOGISTIC CHAOTIC MAP ANALYSIS
% This script provides the figure of the logistic map
%
%  The mathematical expression of logistic equation is:
%               
%                 X_{n+1} = mu * X_n * (1 - X_n)
%
%
% @author Davide Arcolini
% @email s256671@studenti.polito.it
% @date 13/05/2021
% -----------------------------------------------------------------------------
clear all
close all
clc

%% DEFINING DATA STRUCTURE
% -----------------------------------------------------------------------------
values = [];
initial_value = 0.5;
mu_start = 0;
mu_increment = 0.0005;
mu_end = 4;
trans_iter = 5000;
steadystate_iter = 10000;
tol = 1e-3;

%% RUNNING LOOP FOR VALUES GEENRATION
%  The external loop runs the different value of the system parameter mu.
%  The internal loops run for eliminating the transient part and evaluating
%  the final value associated to that particular mu value
% -----------------------------------------------------------------------------
for mu = mu_start:mu_increment:mu_end
    
    % Printing mu
    mu
    
    % value_old corresponds to X_n in the iteration of the algorithm
    value_old = initial_value;
    
    % Running through all the iterations during the transient phase
    % The value obtained will be stored only when it reaches the steady state
    % value
    for i = 1:trans_iter
        value_new = (value_old - value_old^2) * mu;     % Rewriting the logistic equation
        value_old = value_new;
    end
    value_ss = value_new;
    
    % Running through all the iterations during the steady state phase
    for i = 1:steadystate_iter
        value_new = (value_old - value_old^2) * mu;     % Rewriting the logistic equation
        value_old = value_new;
        
        % Storing values
        values(1, length(values)+1) = mu;
        values(2, length(values)) = value_new;
        
        % Checking steady state conditon
        if (abs(value_ss - value_new) < tol)
            break
        end
    end
end

%% PLOTTING THE RESULTS
% -----------------------------------------------------------------------------
figure(1)
plot(values(2,:), 4-values(1,:), '.', 'LineWidth', 0.1, 'MarkerSize', 0.4)
set(gca, 'YTick', [0 1 2 3 4], 'YTickLabels', {'4', '3', '2', '1', '0'})
title('Logistic Chaotic Map')
ylabel('\mu')
xlabel('Number')
box on
grid on












