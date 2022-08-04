% Supposedly one measures the variable x which is a function of 
% the variable y. This gives us two corresponding vectors of 
% measurements: xData for the x variable and yData for the y 
% variable. 
% To plot the measured data points, run the following block of 
% code. 

xData = [0; 1; 3; 5; 8; 35; 37; 40; 45; 56; 57; 60; 66; 68];
yData = [10; 9; 8; 11; 13; 5; 4; 3; 2; 6; 11; 12; 2; 8];
close all; figure(1); plot(xData, yData, 'bo', 'MarkerSize', 10);
xlabel('x'); ylabel('y'); set(gca, 'FontSize', 14); grid on;
clearvars; clc;   % Clearing variables and workspace is done at 
                          % or near the end of after each block of code for 
                          % the purposes of clarity of this tutorial. 


%                                           Page 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Supposedly one wants to find the value of the y variable for 
% the missing integer values of the x variable in the [-5, 70] 
% interval. The ZFindFit function is a tool which can be used to 
% do just that. 
% Run the following block of code to visualize the missing values 
% of the y variable which were estimated using the ZFindFit 
% function with its default settings, i.e. without any of its various 
% optional parameters changed. 

xData = [0; 1; 3; 5; 8; 35; 37; 40; 45; 56; 57; 60; 66; 68];
yData = [10; 9; 8; 11; 13; 5; 4; 3; 2; 6; 11; 12; 2; 8];
xMissing = [-5; -4; -3; -2; -1; 2; 4; 6; 7; 9; 10; 11; 12; 13; 14; 15; ...
    16; 17; 18; 19; 20; 21; 22; 23; 24; 25; 26; 27; 28; 29; 30; 31; ...
    32; 33; 34; 36; 38; 39; 41; 42; 43; 44; 46; 47; 48; 49; 50; 51; ...
    52; 53; 54; 55; 58; 59; 61; 62; 63; 64; 65; 67; 69; ...
    70];   % The missing integer values of the x variable at which 
              % the y variable was not measured. 
yMissing = ZFindFit(xData, yData, xMissing);
close all; figure(1); hold on;
plot(xData, yData, 'bo', 'MarkerSize', 10);
plot(xMissing, yMissing, 'ro', 'MarkerSize', 10);
xlabel('x'); ylabel('y'); legend('Data points', ...
    'Points estimated using ZFindFit function');
set(gca, 'FontSize', 14); grid on; hold off;
clearvars -except xData yData xMissing yMissing; clc;


%                                           Page 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% With its default settings, the estimated missing values with the 
% ZFindFit function are calculated using linear interpolation 
% between the neighboring data points. 
% The estimation of the missing values can be done in three 
% ways, determined by the optional parameter “Type”. The 
% possible settings of “Type” are “A”, “Spline” and “PolyFit”. 
% With the default setting “A”, a piecewise interpolation 
% polynomial is used. The degree of the piecewise interpolation 
% polynomial can be set using the optional parameter 
% “PseudoAccuracy”, the default value of which is “1” (hence 
% the linear interpolation with default settings). 
% Run the following block of code to see the impact of the 
% variation of the “PseudoAccuracy” parameter on the estimated 
% missing values of the y variable. 

xData = [0; 1; 3; 5; 8; 35; 37; 40; 45; 56; 57; 60; 66; 68];
yData = [10; 9; 8; 11; 13; 5; 4; 3; 2; 6; 11; 12; 2; 8];
xMissing = [-5; -4; -3; -2; -1; 2; 4; 6; 7; 9; 10; 11; 12; 13; 14; 15; ...
    16; 17; 18; 19; 20; 21; 22; 23; 24; 25; 26; 27; 28; 29; 30; 31; ...
    32; 33; 34; 36; 38; 39; 41; 42; 43; 44; 46; 47; 48; 49; 50; 51; ...
    52; 53; 54; 55; 58; 59; 61; 62; 63; 64; 65; 67; 69; ...
    70];   % The missing integer values of the x variable at which 
              % the y variable was not measured. 
close all;
psacc = 1;
yMissing1 = ZFindFit(xData, yData, xMissing, ...
    'PseudoAccuracy', psacc);   % Pseudo Accuracy paramater 
                                                    % set to 1. 
