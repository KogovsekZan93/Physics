% The test for the simple-linear-regression function package is passed if 
% the command window is empty after running this script. 

clc;
xData = [0; 1; 3; 4; 7; 8; 10];
yData = [1; 15; 20; 10; 18; 30; 32];
CovarMat_yData = [9, 13.5, 24, 14.7, 5.4, 2.4, 3.6;
   13.5, 25, 45, 28, 10.5, 6, 12;
   24, 45, 100, 63, 24, 14, 36;
   14.7, 28, 63, 49, 18.9, 11.2, 29.4;
    5.4, 10.5, 24, 18.9, 9, 5.4, 14.4;
    2.4, 6, 14, 11.2, 5.4, 4, 10.8;
    3.6, 12, 36, 29.4, 14.4, 10.8, 36];

[Slope, Intercept] = FindSimpleLinearRegressionCoefficients...
    (xData, yData, 'CovarMat_yData', CovarMat_yData);
SlopeStandard = 3.767975225769450;
InterceptStandard = 0.284387466801368;
if abs(Slope - SlopeStandard) > power(10, -12)
    fprintf(...
        'There is a problem with FindSimpleLinearRegressionCoefficients: \n[Slope, Intercept] = FindSimpleLinearRegressionCoefficients(xData, yData, ''CovarMat_yData'', CovarMat_yData)\nWrong Slope\n');
end
if abs(Intercept - InterceptStandard) > power(10, -12)
    fprintf(...
        'There is a problem with FindSimpleLinearRegressionCoefficients: \n[Slope, Intercept] = FindSimpleLinearRegressionCoefficients(xData, yData, ''CovarMat_yData'', CovarMat_yData)\nWrong Intercept\n');
end
clear Slope Intercept

[Slope, Intercept, CovarMat_SlopeIntercept] = ...
    FindSimpleLinearRegressionCoefficients...
    (xData, yData, 'CovarMat_yData', CovarMat_yData);
SlopeStandard = 3.767975225769450;
InterceptStandard = 0.284387466801368;
CovarMat_SlopeInterceptStandard = ...
[0.061665936189342,   -0.386030375588327;
    -0.386030375588327,   3.136926815260194];
if abs(Slope - SlopeStandard) > power(10, -12)
    fprintf(...
        'There is a problem with FindSimpleLinearRegressionCoefficients: \n[Slope, Intercept, CovarMat_SlopeIntercept] = FindSimpleLinearRegressionCoefficients(xData, yData, ''CovarMat_yData'', CovarMat_yData)\nWrong Slope\n');
end
if abs(Intercept - InterceptStandard) > power(10, -12)
    fprintf(...
        'There is a problem with FindSimpleLinearRegressionCoefficients: \n[Slope, Intercept, CovarMat_SlopeIntercept] = FindSimpleLinearRegressionCoefficients(xData, yData, ''CovarMat_yData'', CovarMat_yData)\nWrong Intercept\n');
end
if abs(sum(sum(abs(CovarMat_SlopeIntercept - CovarMat_SlopeInterceptStandard)))) > power(10, -12)
    fprintf(...
        'There is a problem with FindSimpleLinearRegressionCoefficients: \n[Slope, Intercept, CovarMat_SlopeIntercept] = FindSimpleLinearRegressionCoefficients(xData, yData, ''CovarMat_yData'', CovarMat_yData)\nWrong CovarMat_SlopeIntercept\n');
end
Figure = 3;
DrawSimpleLinearRegressionGraph(Figure, xData, yData, Slope, Intercept, ...
    sqrt(diag(CovarMat_yData)), CovarMat_SlopeIntercept);
pause('on');pause(1);pause('off')
close(Figure);
clear Slope Intercept CovarMat_SlopeIntercept CovarMat_yData Figure ...
    SlopeStandard InterceptStandard CovarMat_SlopeInterceptStandard

[Slope, Intercept] = FindSimpleLinearRegressionCoefficients(xData, yData);
SlopeStandard = 2.481164383561643;
InterceptStandard = 6.303082191780822;
if abs(Slope - SlopeStandard) > power(10, -12)
    fprintf(...
        'There is a problem with FindSimpleLinearRegressionCoefficients: \n[Slope, Intercept] = FindSimpleLinearRegressionCoefficients(xData, yData)\nWrong Slope\n');
