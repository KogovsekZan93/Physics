function OutputVector = FindDerivativePropagation...
    (DataVector, xDerivative, varargin)

length_xData = length(DataVector) / 2;
xData = DataVector(1 : length_xData);
yData = DataVector(length_xData + 1 : end);

[xData, Indices] = sort(xData);
yData = yData(Indices);

yDerivative = ZFindDerivative(xData, yData, xDerivative, varargin{:});

% By setting the 'Validity' parameter to 1, all output vectors of the 
% FindDerivativePropagation function will be considered valid. 
Validity = 1;

% By setting the second part of the output vector of the 
% FindDerivativePropagation function as a vector of zeros, no distribution 
% of any of the values of the 'yDerivative' vector will be plotted. 
OutputVector = [yDerivative; zeros(length(yDerivative), 1); Validity];

end