figure(1); hold on;
plot(xData, yData, 'bo', 'MarkerSize', 10);
plot(xMissing, yMissing1, 'ro', 'MarkerSize', 10);
xlabel('x'); ylabel('y'); legend('Data points', ...
    'Points estimated using ZFindFit function');
set(gca, 'FontSize', 14); grid on; hold off;
title('“PseudoAccuracy” == "1"');
psacc = 2;
yMissing2 = ZFindFit(xData, yData, xMissing, ...
    'PseudoAccuracy', psacc);   % Pseudo Accuracy paramater 
                                                    % set to 2. 
figure(2); hold on;
plot(xData, yData, 'bo', 'MarkerSize', 10);
plot(xMissing, yMissing2, 'ro', 'MarkerSize', 10);
xlabel('x'); ylabel('y'); legend('Data points', ...
    'Points estimated using ZFindFit function');
set(gca, 'FontSize', 14); grid on; hold off;
title('“PseudoAccuracy” == "2"');
psacc = 3;
yMissing3 = ZFindFit(xData, yData, xMissing, ...
    'PseudoAccuracy', psacc);   % Pseudo Accuracy paramater 
                                                    % set to 3. 
figure(3); hold on;
plot(xData, yData, 'bo', 'MarkerSize', 10);
plot(xMissing, yMissing3, 'ro', 'MarkerSize', 10);
xlabel('x'); ylabel('y'); legend('Data points', ...
    'Points estimated using ZFindFit function');
set(gca, 'FontSize', 14); grid on; hold off;
title('“PseudoAccuracy” == "3"');
clearvars -except xData yData xMissing ...
    yMissing1 yMissing2 yMissing3; clc;


%                                           Page 3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% With the “A” setting of the “Type” optional parameter, in 
% addition to the “PseudoAccuracy” optional parameter, the 
% “Mode” optional parameter can also be set. The possible 
% settings are either “0”, “1”, and “2”, the default being “1”. The 
% setting of the “Mode” parameter determines the method by 
% which the data points are selected and the boundaries are 
% calculated for each of the interpolation polynomials of the 
% piecewise interpolation polynomial function. 
% Generally, the variation of the “Mode” parameter only has an 
% impact when the data points are highly unequally spaced along 
% the abscissa coordinate, as is indeed the case with the 
% example presented in this tutorial. For further information, the 
% documentation of the ZFindFit function and its subfunctions 
% should be referred to. 
% Run the following block of code to see the impact of the 
% variation of the “Mode” parameter on the estimated values of 
% the y variable. The “PseudoAccuracy” parameter is set to “3” 
% for all cases. 

xData = [0; 1; 3; 5; 8; 35; 37; 40; 45; 56; 57; 60; 66; 68];
yData = [10; 9; 8; 11; 13; 5; 4; 3; 2; 6; 11; 12; 2; 8];
xMissing = [-5; -4; -3; -2; -1; 2; 4; 6; 7; 9; 10; 11; 12; 13; 14; 15; ...
    16; 17; 18; 19; 20; 21; 22; 23; 24; 25; 26; 27; 28; 29; 30; 31; ...
    32; 33; 34; 36; 38; 39; 41; 42; 43; 44; 46; 47; 48; 49; 50; 51; ...
    52; 53; 54; 55; 58; 59; 61; 62; 63; 64; 65; 67; 69; ...
    70];   % The missing integer values of the x variable at which 
              % the y variable was not measured. 
psacc = 3;   % Pseudo Accuracy paramater 
                     % set to 3. 
close all;
mode = 0;
yMissing0 = ZFindFit(xData, yData, xMissing, ...
    'PseudoAccuracy', psacc, ...
    'Mode', mode);   % Mode paramater set to 0. 
figure(1); hold on;
plot(xData, yData, 'bo', 'MarkerSize', 10);
plot(xMissing, yMissing0, 'ro', 'MarkerSize', 10);
xlabel('x'); ylabel('y'); legend('Data points', ...
    'Points estimated using ZFindFit function');
