%% LYAPUNOV EXPONENT TRAJECTORIES COMPUTATION
% This script provides the figure of the Lyapunov exponent simulation
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
x0 = [0; 1; 20];                    % Initial state vector for trajectory 1
eps = 1e-9;                         % Delta between the trajectories
x0_dist = x0 + [0; 0; eps];         % Initial state vector for trajectory 2
dt = 0.0001;                        % Time step
t_start = dt;                       % Time start
t_end = 30;                        % Time end
tspan = t_start:dt:t_end;           % Time interval

%% RUNNING ODE SIMULATION
%  ode45() takes as first input a function with two inputs (time and space)
%  and simulate the ODE system. Since lorenz() has been defined as a function 
%  with three inputs, the "p" input has been locked by the @(t, x) prefix
%  OUTPUT: is the time course with respective evolution of the system
% -----------------------------------------------------------------------------
options = odeset('RelTol', 1e-12, 'AbsTol', 1e-12*ones(1, 3));
[t, x] = ode45(@(t, x)lorenz(t, x, p), tspan, x0, options);
[t_dist, x_dist] = ode45(@(t, x)lorenz(t, x, p), tspan, x0_dist, options);

%% COMPUTING DISTANCE BETWEEN THE TRAJECTORIES
% -----------------------------------------------------------------------------
d = sqrt(abs(x(:, 1)-x_dist(:, 1)).^2 + abs(x(:, 2)-x_dist(:, 2)).^2 + abs(x(:, 3)-x_dist(:, 3)).^2);
slope = 0.934100195835882;

%% PLOTTING THE RESULTS
% -----------------------------------------------------------------------------
figure(1)
semilogy(d)
xlabel('time')
hold on
x = tspan(1:250000);
semilogy(.8e-9 * exp(slope*x), 'k--')
legend('dist(traj_1, traj_2)', sprintf('exp(%1.2f x)', slope), ...
    'location', 'northwest')
grid on
box on


