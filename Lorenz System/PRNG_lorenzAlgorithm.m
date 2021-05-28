%% PSEUDO-RANDOM SEQUENCE GENERATOR WITH LORENZ SYSTEM
% The algorithm is based on the output time series obtained from the
% ode45() simulation. The three coordinates at every timestamp are summed
% together (after integer conversion) and then re-arranged to the interval
% [0, 255] with the modular operation.
%
% Initial conditions and system parameters are chosen arbitrarly as input.
% A True-Random Number Generator (TRNG) may be used to select the starting
% seed
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
disp('SYSTEM PARAMETER SELECTION');
sigma = input('sigma: ');
rho = input('rho: ');
beta = input('beta: '); 
disp('INITIAL CONDITION');
x0 = input('x0: ');
y0 = input('y0: ');
z0 = input('z0: ');
disp('SEQUENCE FEATURES: ')
N = input('Number of values in the sequence: ');
disp('IMPLEMENTATION')
select = input('Select implementation:\n1- First implementation\n2- Second implementation\n--> ');

offset = 99;                                % Delete the transient part
if (select == 1)
    N = N + offset;                         % Due to transient removal
else
    N = ceil(N/3) + offset;                 % Due to transient removal
end
p = [sigma; rho; beta];                     % [sigma, rho, beta]
s0 = [x0; y0; z0];                          % Initial state vector
dt = 0.0001;                                % Time step
t_start = dt;                               % Time start
t_end = N*dt;                               % Time end
tspan = t_start:dt:t_end;                   % Time interval


%% RUNNING ODE SIMULATION
%  ode45() takes as first input a function with two inputs (time and space)
%  and simulate the ODE system. Since lorenz() has been defined as a function 
%  with three inputs, the "p" input has been locked by the @(t, s) prefix
%  OUTPUT: is the time course with respective evolution of the system
% -----------------------------------------------------------------------------
options = odeset('RelTol', 1e-12, 'AbsTol', 1e-12*ones(1, 3));
[t, s] = ode45(@(t, x)lorenz(t, x, p), tspan, s0, options);

%% GENERATION OF NUMBER SEQUENCE
%  The detailed algorithm is presented in:
%  Lynnyk-Sakamoto-Celikovsky, "A pseudo-random number generator based on the
%  generalize lorenz chaotic system", In: IFAC-PapersOnLine 48.18 (2015). 
%  4th IFAC Conference on Analysis and Control of Chaotic Systems CHAOS 2015, 
%  pp. 257–261. issn: 2405-8963. 
%  doi: https: //doi.org/10.1016/j.ifacol.2015.11.046. 
%  url: https://www.sciencedirect.com/science/article/pii/S2405896315023046.
% -----------------------------------------------------------------------------

if (select == 1)
    % First implementation of the algorithm
    v = zeros(1, length(s) - offset);
    k = zeros(1, length(s) - offset);
    for i = 100:length(s)
        v(i-offset) = sum(s(i, :)) * 1e14;
        k(i-offset) = mod(v(i-offset), 256);
    end
else 
    % Second implementation of the algorithm
    w = zeros(1, length(s)  - offset);
    q = zeros(1, length(s)  - offset);
    for i = 100:length(s)
        w(3*(i-offset) - 2) = s(i, 1) * 1e14;
        w(3*(i-offset) - 1) = s(i, 2) * 1e14;
        w(3*(i-offset)) = s(i, 3) * 1e14;
        q(3*(i-offset) - 2) = mod(w(3*(i-offset) - 2), 256);
        q(3*(i-offset) - 1) = mod(w(3*(i-offset) - 1), 256);
        q(3*(i-offset)) = mod(w(3*(i-offset)), 256);
    end
end

%% PLOTTING RESULTS
% -----------------------------------------------------------------------------
if (select == 1)
    figure(1)
    histogram(k, 256, 'Normalization', 'pdf');
    xlabel('Number output');
    ylabel('Probability');
    box on
else
    figure(2)
    %histogram(q, 256, 'Normalization', 'pdf');
    probplot('normal', q)
    xlabel('Number output');
    ylabel('Probability');
    box on
end





