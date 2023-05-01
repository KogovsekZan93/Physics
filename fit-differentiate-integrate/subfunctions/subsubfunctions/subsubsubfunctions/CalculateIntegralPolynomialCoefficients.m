function pIntegral = CalculateIntegralPolynomialCoefficients(p)
%% Tool for calculating the coefficients of an indefinite 
%% integral of a polynomial
% 
% Author: Žan Kogovšek
% Date: 5.1.2023
% Last changed: 5.1.2023
% 
%% Description
% 
% Given the vector of coefficients "p" of the polynomial fp 
% (Y = fp(X)), this function returns the vector of coefficients of 
% the polynomial Fp, which is the indefinite integral of the fp 
% polynomial the value of which at X = 0 is Fp(X) = 0. 
% 
%% Variables
% 
% This function has the form of pIntegral = ...
% CalculateIntegralPolynomialCoefficients(p)
% 
% "p" is the vertical vector of the coefficients of the polynomial 
% fp (Y = fp(X)). The polynomial fp has the form fp(X) = 
% "a_n" * (X^n) +  "a_(n - 1)" * (X^(n - 1)) + ... + "a_1" * X + "a_0" 
% and the "p" vector must have the form 
% ["a_n"; "a_(n - 1)"; ...; "a_1"; "a_0"]. 
% 
% "pIntegral" is the vertical vector of the coefficients of the 
% polynomial Fp (Y = Fp(X)), which is the indefinite integral of 
% the fp polynomial the value of which at X = 0 is Fp(X) = 0. The 
% polynomial Fp has the form Fp(X) = 
% ("a_n" / (n + 1)) * (X^(n + 1)) +  ("a_(n - 1)" / n) * (X^(n)) + ... 
%  + ("a_1" / 2) * X + "a_0" * X + 0 and the "pIntegral" vector has 
% the form ["a_n" / (n + 1); "a_(n - 1)" / n; ...; "a_1" / 2; "a_0"; 0]. 
% The Fp polynomial can be evaluated by the MATLAB polyval 
% function (Fp(X) = polyval("pIntegral", X)). 


pars = inputParser;

paramName = 'p';
errorMsg = '''p'' must be a column vector of numbers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x), ...
    errorMsg);
addRequired(pars, paramName, validationFcn);

parse(pars, p);

pIntegral = [p./(length(p) : -1 : 1)'; 0];

end