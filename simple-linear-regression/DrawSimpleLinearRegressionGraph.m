function DrawSimpleLinearRegressionGraph...
    (Figure, xData, yData, Slope, Intercept, ...
    Std_yData, CovarMat_SlopeIntercept)
%% Tool for plotting the data points, the simple linear 
%% regression curve and its standard deviation area
% 
% Author: Žan Kogovšek
% Date: 10.5.2023
% Last changed: 2.10.2024
% 
%% Description
% 
% Given the input integer 'Figure' as well as the input column 
% vector 'xData' of the values 'xData'(i) of the independent 
% variable X and the column vector 'yData' of values 'yData'(i) of 
% the dependent variable Y = f(X) = X * a + b, where the 
% parameters a and b are estimated by the input parameters 
% 'Slope' and 'Intercept', respectively, and their covariance 
% matrix 'CovarMat_SlopeIntercept' using the simple linear 
% regression method, this function plots in the figure window 
% with the index 'Figure' the data points ('xData'(i), 'yData'(i)) and 
% the mean estimated linear curve, determined by the function 
% Y = fEstimateMean(X) = X * 'Slope' + 'Intercept' as well as 
% the area between the curves determined by the functions 
% Y = fEstimateMean(X) - Std_ fEstimateMean(X) and 
% Y = fEstimateMean(X) + Std_ fEstimateMean(X), respectively. 
% The Std_ fEstimateMean(X) function is the standard deviation 
% of the simple linear regression function fEstimateMean(X). 
% The Std_ fEstimateMean(X) function is based on the 
% parameters 'Slope' and 'Intercept', the 
% 'CovarMat_SlopeIntercept' matrix, and the standard deviation 
% of the values yData(i), specified by the input column vector 
% 'Std_yData'. 
% 
%% Variables
% 
% This function has the form of 
% DrawSimpleLinearRegressionGraph...
% (Figure, xData, yData, Slope, Intercept, ...
% Std_yData, CovarMat_SlopeIntercept)
% 
% 'Figure' is the integer which is the index of the figure window in 
% which the figure described in Description is to be plotted. The 
% 'Figure' integer must be a natural number. 
% 
% 'xData' and 'yData' are the vectors of the values of the 
% independent variable X and of the dependent variable Y, 
% respectively, of the linear function Y = f(X) = X * a + b 
% ('yData' = f('xData')) where the a and the b parameters are 
% estimated by the parameters 'Slope' and 'Intercept', 
% respectively, and their covariance matrix 
% 'CovarMat_SlopeIntercept' using the simple linear regression 
% method. 
% Both the 'xData' vector and the 'yData' vector must be column 
% vectors of equal length and of real numbers. 
% 
% The 'Slope' parameter and the 'Intercept' parameter are the 
% mean estimations of the a parameter and the b parameter, 
% respectively, of the linear function Y = f(X) = X * a + b, 
% appraised by the data pairs ('xData'(i), 'yData'(i)). Even 
% though this function was designed to plot the simple linear 
% regression curve and its standard deviation area, the 
% estimation method of the a and b parameter, the estimates of 
% which are expressed by the parameters 'Slope' and 
% 'Intercept', and their covariance matrix 
% 'CovarMat_SlopeIntercept', can in principle be arbitrary. 
% Both the 'Slope' parameter and the 'Intercept' parameter 
% must be scalars. 
% 
% The 'Std_yData' vector is the vector of values 'Std_yData'(i), 
% each of which is the standard deviation of the values 'yData'(i). 
% The 'Std_yData' vector must be a column vector of real 
% numbers. 
% 
% The 'CovarMat_SlopeIntercept' matrix is the covariance 
% matrix of the estimated values of a and b, the mean of which is 
% 'Slope' and 'Intercept'. Even though this function was 
% designed to plot the simple linear regression curve and its 
% standard deviation area, the estimation method of the a and b 
% parameter, the estimates of which are expressed by the 
% parameters 'Slope' and 'Intercept', and their covariance matrix 
% 'CovarMat_SlopeIntercept', can in principle be arbitrary. It 
% must be a 2-by-2 matrix of real numbers. 


pars = inputParser;

paramName = 'Figure';
errorMsg = ...
    '''Figure'' must be a natural natural number.';
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

paramName = 'Std_yData';
errorMsg = ...
    '''Std_yData'' must be a column vector of real numbers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) && ...
    isreal(x), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'CovarMat_SlopeIntercept';
errorMsg = ...
    '''CovarMat_SlopeIntercept'' must be a matrix of real numbers.';
validationFcn = @(x)assert(isnumeric(x) && ismatrix(x) && ...
    isreal(x), errorMsg);
addRequired(pars, paramName, validationFcn);

parse(pars, Figure, xData, yData, Slope, Intercept, ...
    Std_yData, CovarMat_SlopeIntercept);

N = power(10, 4);

figure(Figure);
hold on;

% In the following two lines, the pair of vectors which describe 
% the mean estimated linear curve, determined by the function 
% Y = fEstimateMean(X) = X * 'Slope' + 'Intercept', is obtained. 
x_Plot =(linspace(min(xData), max(xData), N))';
y_Plot_Avg = x_Plot * Slope + Intercept;

% In the following block of code, first the vector which describes 
% the standard deviation of the estimated linear curve is 
% obtained. Then, vectors which describe the two curves which 
% are boundaries of the standard deviation area of the 
% estimated linear curve are obtained. 
Std_y_Plot = sqrt(...
    power(x_Plot, 2) * CovarMat_SlopeIntercept(1, 1) + ...
    CovarMat_SlopeIntercept(2, 2) + ...
    2 * x_Plot * CovarMat_SlopeIntercept(1, 2));
y_Plot_top = y_Plot_Avg + Std_y_Plot;
y_Plot_bottom = y_Plot_Avg - Std_y_Plot;

figure(Figure);
hold on;

Area_Plot = fill...
    ([x_Plot', fliplr(x_Plot')], [y_Plot_bottom', fliplr(y_Plot_top')], 'b');
set(Area_Plot, 'facealpha', 0.5);
errorbar(xData, yData, Std_yData, 'ro');
plot(x_Plot, y_Plot_Avg, 'k-', 'LineWidth', 1.5)

grid on;
set(gca,'fontsize',14)
hold off;

end