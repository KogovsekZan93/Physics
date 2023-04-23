function DrawZAreaA(xData, yData, xAreaAMin, xAreaAMax, ...
    ColorFace, Ipoints, Smatrix)

pars = inputParser;

paramName = 'xData';
errorMsg = '''xData'' must be a sorted column vector of numbers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) && ... 
    issorted(x), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'yData';
errorMsg = ...
    '''yData'' must be a column vector of numbers which has the same length as ''xData''';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) &&  ...
    length(xData) == length(yData), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'xAreaAMin';
errorMsg = '''xAreaAMin'' must be a number.';
validationFcn = @(x)assert(isnumeric(x) && isscalar(x), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'xAreaAMax';
errorMsg = ...
    '''xAreaAMax'' must be a number which is greater than ''xAreaAMin''.';
validationFcn = @(x)assert(isnumeric(x) && isscalar(x) && ...
    xAreaAMax > xAreaAMin, errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'ColorFace';
errorMsg = ...
    '''ColorFace'' must be a row vector of three numbers.';
validationFcn = @(x)assert(isnumeric(x) && isrow(x) && ... 
    length(x) == 3, errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'Ipoints';
errorMsg = ...
    '''Ipoints'' must be a sorted column vector of numbers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) && ... 
    issorted(x), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'Smatrix';
errorMsg = ...
    '''Smatrix'' must be a matrix of natural numbers the hight of which is ''length(Ipoints) - 1''';
validationFcn = @(x)assert(isnumeric(x) && ismatrix(x) && ... 
    size(x, 1) == length(Ipoints) - 1 && ...
    any(any((mod(x,1) == 0))) && any(any(x > 0)), errorMsg);
addRequired(pars, paramName, validationFcn);

parse(pars, xData, yData, xAreaAMin, xAreaAMax, ColorFace, ...
    Ipoints, Smatrix);
    
N = power(10, 4);

XFitA = (linspace...
    (xAreaAMin, xAreaAMax, N))';
YFitA = EvaluateIpointsSmatrixFit...
    (xData, yData, XFitA, Ipoints, Smatrix);

h = area(XFitA, YFitA);
h.FaceColor = ColorFace;
h.FaceAlpha = 0.3;

end