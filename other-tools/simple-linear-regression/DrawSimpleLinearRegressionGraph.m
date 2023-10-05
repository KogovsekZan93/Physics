function DrawSimpleLinearRegressionGraph...
    (figr, xData, yData, Slope, Intercept, ...
    std_xData, std_yData, CovarMat_SlopeIntercept)
%% Tool for plotting the data points, the simple linear 
%% regression curve and its standard deviation area
% 
% Author: Žan Kogovšek
% Date: 10.5.2023
% Last changed: 10.5.2023
% 
%% Description
% 
% Given the input integer "figr" as well as input column vectors 
% "xData" of the values "xData"(i) of the independent variable X 
% and the column vector "yData" of values "yData"(i) of the 
% dependent variable Y = f(X) = X * a + b, where the parameters 
% a and b are estimated by the input parameters "slope" and 
% "intercept", respectively, and their covariance matrix 
% "CovarMat_SlopeIntercept" using the simple linear regression 
% method, this function plots in the figure window with the index 
% "figr" the data points ("xData"(i), "yData"(i)) and the simple 
% linear regression curve determined by the function 
% Y = fSimpLinReg(X) = X * "slope"  + "intercept" as well as the 
% area between the curves determined by the functions 
% Y = fSimpLinReg(X) - std_fSimpLinReg(X) and 
% Y = fSimpLinReg(X) + std_fSimpLinReg(X), respectively. 
% The std_fSimpLinReg(X) function is the standard deviation of 
% the simple linear regression function fsimpLinReg(X). The 
% std_fSimpLinReg function is based on the parameters "slope" 
% and "intercept", the "CovarMat_SlopeIntercept" matrix, and the 
% standard deviation of the data points, specified by the input 
% column vectors "std_xData" and "std_yData". 
% 
%% Variables
% 
% This function has the form of 
% DrawSimpleLinearRegressionGraph...
% (figr, xData, yData, Slope, Intercept, ...
% sigma_xData, sigma_yData, CovarMat_SlopeIntercept)
% 
% "figr" is the integer which is the index of the figure window in 
% which the figure is to be plotted. It must be a natural number. 
% 
% "xData" and "yData" are the vectors of the values of the 
% independent variable X and of the dependent variable Y, 
% respectively, of the linear function 
% Y = f(X) = X * a + b ("yData" = f("xData")) where the a and the 
% b parameters are estimated by the parameters "slope" and 
% "intercept", respectively, and their covariance matrix 
% "CovarMat_SlopeIntercept" using the simple linear regression 
% method. 
% Both the "xData" vector and the "yData" vector must be 
% column vectors of equal length and of real numbers. 
% 
% std_xData, std_yData
% 
% Both the "slope" parameter and the "intercept" parameter are 
% estimates of the a parameter and b parameter, respectively, 
% calculated by simple linear regression of the data pairs 
% ("xData"(i), "yData"(i)). 


pars = inputParser;

paramName = 'figr';
errorMsg = ...
    '''figr'' must be a natural natural number.';
validationFcn = @(x)assert(isnumeric(x) && isscalar(x) && ...
    mod(x,1) == 0 && x > 0, errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'xData';
errorMsg = ...
    '''xData'' must be a sorted column vector of numbers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) && ... 
    issorted(x), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'yData';
errorMsg = ...
    '''yData'' must be a column vector of numbers which has the same length as ''xData''';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) &&  ...
    length(xData) == length(yData), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'Slope';
errorMsg = '''Slope'' must be a scalar.';
validationFcn = @(x)assert(isnumeric(x) && isscalar(x), ...
    errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'Intercept';
errorMsg = '''Intercept'' must be a scalar.';
validationFcn = @(x)assert(isnumeric(x) && isscalar(x), ...
    errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'sigma_xData';
errorMsg = ...
    '''sigma_xData'' must be a column vector of real numbers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) && ...
    isreal(x), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'sigma_yData';
errorMsg = ...
    '''sigma_yData'' must be a column vector of real numbers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) && ...
    isreal(x), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'CovarMat_SlopeIntercept';
errorMsg = ...
    '''CovarMat_SlopeIntercept'' must be a matrix of real numbers.';
validationFcn = @(x)assert(isnumeric(x) && ismatrix(x) && ...
    isreal(x), errorMsg);
addRequired(pars, paramName, validationFcn);

parse(pars, figr, xData, yData, Slope, Intercept, ...
    std_xData, std_yData, CovarMat_SlopeIntercept);

N = power(10, 4);

figure(figr);
hold on;

x_Plot =(linspace(min(xData), max(xData), N))';
y_Plot_Avg = x_Plot * Slope + Intercept;
std_y_Plot = sqrt(...
    power(x_Plot, 2) * CovarMat_SlopeIntercept(1, 1) + ...
    CovarMat_SlopeIntercept(2, 2) + ...
    2 * x_Plot * CovarMat_SlopeIntercept(1, 2));
y_Plot_top = y_Plot_Avg + std_y_Plot;
y_Plot_bottom = y_Plot_Avg - std_y_Plot;

figure(figr);
hold on;

Area_Plot = fill...
    ([x_Plot', fliplr(x_Plot')], [y_Plot_bottom', fliplr(y_Plot_top')], 'b');
set(Area_Plot, 'facealpha', 0.5);
errorbar(xData, yData, std_yData, 'ro');
GetHorizontalErrorbar...
    (xData, yData, std_xData, std_xData, 'ro');
plot(x_Plot, y_Plot_Avg, 'k-', 'LineWidth', 1.5)

grid on;
set(gca,'fontsize',14)
hold off;

end