function DitributionWeighedValues = GetCustomDistribution...
(handle_ProportionalPDF, IntervalLimits, ...
N_ValuesInInterval, N_MaxRep)
%% Tool for creating a vector where the number of the 
%% repetition of each value is proportional to the 
%% probability density of the value
% 
% Author: Žan Kogovšek
% Date: 12.14.2023
% Last changed: 12.14.2023
% 
%% Description
% 
% Given the input vector 'IntervalLimits' of the lower and the 
% upper limit of the interval ['IntervalLimits'(1), 'IntervalLimits'(2)] 
% and the input number 'N_ValuesInInterval' of equally spaced 
% values in the vector 'x_Spaced' = [x_1; x_2; ...; 
% x_('N_ValuesInInterval' - 1); x_('N_ValuesInInterval')] in the 
% interval ['IntervalLimits'(1), 'IntervalLimits'(2)] as well as the 
% input function handle 'handle_ProportionalPDF' of the function 
% fProportionalPDF, which is proportional to the probability 
% density function fPDF of the values in the interval 
% ['IntervalLimits'(1), 'IntervalLimits'(2)], this function returns the 
% vector 'DitributionWeighedValues' in which each of the values 
% of the 'x_Spaced' vector is repeated the number of times 
% which is proportional to the probability density function fPDF. 
% The number of repetitions of the most probable value of the 
% 'x_Spaced' vector is defined by the input 'N_MaxRep' number. 
% By using the MATLAB function datasample on the 
% 'DitributionWeighedValues' vector, the probability of each 
% value of the 'x_Spaced' vector being returned is proportional 
% to the fPDF probability density function. This way, random 
% generation of values of a variable which has an arbitrary 
% probability density function fPDF is possible, as long as the 
% function fProportionalPDF, which is proportional to the fPDF 
% function, can be defined. 
% 
%% Variables
% 
% DitributionWeighedValues = GetCustomDistribution...
% (handle_ProportionalPDF, IntervalLimits, ...
% N_ValuesInInterval, N_MaxRep)
% 
% 'handle_ProportionalPDF' ....
% 
% 'IntervalLimits' .....
% 
% 'N_ValuesInInterval' ...
% 
% 'N_MaxRep' ...
% 
% 'DitributionWeighedValues' ...
% 
% 'xData' and 'yData' are the vectors of the values of the 
% independent variable X and of the dependent variable Y, 
% respectively, of the linear function Y = f(X) = X * a + b 
% ('yData' = f('xData')) where the a and the b parameters are to 
% be estimated by this function by using simple linear 
% regression. 
% Both the 'xData' vector and the 'yData' vector must be column 
% vectors of equal length and of real numbers. 
% 
% 'varargin' represents the additional input parameter 
% 'CovarMat_yData'. 'CovarMat_yData' is the covariance matrix 
% of the values of the 'yData' vector. It must be a matrix of real 
% numbers. 


pars = inputParser;

paramName = 'handle_DistributionFunction';
errorMsg = ...
    '''handle_DistributionFunction'' must be a function handle.';
validationFcn = @(x)assert(isa(x, 'function_handle'), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'IntervalLimits';
errorMsg = ...
    '''IntervalLimits'' must be a sorted column vector of two numbers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) ...
    && length(x) == 2 && x(2) > x(1), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'N_ValuesInInterval';
errorMsg = '''N_ValuesInInterval'' must be a natural number.';
validationFcn = @(x)assert(isnumeric(x) && isscalar(x) && ...
    mod(x,1) == 0 && x > 0, errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'N_MaxRep';
errorMsg = '''N_MaxRep'' must be a natural number.';
validationFcn = @(x)assert(isnumeric(x) && isscalar(x) && ...
    mod(x,1) == 0 && x > 0, errorMsg);
addRequired(pars, paramName, validationFcn);

parse(pars, handle_ProportionalPDF, IntervalLimits, ...
N_ValuesInInterval, N_MaxRep);

x_Spaced = (linspace...
    (IntervalLimits(1), IntervalLimits(2), N_ValuesInInterval))';

y = zeros(N_ValuesInInterval, 1);
for i=1 : N_ValuesInInterval
    y(i) = handle_ProportionalPDF(x_Spaced(i));
end
y = y * N_MaxRep / max(y);
y = round(y);

length_DitributionWeighedValues = sum(y);
DitributionWeighedValues = ...
    zeros(length_DitributionWeighedValues, 1);

RunningIndex = 1;
for i=1 : N_ValuesInInterval
    DitributionWeighedValues...
        (RunningIndex : RunningIndex + y(i) - 1) = x_Spaced(i);
    RunningIndex = RunningIndex + y(i);
end

end