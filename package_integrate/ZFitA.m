function [yFitA, varargout] = ZFitA(xData, yData, xFitA, varargin)
%ZFITA Summary of this function goes here
%   Detailed explanation goes here


pars = inputParser;

paramName = 'xData';
errorMsg = '''xData'' must be a sorted column vector of numbers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) && ... 
    issorted(x), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'xFitA';
errorMsg = '''xFitA'' must be a sorted column vector of numbers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) && ... 
    issorted(x), errorMsg);
addRequired(pars, paramName, validationFcn);

parse(pars, xData, xFitA);


[FigureParameter, vararginBasic] = SeparateOptionalParameter(varargin, 'Figure');

[yFitA, Ipoints, Smatrix] = ZBasicFitA(xData, yData, xFitA, vararginBasic{:});

DrawZIntegralAInput = {xData, yData, min(xData(1), xFitA(1)), max(xData(end), xFitA(end)), Ipoints, Smatrix};
DrawZIntegralAHandle = @DrawZFitA;
DecideIfDrawZ(DrawZIntegralAHandle, DrawZIntegralAInput, FigureParameter{:});

varargout = {Ipoints, Smatrix};

end

