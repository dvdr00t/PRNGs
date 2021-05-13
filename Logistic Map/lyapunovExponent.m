function LE = lyapunovExponent(mu_start, mu_end, mu_step )
% @brief calculates Lyapunov exponent of logistic map for mu within the interval (mu_start, mu_end) 
% X_{n+1} = mu*x_n*(1-x_n)
% using derivative for values of control parameter from mu_start to mu_nd with step mu_step
% --------------------------------------------------------------------------
% INPUT
%  - mu_start - first value of control parameter mu
%  - mu_end   - last values of control parameter mu
%  - mu_step  - step
% OUTPUT
%  - LE     - values of estimated Lyapunov exponent
%
% @author Davide Arcolini
% @email s256671@studenti.polito.it
% @date 13/05/2021

%% DATA GIVEN
% --------------------------------------------------------------------------
mu_values = mu_start:mu_step:mu_end;  
points = length(mu_values);
iterations = 1000;
LE = zeros(1, points);
x = zeros(1, iterations+1);
x(1) = 0.1;    

%% EVALUATING THE EXPONENT
% --------------------------------------------------------------------------
for k = 1:points
  sum = 0;
  for i = 1:iterations
    x(i+1) = mu_values(k)*x(i)*(1-x(i));
    sum = sum + log(abs(mu_values(k)-2*mu_values(k)*x(i)));   
  end
  LE(k) = sum/iterations;     
end