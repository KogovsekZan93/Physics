function OutputVector = FindFitPropagation(DataVector, xFit, varargin)

length_xData = length(DataVector) / 2;
xData = DataVector(1 : length_xData);
yData = DataVector(length_xData + 1 : end);

[xData, Indices] = sort(xData);
yData = yData(Indices);

yFit = ZFindFit(xData, yData, xFit, varargin{:});

% By setting the 'Validity' parameter to 1, all output vectors of the 
% FindFitPropagation function will be considered valid. 
Validity = 1;

% By setting the second part of the output vector of the 
% FindFitPropagation function as a vector of zeros, no distribution of any 
% of the values of the 'yFit' vector will be plotted. 
OutputVector = [yFit; zeros(length(yFit), 1); Validity];

end