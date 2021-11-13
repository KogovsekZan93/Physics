function [yFitPolyFit, varargout] = ZFindFitPolyFit(xData, yData, xFitPolyFit, PolyDegree, varargin)
%ZFITA Summary of this function goes here
%   Detailed explanation goes here


pars = inputParser;

paramName = 'xData';
errorMsg = '''xData'' must be a sorted column vector of numbers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) && ... 
    issorted(x), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'xFitPolyFit';
errorMsg = '''xFitPolyFit'' must be a sorted column vector of numbers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) && ... 
    issorted(x), errorMsg);
addRequired(pars, paramName, validationFcn);

parse(pars, xData, xFitPolyFit);

[yFitPolyFit, pFitPolyFit] = ZFindBasicFitPolyFit(xData, yData, xFitPolyFit, PolyDegree);

DrawZFitPolyFitHandle = @DrawZFitPolyFit;
DrawZFitPolyFitInput = {xData, yData, min(xData(1), xFitPolyFit(1)), max(xData(end), xFitPolyFit(end)), pFitPolyFit};
DecideIfDrawZ(DrawZFitPolyFitHandle, DrawZFitPolyFitInput, varargin{:});

varargout = {pFitPolyFit};

end

