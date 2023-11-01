function pDerivative = ...
    CalculateDerivativePolynomialCoefficients(p, ordDeriv)
%% Tool for calculating the coefficients of the derivative of 
%% a polynomial
% 
% Author: Žan Kogovšek
% Date: 5.1.2023
% Last changed: 11.1.2023
% 
%% Description
% 
% Given the vector of coefficients 'p' of the polynomial fp 
% (Y = fp(X)) and the natural number 'ordDeriv', this function 
% returns the vector of coefficients of the polynomial 
% fp_('ordDeriv'), which is the 'ordDeriv'-th order derivative of the 
% fp polynomial. 
% 
%% Variables
% 
% This function has the form of pDerivative = ...
% CalculateDerivativePolynomialCoefficients(p, ordDeriv)
% 
% 'p' is the vertical vector of the coefficients of the polynomial 
% fp (Y = fp(X)). The polynomial fp has the form fp(X) = 
% 'a_n' * (X^n) +  'a_(n - 1)' * (X^(n - 1)) + ... + 'a_1' * X + 'a_0' 
% and the 'p' vector must have the form 
% ['a_n'; 'a_(n - 1)'; ...; 'a_1'; 'a_0']. 
% 
% 'pDerivative' is the vertical vector of the coefficients of the 
% polynomial fp_('ordDeriv') (Y = fp_('ordDeriv')(X)), which is 
% the 'ordDeriv'-th order derivative of the fp polynomial. The 
% polynomial fp_('ordDeriv') has the form fp_('ordDeriv')(X) = 
% ('b_n' * (X^(n - 'ordDeriv')) +  
% 'b_(n - 1)' * (X^( n - 'ordDeriv' - 1)) + ... 
%  + 'b_('ordDeriv' + 1)' * X + 'b_('ordDeriv')'. Each 'b_m' 
% coefficient has the value 'b_m' == 
% 'a_m' * (m!) / ((m - 'ordDeriv')!) and the 'p_Derivative' vector 
% has the form 
% ['b_n'; 'b_(n - 1)'; ...; 'b_('ordDeriv' + 1)'; 'b_('ordDeriv')']. 
% The fp_('ordDeriv') polynomial can be evaluated by the 
% MATLAB polyval function (fp_('ordDeriv')(X) = 
% polyval('p_Derivative', X)). 
% 
% 'ordDeriv' is the derivative order. It must be a natural number. 


pars = inputParser;

paramName = 'p';
errorMsg = '''p'' must be a column vector of numbers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x), ...
    errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'ordDeriv';
errorMsg = '''ordDeriv'' must be a natural number.';
validationFcn = @(x)assert(isnumeric(x) && isscalar(x) && ...
    x >= 1 && mod(x,1) == 0, errorMsg);
addRequired(pars, paramName, validationFcn);

parse(pars, p, ordDeriv);

pLength = length(p);
pDerivative = zeros(pLength - ordDeriv, 1);

for i = 1 : pLength - ordDeriv
    pDerivative(i) = ...
        p(i) * factorial(pLength - i) / factorial(pLength - i - ordDeriv);
end

end