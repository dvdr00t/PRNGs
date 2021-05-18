function [out] = lorenz(t, sv, p)
% LORENZ 
% This function implements the non-linear behavior of the Lorenz system.
% --------------------------------------------------------------------------
% INPUTS:
%   - t: time interval vector
%   - sv: state vector containg the three coordinates of the system
%      |
%       --->    sv(1) = x
%               sv(2) = y
%               sv(3) = z
%   - p: the system parameters
%      |
%       --->    p(1) = sigma
%               p(2) = rho
%               p(3) = beta
%
% SYSTEM EQUATIONS:
%   out = [
%       p(1) * (sv(2) - sv(1));
%       sv(1) * (p(2) - sv(3)) - sv(2);
%       sv(1) * sv(2) - p(3) * sv(3);
%   ];
%
%
% @author Davide Arcolini
% @email s256671@studenti.polito.it
% @date 13/05/2021


%% SYSTEM EQUATIONS:
% --------------------------------------------------------------------------
  out = [
      p(1) * (sv(2) - sv(1));
      sv(1) * (p(2) - sv(3)) - sv(2);
      sv(1) * sv(2) - p(3) * sv(3);
  ];
end