set(gca, 'FontSize', 14); grid on; hold off;
title('“Mode” == "0"');
mode = 1;
yMissing1 = ZFindFit(xData, yData, xMissing, ...
    'PseudoAccuracy', psacc, ...
    'Mode', mode);   % Mode paramater set to 1. 
figure(2); hold on;
plot(xData, yData, 'bo', 'MarkerSize', 10);
plot(xMissing, yMissing1, 'ro', 'MarkerSize', 10);
xlabel('x'); ylabel('y'); legend('Data points', ...
    'Points estimated using ZFindFit function');
set(gca, 'FontSize', 14); grid on; hold off;
title('“Mode” == "1"');
mode = 2;
yMissing2 = ZFindFit(xData, yData, xMissing, ...
    'PseudoAccuracy', psacc, ...
    'Mode', mode);   % Mode paramater set to 2. 
figure(3); hold on;
plot(xData, yData, 'bo', 'MarkerSize', 10);
plot(xMissing, yMissing2, 'ro', 'MarkerSize', 10);
xlabel('x'); ylabel('y'); legend('Data points', ...
    'Points estimated using ZFindFit function');
set(gca, 'FontSize', 14); grid on; hold off;
title('“Mode” == "2"');
clearvars -except xData yData xMissing ...
    yMissing0 yMissing1 yMissing2; clc;


%                                           Page 4
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% By setting the “Type” parameter to “Spline”, the estimation of 
% the missing values is calculated using the cubic spline of the 
% data points. As the cubic spline is exactly determined for a 
% given set of data points, with the “Spline” setting of the “Type” 
% petameter, there are no optional parameters 
% “PseudoAccuracy” or “Mode”. 
% Run the following block of code to estimate the missing 
% values of the y variable for the example given in this tutorial 
% using the “Spline” setting of the “Type” parameter. 

xData = [0; 1; 3; 5; 8; 35; 37; 40; 45; 56; 57; 60; 66; 68];
yData = [10; 9; 8; 11; 13; 5; 4; 3; 2; 6; 11; 12; 2; 8];
xMissing = [-5; -4; -3; -2; -1; 2; 4; 6; 7; 9; 10; 11; 12; 13; 14; 15; ...
    16; 17; 18; 19; 20; 21; 22; 23; 24; 25; 26; 27; 28; 29; 30; 31; ...
    32; 33; 34; 36; 38; 39; 41; 42; 43; 44; 46; 47; 48; 49; 50; 51; ...
    52; 53; 54; 55; 58; 59; 61; 62; 63; 64; 65; 67; 69; ...
    70];   % The missing integer values of the x variable at which 
              % the y variable was not measured. 
close all;
yMissingSpline = ZFindFit(xData, yData, xMissing, ...
    'Type', 'Spline');   % Setting the Type parameter to Spline. 
figure(1); hold on;
plot(xData, yData, 'bo', 'MarkerSize', 10);
plot(xMissing, yMissingSpline, 'ro', 'MarkerSize', 10);
xlabel('x'); ylabel('y'); legend('Data points', ...
    'Points estimated using ZFindFit function');
set(gca, 'FontSize', 14); grid on; hold off;
title('“Type” == "Spline"');
clearvars -except xData yData xMissing yMissingSpline; clc;


%                                           Page 5
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Alternatively, the “Type” parameter can be set to “PolyFit” in 
% order to estimate the missing values using the regression 
% polynomial of the data points. The order of the regression 
% polynomial must be specified using the required 
% “PolyDegree” parameter. As with the “Spline” setting of the 
% “Type” parameter, the optional parameters “PseudoAccuracy” 
% and “Mode“ are not available. 
% As can be seen by running the block of code on Page 1, the 
% function y(x) appears to have four local extremes. Perhaps an 
% appropriate choice for the order of the regression polynomial 
% would thus be five. 
% Run the following block of code to estimate the missing 
% values of the y variable for the example given in this tutorial 
% using the “PolyFit” setting of the “Type” parameter. The 
% “PolyDegree” parameter is set to be “5” for reasons 
% discussed in the previous paragraph. 

