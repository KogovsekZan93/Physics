function DistributionWeighedValues = GetCustomDistribution...
(handle_ProportionalPDF, IntervalLimits, ...
N_ValuesInInterval, N_MaxRep)
%% Tool for creating a vector where the number of the 
%% repetition of each value is proportional to the 
%% probability density of the value
% 
% Author: Žan Kogovšek
% Date: 12.14.2023
% Last changed: 1.17.2024
% 
%% Description
% 
% Given the input vector 'IntervalLimits' of the lower and the 
% upper limit of the interval ['IntervalLimits'(1), 'IntervalLimits'(2)] 
% and the input number 'N_ValuesInInterval' of equally spaced 
% values of the X variable in the vector 'x_Spaced' = [x_1; x_2; 
% ...; x_('N_ValuesInInterval' - 1); x_('N_ValuesInInterval')] in the 
% interval ['IntervalLimits'(1), 'IntervalLimits'(2)] as well as the 
% input function handle 'handle_ProportionalPDF' of the function 
% fProportionalPDF, which is proportional to the probability 
% density function fPDF of the values of the X variable in the 
% interval ['IntervalLimits'(1), 'IntervalLimits'(2)], this function 
% returns the vector 'DistributionWeighedValues' in which each 
% of the values of the 'x_Spaced' vector is repeated the number 
% of times which is proportional to the probability density 
% function fPDF. 
% The number of repetitions of the most probable value of the 
% 'x_Spaced' vector is defined by the input 'N_MaxRep' number. 
% By using the MATLAB function datasample on the 
% 'DistributionWeighedValues' vector, the probability of each 
% value 'x_Spaced'(i) of the 'x_Spaced' vector being returned is 
% proportional to the fPDF probability density function value 
% fPDF('x_Spaced'(i)). This way, random generation of values 
% of a variable which has an arbitrary probability density function 
% fPDF is possible, as long a function fProportionalPDF, which 
% is proportional to the fPDF function, can be defined. 
% 
%% Variables
% 
% DistributionWeighedValues = GetCustomDistribution...
% (handle_ProportionalPDF, IntervalLimits, ...
% N_ValuesInInterval, N_MaxRep)
% 
% 'handle_ProportionalPDF' is the function handle of the 
% fProportionalPDF which is a function which is proportional to 
% the fPDF probability density function: 
% fProportionalPDF = a * fPDF, where a is an arbitrary positive 
% real number. The fProportionalPDF function must be a 
% function of a single argument which can be set as any value  
% from the interval ['IntervalLimits'(1), 'IntervalLimits'(2)], and 
% returns a nonnegative real number. 
% 
% 'IntervalLimits' is the column vector of two values, 
% 'IntervalLimits'(1) and 'IntervalLimits'(2), which are, 
% respectively, the lower and the upper limit of the closed 
% interval ['IntervalLimits'(1), 'IntervalLimits'(2)] over which the 
% fPDF probability density function is defined. It must be a 
% column vector of two real numbers, the second being greater 
% than the first. 
% 
% 'N_ValuesInInterval' is the number of equally spaced values 
% 'x_Spaced'(i) of the X variable from the ['IntervalLimits'(1), 
% 'IntervalLimits'(2)] interval. The repetition number in the output 
% 'DistributionWeighedValues' vector of each of the 
% 'N_ValuesInInterval' equally spaced values 'x_Spaced'(i) of 
% the ['IntervalLimits'(1), 'IntervalLimits'(2)] interval will be 
% proportional to the fPDF('x_Spaced'(i)) value. It must be a 
% natural number. 
% 
% 'N_MaxRep' is the maximum number of repetitions of any 
% given value 'x_Spaced'(i) in the 'DistributionWeighedValues' 
% vector. Because the number of repetitions of any given value 
% 'x_Spaced'(i) is proportional to the fPDF('x_Spaced'(i)) value 
% of the probability density function fPDF for that same given 
% value, the values with the greatest probability density will be 
% repeated 'N_MaxRep'-number of times in the 
% 'DistributionWeighedValues' vector. It must be a natural 
% number. 
% 
% 'DistributionWeighedValues' is the column vector which 
% contains the 'N_ValuesInInterval' equally spaced values 
% 'x_Spaced'(i) of the X variable in the 
% ['IntervalLimits'(1), 'IntervalLimits'(2)] interval. Each value 
% 'x_Spaced'(i) is repeated in the 'DistributionWeighedValues' 
% vector the number of times which is proportional to its fPDF 
% probability density function value fPDF('x_Spaced'(i)) such 
% that the greatest number of repetitions of any value of the 
% 'x_Spaced' vector is 'N_MaxRep'. 
% Despite the present description, the number 
% 'NVec_Repetition'(i) of the repetitions of the 'x_Spaced'(i) 
% value is not proportional to the fPDF('x_Spaced'(i)) value in 
% general because the value RelativefPDF(i) = 
% 'N_MaxRep' * (max(fPDF ('x_Spaced')) / fPDF('x_Spaced'(i))) 
% is not an integer in general. Instead the number 
% 'NVec_Repetition'(i) of repetitions of the 'x_Spaced'(i) value is 
% the RelativefPDF(i) value rounded to the closest integer. 


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

% In the following block of code, the 'NVec_Repetition' vector is 
% constructed. Each value 'NVec_Repetition'(i) of the 
% 'NVec_Repetition' vector is the number of repetitions of the 
% 'x_Spaced'(i) value in the 'DistributionWeighedValues' vector. 
NVec_Repetition = zeros(N_ValuesInInterval, 1);
for i=1 : N_ValuesInInterval
    NVec_Repetition(i) = handle_ProportionalPDF(x_Spaced(i));
end
NVec_Repetition = ...
    NVec_Repetition * N_MaxRep / max(NVec_Repetition);
NVec_Repetition = round(NVec_Repetition);

length_DistributionWeighedValues = sum(NVec_Repetition);
DistributionWeighedValues = ...
    zeros(length_DistributionWeighedValues, 1);

RunningIndex = 1;
for i=1 : N_ValuesInInterval
    DistributionWeighedValues(RunningIndex : ...
        RunningIndex + NVec_Repetition(i) - 1) = x_Spaced(i);
    RunningIndex = RunningIndex + NVec_Repetition(i);
end

end