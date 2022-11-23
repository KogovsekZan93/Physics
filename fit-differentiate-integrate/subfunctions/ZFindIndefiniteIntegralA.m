function yIndefiniteIntegralA = ZFindIndefiniteIntegralA...
    (xData, yData, xIntegralA, varargin)
%% Numerical piecewise regression polynomial-based 
%% indefinite integration tool with visualization
% 
% Author: Žan Kogovšek
% Date: 11.12.2022
% Last changed: 11.23.2022
% 
%% Description
% 
% Given the input vector "xData" of the independent variable X 
% and the input vector "yData" of the values of the dependent 
% variable Y of an arbitrary function Y = (df/dX)(X), this function 
% returns the vector "yIndefiniteIntegralA" of the estimated 
% values of f("xIntegralA") - f("xIntegralA"(1)), where "xIntegralA" 
% is the input vector of values of the X variable. The estimation 
% is based on a piecewise regression polynomial of the data 
% points represented by the pairs ("xData"(i), "yData"(i)). 
% The optional parameter "Figure" can be used to plot the 
% estimated curve of the df/dX function and the area under it 
% from "xIntegralA"(1) to "xIntegralA"(end) along with the data 
% points. 
% 
%% Variables
% 
% This function has the form of yIndefiniteIntegralA = ...
% ZFindIndefiniteIntegralA(xData, yData, xIntegralA, varargin)
% 
% "xData" and "yData" are the vectors of the values of the 
% independent variable X and of the dependent variable Y, 
% respectively, of an arbitrary function Y = (df/dX)(X) 
% ("yData" = (df/dX) ("xData")). 
% Both the "xData" vector and the "yData" vector must be 
% column vectors of equal length and of real numbers. The 
% values of the "xData" vector must be in ascending order. 
% 
% "xIntegralA" is the vector of the values of the independent 
% variable X at which the values of the vector 
% f("xIntegralA") - f("xIntegralA"(1)) is to be estimated. 
% The "xIntegralA" vector must be a column vector of real 
% numbers. The values of the "xIntegralA" vector must be in 
% ascending order. 
% 
% "varargin" represents the optional input parameter "Figure". 
% "Figure" is the parameter the value of which is the index of the 
% figure on which the data points along with the estimation of the 
% df/dX function is to be plotted. Also, the area under the 
% estimated df/dX function curve is filled from 
% min("xIntegralA"(1)) to max("xIntegralA"(2)). The value of the 
% "Figure" parameter can be any nonnegative integer. The 
% default value is "0", at which no figure is to be plotted. 

% "varargin" represents the optional input parameters 
% "PseudoAccuracy", "Mode", and "Figure". 
%     "PseudoAccuracy" is the name of the parameter the value 
%     of which is the order of the regression polynomials from 
%     which the piecewise regression polynomial which 
%     represents the df/dX function is composed. It must be a 
%     nonnegative integer. The default value is "0". 
%     "Mode" is the name of the parameter the value of which 
%     represents the principle behind the definition of the 
%     boundaries of the piecewise regression polynomial which 
%     represents the df/dX function. It must be one of the three 
%     integers: "0", "1", "2". The default value is "0". 
%     "Figure" is the name of the parameter the value of which is 
%     the index of the figure on which the data points along with 
%     the estimation of the df/dX function is to be plotted. Also, 
%     the area under the estimated df/dX function curve is filled 
%     from min("xIntegralA"(1)) to max("xIntegralA"(2)). The value 
%     of the "Figure" parameter can be any nonnegative integer. 
%     The default value is "0", at which no figure is to be plotted. 
% 
% "yIndefiniteIntegralA" is the column vector of the estimated 
% values of f("xIntegralA") - f("xIntegralA"(1)). 


pars = inputParser;

paramName = 'xIntegralA';
errorMsg = ...
    '''xIntegralA'' must be a sorted column vector of numbers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) && ... 
    issorted(x), errorMsg);
addRequired(pars, paramName, validationFcn);

parse(pars, xIntegralA);

[FigureParameter, NonFigureParameters] = ...
    SeparateAdditionalParameter(varargin, 'Figure');

[yIndefiniteIntegralA, Ipoints, Smatrix] = ZFindIntegralABasic...
    (xData, yData, xIntegralA, NonFigureParameters{:});

% The following block of code deals with plotting the estimated 
% curve of the df/dX function and the area under it from 
% "xIntegralA"(1) to "xIntegralA"(end) along with the data points. 

DrawZIntegralAHandle = @DrawZIntegralA;
ColorFace = [0, 0, 1];
DrawZIntegralAInput = ...
    {xData, yData, xIntegralA(1), xIntegralA(end), ColorFace, ...
    Ipoints, Smatrix};
DecideIfDrawZ(DrawZIntegralAHandle, DrawZIntegralAInput, ...
    FigureParameter{:});

end