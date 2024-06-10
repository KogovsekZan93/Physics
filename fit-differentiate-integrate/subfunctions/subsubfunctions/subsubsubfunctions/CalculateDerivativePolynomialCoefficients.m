function pDerivative = CalculateDerivativePolynomialCoefficients...
    (p, OrdDeriv)
%% Tool for calculating the coefficients of the derivative of polynomial
% 
% Author: Žan Kogovšek
% Date: 5.1.2023
% Last changed: 6.5.2024
% 
%% Description
% 
% Given the vector of coefficients 'p' of the polynomial fp (Y = fp(X)) 
% and the natural number 'OrdDeriv', this function returns the vector of 
% coefficients of the polynomial fp_('OrdDeriv'), which is the 
% 'OrdDeriv'-th order derivative of the fp polynomial. 
% 
%% Variables
% 
% This function has the form of pDerivative = ...
% CalculateDerivativePolynomialCoefficients(p, OrdDeriv)
% 
% 'p' is the vertical vector of the coefficients of the polynomial fp 
% (Y = fp(X)). The polynomial fp has the form fp(X) = 
% 'a_n' * (X^n) +  'a_(n - 1)' * (X^(n - 1)) + ... + 'a_1' * X + 'a_0' 
% and the 'p' vector must have the form 
% ['a_n'; 'a_(n - 1)'; ...; 'a_1'; 'a_0']. 
% 
% 'pDerivative' is the vertical vector of the coefficients of the 
% polynomial fp_('OrdDeriv') (Y = fp_('OrdDeriv')(X)), which is the 
% 'OrdDeriv'-th order derivative of the fp polynomial. The polynomial 
% fp_('OrdDeriv') has the form fp_('OrdDeriv')(X) = 
% ('b_n' * (X^(n - 'OrdDeriv')) + 
% 'b_(n - 1)' * (X^( n - 'OrdDeriv' - 1)) + ... 
%  + 'b_('OrdDeriv' + 1)' * X + 'b_('OrdDeriv')'. Each 'b_m' coefficient 
% has the value 'b_m' = 'a_m' * (m!) / ((m - 'OrdDeriv')!) and the 
% 'p_Derivative' vector has the form 
% ['b_n'; 'b_(n - 1)'; ...; 'b_('OrdDeriv' + 1)'; 'b_('OrdDeriv')']. 
% The fp_('OrdDeriv') polynomial can be evaluated by the MATLAB polyval 
% function (fp_('OrdDeriv')(X) = polyval('p_Derivative', X)). 
% 
% 'OrdDeriv' is the derivative order. It must be a natural number. 


pars = inputParser;

paramName = 'p';
errorMsg = '''p'' must be a column vector of numbers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'OrdDeriv';
errorMsg = '''OrdDeriv'' must be a natural number.';
validationFcn = @(x)assert(isnumeric(x) && isscalar(x) && x >= 1 && ...
    mod(x,1) == 0, errorMsg);
addRequired(pars, paramName, validationFcn);

parse(pars, p, OrdDeriv);

pLength = length(p);
pDerivative = zeros(pLength - OrdDeriv, 1);

for i = 1 : pLength - OrdDeriv
    pDerivative(i) = ...
        p(i) * factorial(pLength - i) / factorial(pLength - i - OrdDeriv);
end

end