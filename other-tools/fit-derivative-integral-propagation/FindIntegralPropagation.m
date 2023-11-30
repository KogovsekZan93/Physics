function OutputVector = FindIntegralPropagation...
    (DataVector, xIntegral, varargin)

length_xData = length(DataVector) / 2;
xData = DataVector(1 : length_xData);
yData = DataVector(length_xData + 1 : end);

[xData, Indices] = sort(xData);
yData = yData(Indices);

yIntegral = ZFindIndefiniteIntegral...
    (xData, yData, xIntegral, varargin{:});

OutputVector = [yIntegral; zeros(length(yIntegral), 1); 1];

end