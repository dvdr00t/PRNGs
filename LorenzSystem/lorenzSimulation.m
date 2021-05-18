%% LORENZ SYSTEM SIMULATION
% This script provides the figure of the Lorenz System simulation
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
p = [10; 28; 8/3];                  % [sigma, rho, beta]
x0 = [0; 1; 20];                    % Initial state vector
dt = 0.0001;                        % Time step
t_start = dt;                       % Time start
t_end = 100;                         % Time end
tspan = t_start:dt:t_end;           % Time interval

%% RUNNING ODE SIMULATION
%  ode45() takes as first input a function with two inputs (time and space)
%  and simulate the ODE system. Since lorenz() has been defined as a function 
%  with three inputs, the "p" input has been locked by the @(t, x) prefix
%  OUTPUT: is the time course with respective evolution of the system
% -----------------------------------------------------------------------------
options = odeset('RelTol', 1e-12, 'AbsTol', 1e-12*ones(1, 3));
[t, x] = ode45(@(t, x)lorenz(t, x, p), tspan, x0, options);

%% PLOTTING RESULTS
% -----------------------------------------------------------------------------
figure(1)
plot3(x(:,1), x(:,2), x(:,3), 'LineWidth', 1.5)
xlabel('x');
ylabel('y');
zlabel('z');
grid on
box on



