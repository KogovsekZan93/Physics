function OutputVector = FindIntegralPropagation...
    (DataVector, xIntegral, varargin)

length_xData = length(DataVector) / 2;
xData = DataVector(1 : length_xData);
yData = DataVector(length_xData + 1 : end);

[xData, Indices] = sort(xData);
yData = yData(Indices);

yIntegral = ZFindIndefiniteIntegral(xData, yData, xIntegral, varargin{:});

% By setting the 'Validity' parameter to 1, all output vectors of the 
% FindIntegralPropagation function will be considered valid. 
Validity = 1;

% By setting the second part of the output vector of the 
% FindIntegralPropagation function as a vector of zeros, no distribution 
% of any of the values of the 'yIntegral' vector will be plotted. 
OutputVector = [yIntegral; zeros(length(yIntegral), 1); Validity];

end