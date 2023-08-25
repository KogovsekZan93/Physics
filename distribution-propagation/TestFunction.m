function frepresent = TestFunction(DataPointsVector)
%TESTFUNCTION Summary of this function goes here
%   Detailed explanation goes here
length_xData = length(DataPointsVector) / 2;
xData = DataPointsVector(1 : length_xData);
yData = DataPointsVector(length_xData+ 1 : end);
[k, n] = FindSimpleLinearRegressionCoefficients(xData, yData);
rep_k=1;
rep_n=4;
validity = 1;
frepresent=[k; n; rep_k; rep_n; validity];

end