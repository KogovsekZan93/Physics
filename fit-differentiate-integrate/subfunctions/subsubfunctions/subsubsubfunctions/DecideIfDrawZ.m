function DecideIfDrawZ(DrawZFunctionHandle, DrawZInput, varargin)
%% Visualization of numerical integration with ZIntegralA
% 
% Author: Žan Kogovšek
% Date: 20.2.2021
% 
%% Description
% 
% Using this function, the visualization of the numerical 
% integration with ZIntegralA is plotted in the figure figure(figr). 
% The input values x(i) of the independent variable X and the 
% values y(i) of the dependent variable Y of an arbitrary function 
% Y = f(X) are plotted as blue circles (i.e. (x(i),y(i)) points), the 
% approximation of the f function is plotted as a red line and the 
% integral is plotted as the semi-transparent area under the red 
% curve. The semi-transparent area is blue if the original upper 
% limit of integration has a higher value than the original lower 
% limit of integration, and is red if that is not the case. 
%
%% Variables
% 
% This function has the form of 
% DrawZIntegA(x, y, Ipoints, Smatrix, xmin, xmax, figr)
% 
% x and y are the vectors of the aforementioned values x(i) and 
% y(i), respectively, of the independent variable X and of the 
% dependent variable Y, respectively, of an arbitrary function 
% Y = f(X) (y(i) = f(x(i)). x and y both have to be column vectors 
% of real numbers of equal length. x vector has to be sorted (i.e. 
% it is required that x(i) > x(j) for every i > j). 
% 
% Ipoints is a column vector and Smatrix is a matrix. For each 
% interval [Ipoints(k), Ipoints(k+1)], the plotted approximation of 
% the f function will be the Lagrange polynomial which is based 
% on the set {(x(i), y(i)) | i is in Smatrix(k, :)}. 
% 
% xmin is the lower limit of integration and xmax is the upper limit 
% of integration. The limits do not have to be contained in the 
% [min(x), max(x)] interval. 
% 
% LimitOrder is the indicator of whether the original input 
% xmax < xmin or not, and has the value “-1” in the former case 
% and the value “1” in the latter case. 
% 
% figr is the index of the figure in which the integration will be 
% visualized. It has to be a nonzero integer. 
 

%     N represents the number of points with which each section 
%     of the approximation of the function and the integral will be 
%     plotted. 


pars = inputParser;

paramName = 'DrawZFunctionHandle';
errorMsg = '''DrawZFunctionHandle'' must be a function handle.';
validationFcn = @(x)assert(isa(x, 'function_handle'), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'Figure';
defaultVal = 0;
errorMsg = '''Figure'' must be a non-negative integer.';
validationFcn = @(x)assert(isnumeric(x) && isscalar(x) && ...
    x >= 0 && mod(x,1) == 0, errorMsg);
addParameter(pars, paramName, defaultVal, validationFcn);

parse(pars, DrawZFunctionHandle, varargin{:});

figr = pars.Results.Figure;

if figr ~= 0
    figure(figr); clf;
    DrawZFunctionHandle(figr, DrawZInput{:});
end

end