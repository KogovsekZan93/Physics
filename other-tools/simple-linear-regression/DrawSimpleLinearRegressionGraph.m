function DrawSimpleLinearRegressionGraph...
    (figr, xData, yData, Slope, Intercept, ...
    std_xData, std_yData, CovarMat_SlopeIntercept)
%% Tool for plotting the data points, the simple linear 
%% regression curve and its standard deviation area
% 
% Author: Žan Kogovšek
% Date: 10.5.2023
% Last changed: 10.10.2023
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
% "figr" the data points ("xData"(i), "yData"(i)) and the mean 
% estimated linear curve 
% Y = fEstimateMean(X) = X * "slope" + "intercept" as well as 
% the area between the curves determined by the functions 
% Y = fEstimateMean(X) - std_ fEstimateMean(X) and 
% Y = fEstimateMean(X) + std_ fEstimateMean(X), respectively. 
% The std_ fEstimateMean(X) function is the standard deviation 
% of the simple linear regression function fEstimateMean(X). 
% The std_ fEstimateMean(X) function is based on the 
% parameters "slope" and "intercept", the 
% "CovarMat_SlopeIntercept" matrix, and the standard deviation 
% of the data points, specified by the input column vectors 
% "std_xData" and "std_yData". 
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
% The "Slope" parameter and the "Intercept" parameter are the 
% mean estimations of the a parameter and the b parameter, 
% respectively, of the linear function Y = f(X) = X * a + b, 
% appraised by the data pairs ("xData"(i), "yData"(i)). Even 
% though this function was designed to plot the simple linear 
% regression curve and its standard deviation area, the 
% estimation method the a and b parameter, which are 
% expressed by the parameters "Slope" and "Intercept", and 
% "CovarMat_SlopeIntercept" matrix, can in principle arbitrary. 
% Both the "Slope" parameter and the "Intercept" parameter 
% must be scalars. 
% 
% The "std_xData" vector and the "std_yData" vector are the 
% vectors of values "std_xData"(i) and "std_yData"(i), each of 
% which is the standard deviation of the values "xData"(i) and 
% "yData"(i), respectively. 
% Both the "std_xData" vector and "std_yData" vector must be 
% column vectors of real numbers. 
% 
% The "CovarMat_SlopeIntercept" matrix is the covariance 
% matrix of the estimated values of a and b, the mean of which is 
% "Slope" and "Intercept". Even though this function was 
% designed to plot the simple linear regression curve and its 
% standard deviation area, the estimation method the a and b 
% parameter, which are expressed by the parameters "Slope" 
% and "Intercept", and "CovarMat_SlopeIntercept" matrix, can in 
% principle arbitrary. It must be a 2-by-2 matrix of real numbers. 


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

% In the following two lines, the pair of vectors which describe 
% the mean estimated linear curve, determined by the function 
% Y = fEstimateMean(X) = X * "Slope" + "Intercept" is obtained. 
x_Plot =(linspace(min(xData), max(xData), N))';
y_Plot_Avg = x_Plot * Slope + Intercept;

% In the following block of code, first the vector which describes 
% the standard deviation of the estimated linear curve is 
% obtained. Then, vectors which describe the two curves which 
% are boundaries of the standard deviation area of the 
% estimated linear curve are determined. 
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
GetHorizontalErrorbar(xData, yData, std_xData, std_xData, 'ro');
plot(x_Plot, y_Plot_Avg, 'k-', 'LineWidth', 1.5)

grid on;
set(gca,'fontsize',14)
hold off;

end