xData = [0; 1; 3; 5; 8; 35; 37; 40; 45; 56; 57; 60; 66; 68];
yData = [10; 9; 8; 11; 13; 5; 4; 3; 2; 6; 11; 12; 2; 8];
xMissing = [-5; -4; -3; -2; -1; 2; 4; 6; 7; 9; 10; 11; 12; 13; 14; 15; ...
    16; 17; 18; 19; 20; 21; 22; 23; 24; 25; 26; 27; 28; 29; 30; 31; ...
    32; 33; 34; 36; 38; 39; 41; 42; 43; 44; 46; 47; 48; 49; 50; 51; ...
    52; 53; 54; 55; 58; 59; 61; 62; 63; 64; 65; 67; 69; ...
    70];   % The missing integer values of the x variable at which 
              % the y variable was not measured. 
close all;
PolyDegree = 5;   % Setting the degree of the regression 
                               % polynomial. 
yMissingPolyFit = ZFindFit(xData, yData, xMissing, ...
    'Type', 'PolyFit', ...   % Setting the Type parameter to PolyFit. 
    PolyDegree);
figure(1); hold on;
plot(xData, yData, 'bo', 'MarkerSize', 10);
plot(xMissing, yMissingPolyFit, 'ro', 'MarkerSize', 10);
xlabel('x'); ylabel('y'); legend('Data points', ...
    'Points estimated using ZFindFit function');
set(gca, 'FontSize', 14); grid on; hold off;
title('“Type” == "PolyFit"');
clearvars -except xData yData xMissing yMissingPolyFit; clc;


%                                           Page 6
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Alternatively, the assumed differentiable function which is 
% associated with the data can be the cubic spline of the data 
% points. This can be done by altering the optional “Type” 
% parameter to “Spline".
% The default “Type” parameter, which has been used until this 
% point in the tutorial, is “A”. Note that due to spline being fully 
% defined by a specific set of data points, there are no optional 
% parameters “Accuracy” and “Mode” with the “Type” 
% parameter set to “Spline”. 
% Keep in mind that as the spline is a piecewise cubic 
% polynomial, the order of differentiation above 3 will produce 
% the value 0 for all inquired abscissa points. 
% Run the following block of code to see how the spline 
% interpolation and differentiation method compares to the
% ZFindDerivative function with the default settings and the 
% actual velocity function in our first case, measuring the value of 
% the x coordinate over an 8 s interval and trying to determine 
% the velocity function v(t). 

T = [0; 1; 2; 3; 4; 5; 6; 7; 8];
X = [0; 0.841470984807897; 0.909297426825682;
    0.141120008059867; -0.756802495307928;
    -0.958924274663138; -0.279415498198926;
   0.656986598718789; 0.989358246623382];
xData = T; yData = X; 
xDerivative = (linspace(-1, 9, 1000))';   % Time points at which 
                                                                 % v(t) is to be evaluated. 
yDerivativeDefault = ZFindDerivative(xData, yData, ...
    xDerivative);   % v(t) estimation using default settings. 
yDerivativeSpline = ZFindDerivative(xData, yData, xDerivative, ...
    'Type', 'Spline');   % v(t) estimation using spline interpolation. 
vActual = cos(xDerivative);   % Actual v(t). 
close all; figure(1); hold on;
plot(xDerivative, vActual, 'k', 'LineWidth', 1.5);
plot(xDerivative, yDerivativeDefault, 'b', 'LineWidth', 1.5);
plot(xDerivative, yDerivativeSpline, 'r', 'LineWidth', 1.5);
xlabel('t [s]'); ylabel('v [m / s]'); set(gca, 'FontSize', 14); grid on;
legend('Actual', 'Estimated using default settings', ...
    'Estimated using the spline interpolation');
clearvars; clc;


%                                           Page 7
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Another way to find the numerical derivative of a function is to 
% differentiate the regression polynomial of the data points. This 
% can be done by altering the optional “Type” parameter to 
% “PolyFit”. In that case, the required “PolyDegree” parameter 
% needs to be set. The “PolyDegree” parameter corresponds to 
% the degree of the regression polynomial. 
% As with the “Spline” setting of the “Type” parameter, there are 
% no optional parameters “Pseudo Accuracy” and “Mode”. 
% We again refer to the first case, measuring the value of 
% the x coordinate over an 8 s interval and trying to determine 
% the velocity function v(t). Run the block of code on Page 1 to 
% see the data points again. With no additional information, the 
% most reasonable regression polynomial would likely be that of 
% the fourth degree as the x(t) function seems to have three 
% local extremes. 
% Run the following block of code to see how the “PolyFit” 
% setting of the “Type” parameter compares to spline 
% interpolation and differentiation, the ZFindDerivative function 
% with the default settings, and the actual velocity function. 