end
if abs(Intercept - InterceptStandard) > power(10, -12)
    fprintf(...
        'There is a problem with FindSimpleLinearRegressionCoefficients: \n[Slope, Intercept] = FindSimpleLinearRegressionCoefficients(xData, yData)\nWrong Intercept\n');
end
clear Slope Intercept

[Slope, Intercept, Variance_yData] = ...
    FindSimpleLinearRegressionCoefficients(xData, yData);
Variance_yDataStandard = 64.132990867579892;
if abs(Slope - SlopeStandard) > power(10, -12)
    fprintf(...
        'There is a problem with FindSimpleLinearRegressionCoefficients: \n[Slope, Intercept, Variance_yData] = FindSimpleLinearRegressionCoefficients(xData, yData)\nWrong Slope\n');
end
if abs(Intercept - InterceptStandard) > power(10, -12)
    fprintf(...
        'There is a problem with FindSimpleLinearRegressionCoefficients: \n[Slope, Intercept, Variance_yData] = FindSimpleLinearRegressionCoefficients(xData, yData)\nWrong Intercept\n');
end
if abs(Variance_yData - Variance_yDataStandard) > power(10, -12)
    fprintf(...
        'There is a problem with FindSimpleLinearRegressionCoefficients: \n[Slope, Intercept, Variance_yData] = FindSimpleLinearRegressionCoefficients(xData, yData)\nWrong Variance_yData\n');
end
clear Slope Intercept Variance_yData

[Slope, Intercept, Variance_yData, CovarMat_SlopeIntercept] = ...
    FindSimpleLinearRegressionCoefficients(xData, yData);
CovarMat_SlopeInterceptStandard = ...
    [0.768717356289485,  -3.623953251079000;
    -3.623953251079000,  26.246206879026701];
if abs(Slope - SlopeStandard) > power(10, -12)
    fprintf(...
        'There is a problem with FindSimpleLinearRegressionCoefficients: \n[Slope, Intercept, Variance_yData, CovarMat_SlopeIntercept] = FindSimpleLinearRegressionCoefficients(xData, yData)\nWrong Slope\n');
end
if abs(Intercept - InterceptStandard) > power(10, -12)
    fprintf(...
        'There is a problem with FindSimpleLinearRegressionCoefficients: \n[Slope, Intercept, Variance_yData, CovarMat_SlopeIntercept] = FindSimpleLinearRegressionCoefficients(xData, yData)\nWrong Intercept\n');
end
if abs(Variance_yData - Variance_yDataStandard) > power(10, -12)
    fprintf(...
        'There is a problem with FindSimpleLinearRegressionCoefficients: \n[Slope, Intercept, Variance_yData, CovarMat_SlopeIntercept] = FindSimpleLinearRegressionCoefficients(xData, yData)\nWrong Variance_yData\n');
end
if abs(sum(sum(abs(CovarMat_SlopeIntercept - CovarMat_SlopeInterceptStandard)))) > power(10, -12)
    fprintf(...
        'There is a problem with FindSimpleLinearRegressionCoefficients: \n[Slope, Intercept, Variance_yData, CovarMat_SlopeIntercept] = FindSimpleLinearRegressionCoefficients(xData, yData)\nWrong CovarMat_SlopeIntercept\n');
end
clear Slope Intercept Variance_yData ...
    CovarMat_SlopeIntercept ...
    CovarMat_SlopeInterceptStandard Variance_yDataStandard

[Slope, Intercept] = FindSimpleLinearRegressionCoefficientsFAST...
    (xData, yData);
if abs(Slope - SlopeStandard) > power(10, -12)
    fprintf(...
        'There is a problem with FindSimpleLinearRegressionCoefficientsFAST: \n[Slope, Intercept] = FindSimpleLinearRegressionCoefficientsFAST(xData, yData)\nWrong Slope\n');
end
if abs(Intercept - InterceptStandard) > power(10, -12)
    fprintf(...
        'There is a problem with FindSimpleLinearRegressionCoefficientsFAST: \n[Slope, Intercept] = FindSimpleLinearRegressionCoefficientsFAST(xData, yData)\nWrong Intercept\n');
end
clear Slope Intercept SlopeStandard InterceptStandard xData ...
    yData