function OutputVector = FindFitPropagation...
    (DataVector, xFit, varargin)

length_xData = length(DataVector) / 2;
xData = DataVector(1 : length_xData);
yData = DataVector(length_xData + 1 : end);

[xData, Indices] = sort(xData);
yData = yData(Indices);

yFit = ZFindFit(xData, yData, xFit, varargin{:});

OutputVector = [yFit; zeros(length(yFit), 1); 1];

end