T = [0; 1; 2; 3; 4; 5; 6; 7; 8];
X = [0; 0.841470984807897; 0.909297426825682;
    0.141120008059867; -0.756802495307928;
    -0.958924274663138; -0.279415498198926;
   0.656986598718789; 0.989358246623382];
xData = T; yData = X; 
xDerivative = (linspace(-1, 9, 1000))';   % Time points at which 
                                                                 % v(t) is to be evaluated. 
yDerivativeDefault = ZFindDerivative(xData, yData, ...
    xDerivative);   % v(t) estimation using default settings. 
yDerivativeSpline = ZFindDerivative(xData, yData, xDerivative, ...
    'Type', 'Spline');   % v(t) estimation using spline interpolation. 
polyDegree = 4;   % Degree of the regression polynomial. 
yDerivativePolyFit = ZFindDerivative(xData, yData, xDerivative, ...
    'Type', 'PolyFit', ...
    polyDegree);   % v(t) estimation using the regression 
                              % polynomial. 
vActual = cos(xDerivative);   % Actual v(t). 
close all; figure(1); hold on;
plot(xDerivative, vActual, 'k', 'LineWidth', 1.5);
plot(xDerivative, yDerivativeDefault, 'b', 'LineWidth', 1.5);
plot(xDerivative, yDerivativeSpline, 'r', 'LineWidth', 1.5);
plot(xDerivative, yDerivativePolyFit, 'g', 'LineWidth', 1.5);
xlabel('t [s]'); ylabel('v [m / s]'); set(gca, 'FontSize', 14); grid on;
legend('Actual', 'Estimated using default settings', ...
    'Estimated using the spline interpolation', ...
    'Estimated using the regression polynomial');
clearvars; clc;


%                                           Page 8
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% At times it may be important to visualize the function which is 
% differentiated to calculate the numerical derivative. In such 
% cases, the optional “Figure” parameter can be set to the figure 
% index in which the function is to be visualized. Setting the 
% “Figure” parameter to “0” results in no visualization. 
% Run the following block of code to visualize the data points 
% along with the functions which were differentiated for each of 
% the numerical derivatives calculated on the previous page. 

T = [0; 1; 2; 3; 4; 5; 6; 7; 8];
X = [0; 0.841470984807897; 0.909297426825682;
    0.141120008059867; -0.756802495307928;
    -0.958924274663138; -0.279415498198926;
   0.656986598718789; 0.989358246623382];
xData = T; yData = X; 
xDerivative = (linspace(-1, 9, 1000))';   % Time points at which 
                                                                 % v(t) is to be evaluated. 
close all; hold on;
figr1 = 1;   % Figure paramater value 
yDerivativeDefault = ZFindDerivative(xData, yData, xDerivative, ...
    'Figure', figr1);   % v(t) estimation using default settings. 
title('Default settings of ZFindDerivative function');
figr2 = 2;   % Figure paramater value 
yDerivativeSpline = ZFindDerivative(xData, yData, xDerivative, ...
    'Type', 'Spline', ...
    'Figure', figr2);   % v(t) estimation using spline interpolation.
title('Spline interpolation');
polyDegree = 4;   % Degree of the regression polynomial. 
figr3 = 3;   % Figure paramater value 
yDerivativePolyFit = ZFindDerivative(xData, yData, xDerivative, ...
    'Type', 'PolyFit', polyDegree, ...
    'Figure', figr3);   % v(t) estimation using the regression 
                                % polynomial. 
title('Regression polynomial');
clearvars; clc;


%                                           Page 9
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% This completes the tutorial for the ZFindDerivative function. 
% For further questions, the documentation and the code of the 
% function and its subfunctions should be referred to. 


%                                           Page 10
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%