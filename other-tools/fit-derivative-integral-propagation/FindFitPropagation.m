function OutputVector = FindFitPropagation(DataVector, xFit, varargin)

length_xData = length(DataVector) / 2;
xData = DataVector(1 : length_xData);
yData = DataVector(length_xData + 1 : end);

[xData, Indeces] = sort(xData);
yData = yData(Indeces);

yFit = ZFindFit(xData, yData, xFit, varargin{:});

OutputVector = [yFit; zeros(length(yFit), 1); 1];

end