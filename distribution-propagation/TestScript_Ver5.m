handle_DistributionFunction = @(x)power(1 + power(x, 2), -1);
IntervalLimits = [-2; 4];
N_ValuesInInterval = 100;
N_MaxRep = 10;

DitributionWeighedValues = GetCustomDistribution...
(handle_DistributionFunction, IntervalLimits, ...
N_ValuesInInterval, N_MaxRep)