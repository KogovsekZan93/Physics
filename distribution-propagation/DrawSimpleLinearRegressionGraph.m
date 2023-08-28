function DrawSimpleLinearRegressionGraph...
    (figr, xData, yData, Slope, Intercept, ...
    sigma_xData, sigma_yData, CovarMat_SlopeIntercept)

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
    sigma_xData, sigma_yData, CovarMat_SlopeIntercept);

N = power(10, 4);

figure(figr);
hold on;

x_Plot =(linspace(min(xData), max(xData), N))';
y_Plot_Avg = x_Plot * Slope + Intercept;
sigma_y_Plot = sqrt(...
    power(x_Plot, 2) * CovarMat_SlopeIntercept(1, 1) + ...
    CovarMat_SlopeIntercept(2, 2) + ...
    2 * x_Plot * CovarMat_SlopeIntercept(1, 2));
y_Plot_top = y_Plot_Avg + sigma_y_Plot;
y_Plot_bottom = y_Plot_Avg - sigma_y_Plot;

figure(figr);
hold on;

Area_Plot = fill...
    ([x_Plot', fliplr(x_Plot')], [y_Plot_bottom', fliplr(y_Plot_top')], 'b');
set(Area_Plot, 'facealpha', 0.5);
errorbar(xData, yData,sigma_yData, 'ro');
GetHorizontalErrorbar...
    (xData, yData,sigma_xData,sigma_xData, 'ro');
plot(x_Plot, y_Plot_Avg, 'k-', 'LineWidth', 1.5)

grid on;
set(gca,'fontsize',14)
hold off;

end