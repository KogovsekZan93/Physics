function OutputVector = FindDerivativePropagation...
    (DataVector, xDerivative, varargin)

length_xData = length(DataVector) / 2;
xData = DataVector(1 : length_xData);
yData = DataVector(length_xData + 1 : end);

[xData, Indices] = sort(xData);
yData = yData(Indices);

yDerivative = ZFindDerivative...
    (xData, yData, xDerivative, varargin{:});

OutputVector = [yDerivative; zeros(length(yDerivative), 1); 1];

end