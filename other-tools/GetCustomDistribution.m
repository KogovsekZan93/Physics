function DitributionWeighedValues = GetCustomDistribution...
(handle_DistributionFunction, IntervalLimits, ...
N_ValuesInInterval, N_MaxRep)

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

parse(pars, handle_DistributionFunction, IntervalLimits, ...
N_ValuesInInterval, N_MaxRep);

x = (linspace...
    (IntervalLimits(1), IntervalLimits(2), N_ValuesInInterval))';

y = zeros(N_ValuesInInterval, 1);
for i=1 : N_ValuesInInterval
    y(i) = handle_DistributionFunction(x(i));
end
y = y * N_MaxRep / max(y);
y = round(y);

length_DitributionWeighedValues = sum(y);
DitributionWeighedValues = ...
    zeros(length_DitributionWeighedValues, 1);

RunningIndex = 1;
for i=1 : N_ValuesInInterval
    DitributionWeighedValues...
        (RunningIndex : RunningIndex + y(i) - 1) = x(i);
    RunningIndex = RunningIndex + y(i);
end

end