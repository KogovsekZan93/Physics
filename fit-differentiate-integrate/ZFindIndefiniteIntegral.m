function yIndefiniteIntegral = ZFindIndefiniteIntegral...
    (xData, yData, xIntegral, varargin)
%% Numerical indefinite integration tool
% 
% Author: Žan Kogovšek
% Date: 8.14.2022
% Last changed: 5.26.2024
% 
%% Description
% 
% Given the input vector 'xData' of the independent variable X and the 
% input vector 'yData' of the values of the dependent variable Y of an 
% arbitrary function Y = (df/dX)(X), this function returns the vector 
% 'yIndefiniteIntegral' of the estimated values of 
% f('xIntegral') - f('xIntegral'(1)), where 'xIntegral' is the input 
% vector of values of the X variable. 
% By setting the optional parameters, the user can: 
%    (1) choose from various methods of the estimation, some of which 
%        offer additional optional parameters and output variables or need 
%        additional required parameters, 
%    (2) plot the estimated curve of the df/dX function and the area under 
%        it from 'xIntegral'(1) to 'xIntegral'(end) along with the data 
%        points represented by the pairs ('xData'(i), 'yData'(i)). 
% 
%% Variables
% 
% This function has the form of yIndefiniteIntegral = ...
% ZFindIndefiniteIntegral(xData, yData, xIntegral, varargin)
% 
% 'xData' and 'yData' are the vectors of the values of the independent 
% variable X and of the dependent variable Y, respectively, of an 
% arbitrary function Y = (df/dX)(X) ('yData' = (df/dX) ('xData')). 
% Both the 'xData' vector and the 'yData' vector must be column vectors of 
% equal length and of real numbers. The values of the 'xData' vector must 
% be in ascending order. 
% 
% 'xIntegral' is the vector of the values of the independent variable X at 
% which the values of the vector f('xIntegral') - f('xIntegral'(1)) is to 
% be estimated. The 'xIntegral' vector must be a column vector of real 
% numbers. The values of the 'xIntegral' vector must be in ascending 
% order. 
% 
% 'varargin' represents the additional input parameters. The basic 
% optional parameters are named ''Type'' and ''Figure''. 
%    -''Type'' is the name of the parameter the value of which determines 
%     the mathematical method with which the df/dX function is estimated. 
%     The value of the 'Type' parameter can either be ''A'', ''Spline'', 
%     or ''PolyFit''. The default value is ''A''. The value of the 'Type' 
%     parameter determines the set of the additional required or optional 
%     input parameters. 
%    -''Figure'' is the name of the parameter the value of which is the 
%     index of the figure window on which the data points along with the 
%     estimation of the df/dX function is to be plotted. Also, the area 
%     under the estimated df/dX function curve is filled from 
%     min('xIntegral'(1)) to max('xIntegral'(2)). 
%     The value of the 'Figure' parameter can be any nonnegative integer. 
%     The default value is 0, at which no figure is to be plotted. 
% 
% 'yIndefiniteIntegral' is the column vector of the estimated 
% values of f('xIntegral') - f('xIntegral'(1)). 


[TypeList, TypeDeletedList] = SeparateOptionalParameter...
    (varargin, 'Type');   % Separation of the 'Type' parameter from the 
                          % other optional input parameters. 

pars = inputParser;

paramName = 'Type';
defaultVal = 'A';
errorMsg = ...
    '''Type'' must be either ''''A'''', ''''Spline'''', or ''''PolyFit''''.';
validationFcn = @(x)assert(strcmp(x, 'A') || strcmp(x, 'Spline') ...
    || strcmp(x, 'PolyFit') , errorMsg);
addParameter(pars, paramName, defaultVal, validationFcn);

parse(pars, TypeList{:});

Type = pars.Results.Type;

% In the following if/else statement, the input parameters are passed to 
% appropriate functions based on the value of the 'Type' parameter. 
if strcmp(Type, 'A')
    yIndefiniteIntegral = ZFindIndefiniteIntegralA...
        (xData, yData, xIntegral, TypeDeletedList{:});
else
    if strcmp(Type, 'Spline')
        yIndefiniteIntegral = ZFindIndefiniteIntegralSpline...
            (xData, yData, xIntegral, TypeDeletedList{:});
    else
        yIndefiniteIntegral = ZFindIndefiniteIntegralPolyFit...
            (xData, yData, xIntegral, TypeDeletedList{:});
    end
end

end