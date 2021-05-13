function [value] = logistic(initial_value, iterations, parameter)

% LOGISTIC 
% This function implements the non-linear behavior of the logistic map.
% --------------------------------------------------------------------------
% INPUTS:
%   - initial_value: the initial value of the system (i.e. x_0)
%   - iterations: the number of iterations of the logistic equation
%   - parameter: the system parameter (i.e. mu)
%
% @author Davide Arcolini
% @email s256671@studenti.polito.it
% @date 13/05/2021

old_value = initial_value;
mu = parameter;
for i = 1:iterations
    new_value = mu*old_value*(1-old_value);
    old_value = new_value;
end

% Output
value = new_value;
end

