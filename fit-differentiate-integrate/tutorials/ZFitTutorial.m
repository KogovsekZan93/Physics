% Supposedly one measures the variable x which is a function of 
% the variable y. This gives us two corresponding vectors of 
% measurements: 'xData' for the x variable and 'yData' for the y 
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
    70];   % The vector of missing integer values of the x variable 
              % at which the y variable was not measured. 
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
% ways, determined by the optional parameter named ''Type''. 
% The possible settings of the 'Type' parameter are ''A'', 
% ''Spline'', and ''PolyFit''. 
% With the default setting ''A'', a piecewise interpolation 
% polynomial is used. The degree of the piecewise interpolation 
% polynomial can be set using the optional parameter named 
% ''PseudoAccuracy'', the default value of which is 1 (hence 
% the linear interpolation with default settings). 
% Run the following block of code to see the impact of the 
% variation of the 'PseudoAccuracy' parameter on the estimated 
% missing values of the y variable. 

xData = [0; 1; 3; 5; 8; 35; 37; 40; 45; 56; 57; 60; 66; 68];
yData = [10; 9; 8; 11; 13; 5; 4; 3; 2; 6; 11; 12; 2; 8];
xMissing = [-5; -4; -3; -2; -1; 2; 4; 6; 7; 9; 10; 11; 12; 13; 14; 15; ...
    16; 17; 18; 19; 20; 21; 22; 23; 24; 25; 26; 27; 28; 29; 30; 31; ...
    32; 33; 34; 36; 38; 39; 41; 42; 43; 44; 46; 47; 48; 49; 50; 51; ...
    52; 53; 54; 55; 58; 59; 61; 62; 63; 64; 65; 67; 69; ...
    70];   % The vector of missing integer values of the x variable 
              % at which the y variable was not measured. 
close all;
PseudoAccuracy = 1;
yMissing1 = ZFindFit(xData, yData, xMissing, ...
    'PseudoAccuracy', PseudoAccuracy);   % 'PseudoAccuracy' 
                                                                       % paramater set to 1. 
figure(1); hold on;
plot(xData, yData, 'bo', 'MarkerSize', 10);
plot(xMissing, yMissing1, 'ro', 'MarkerSize', 10);
xlabel('x'); ylabel('y'); legend('Data points', ...
    'Points estimated using ZFindFit function');
set(gca, 'FontSize', 14); grid on; hold off;
title('''PseudoAccuracy'' = 1');
PseudoAccuracy = 2;
yMissing2 = ZFindFit(xData, yData, xMissing, ...
    'PseudoAccuracy', PseudoAccuracy);   % 'PseudoAccuracy' 
                                                                       % paramater set to 2. 
figure(2); hold on;
plot(xData, yData, 'bo', 'MarkerSize', 10);
plot(xMissing, yMissing2, 'ro', 'MarkerSize', 10);
xlabel('x'); ylabel('y'); legend('Data points', ...
    'Points estimated using ZFindFit function');
set(gca, 'FontSize', 14); grid on; hold off;
title('''PseudoAccuracy'' = 2');
PseudoAccuracy = 3;
yMissing3 = ZFindFit(xData, yData, xMissing, ...
    'PseudoAccuracy', PseudoAccuracy);   % 'PseudoAccuracy' 
                                                                       % paramater set to 3. 
figure(3); hold on;
plot(xData, yData, 'bo', 'MarkerSize', 10);
plot(xMissing, yMissing3, 'ro', 'MarkerSize', 10);
xlabel('x'); ylabel('y'); legend('Data points', ...
    'Points estimated using ZFindFit function');
set(gca, 'FontSize', 14); grid on; hold off;
title('''PseudoAccuracy'' = 3');
clearvars -except xData yData xMissing ...
    yMissing1 yMissing2 yMissing3; clc;


%                                           Page 3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% With the ''A'' setting of the 'Type' optional parameter, in 
% addition to the 'PseudoAccuracy' optional parameter, the 
% optional parameter named ''Mode'' can also be set. The 
% possible settings are 0, 1, and 2, the default being 1. The 
% setting of the 'Mode' parameter determines the method by 
% which the data points are selected and the boundaries are 
% calculated for each of the interpolation polynomials of the 
% piecewise interpolation polynomial function. 
% Generally, the variation of the 'Mode' parameter only has an 
% impact when the data points are moderately to highly 
% unequally spaced along the abscissa coordinate, as is indeed 
% the case with the example presented in this tutorial. For further 
% information, the documentation of the ZFindFit function and its 
% subfunctions should be referred to. 
% Run the following block of code to see the impact of the 
% variation of the 'Mode' parameter on the estimated values of 
% the y variable. The 'PseudoAccuracy' parameter is set to 3 in 
% all cases. 

xData = [0; 1; 3; 5; 8; 35; 37; 40; 45; 56; 57; 60; 66; 68];
yData = [10; 9; 8; 11; 13; 5; 4; 3; 2; 6; 11; 12; 2; 8];
xMissing = [-5; -4; -3; -2; -1; 2; 4; 6; 7; 9; 10; 11; 12; 13; 14; 15; ...
    16; 17; 18; 19; 20; 21; 22; 23; 24; 25; 26; 27; 28; 29; 30; 31; ...
    32; 33; 34; 36; 38; 39; 41; 42; 43; 44; 46; 47; 48; 49; 50; 51; ...
    52; 53; 54; 55; 58; 59; 61; 62; 63; 64; 65; 67; 69; ...
    70];   % The vector of missing integer values of the x variable 
              % at which the y variable was not measured. 
PseudoAccuracy = 3;   % 'PseudoAccuracy' paramater set to 3. 
close all;
Mode = 0;
yMissing0 = ZFindFit(xData, yData, xMissing, ...
    'PseudoAccuracy', PseudoAccuracy, ...
    'Mode', Mode);   % 'Mode' paramater set to 0. 
figure(1); hold on;
plot(xData, yData, 'bo', 'MarkerSize', 10);
plot(xMissing, yMissing0, 'ro', 'MarkerSize', 10);
xlabel('x'); ylabel('y'); legend('Data points', ...
    'Points estimated using ZFindFit function');
set(gca, 'FontSize', 14); grid on; hold off;
title('''Mode'' = 0');
Mode = 1;
yMissing1 = ZFindFit(xData, yData, xMissing, ...
    'PseudoAccuracy', PseudoAccuracy, ...
    'Mode', Mode);   % 'Mode' paramater set to 1. 
figure(2); hold on;
plot(xData, yData, 'bo', 'MarkerSize', 10);
plot(xMissing, yMissing1, 'ro', 'MarkerSize', 10);
xlabel('x'); ylabel('y'); legend('Data points', ...
    'Points estimated using ZFindFit function');
set(gca, 'FontSize', 14); grid on; hold off;
title('''Mode'' = 1');
Mode = 2;
yMissing2 = ZFindFit(xData, yData, xMissing, ...
    'PseudoAccuracy', PseudoAccuracy, ...
    'Mode', Mode);   % 'Mode' paramater set to 2. 
figure(3); hold on;
plot(xData, yData, 'bo', 'MarkerSize', 10);
plot(xMissing, yMissing2, 'ro', 'MarkerSize', 10);
xlabel('x'); ylabel('y'); legend('Data points', ...
    'Points estimated using ZFindFit function');
set(gca, 'FontSize', 14); grid on; hold off;
title('''Mode'' = 2');
clearvars -except xData yData xMissing ...
    yMissing0 yMissing1 yMissing2; clc;


%                                           Page 4
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% By setting the 'Type' parameter to ''Spline'', the estimation of 
% the missing values is calculated using the cubic spline of the 
% data points. As the cubic spline is exactly determined for a 
% given set of data points, with the ''Spline'' setting of the 'Type' 
% parameter, there are no optional parameters 
% 'PseudoAccuracy' or 'Mode'. 
% Run the following block of code to estimate the missing 
% values of the y variable for the example given in this tutorial 
% using the ''Spline'' setting of the 'Type' parameter. 

xData = [0; 1; 3; 5; 8; 35; 37; 40; 45; 56; 57; 60; 66; 68];
yData = [10; 9; 8; 11; 13; 5; 4; 3; 2; 6; 11; 12; 2; 8];
xMissing = [-5; -4; -3; -2; -1; 2; 4; 6; 7; 9; 10; 11; 12; 13; 14; 15; ...
    16; 17; 18; 19; 20; 21; 22; 23; 24; 25; 26; 27; 28; 29; 30; 31; ...
    32; 33; 34; 36; 38; 39; 41; 42; 43; 44; 46; 47; 48; 49; 50; 51; ...
    52; 53; 54; 55; 58; 59; 61; 62; 63; 64; 65; 67; 69; ...
    70];   % The vector of missing integer values of the x variable 
              % at which the y variable was not measured. 
close all;
yMissingSpline = ZFindFit(xData, yData, xMissing, ...
    'Type', 'Spline');   % Setting the 'Type' parameter to ''Spline''. 
figure(1); hold on;
plot(xData, yData, 'bo', 'MarkerSize', 10);
plot(xMissing, yMissingSpline, 'ro', 'MarkerSize', 10);
xlabel('x'); ylabel('y'); legend('Data points', ...
    'Points estimated using ZFindFit function');
set(gca, 'FontSize', 14); grid on; hold off;
title('''Type'' = ''''Spline''''');
clearvars -except xData yData xMissing yMissingSpline; clc;


%                                           Page 5
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Alternatively, the 'Type' parameter can be set to ''PolyFit'' in 
% order to estimate the missing values using the regression 
% polynomial of the data points. The order of the regression 
% polynomial must be specified using the required 
% 'PolyDegree' parameter. As with the ''Spline'' setting of the 
% 'Type' parameter, the optional parameters 'PseudoAccuracy' 
% and 'Mode' are not available. 
% As can be seen by running the block of code on Page 1, the 
% function y(x) appears to have four local extremes. Perhaps an 
% appropriate choice for the order of the regression polynomial 
% could thus be five. 
% Run the following block of code to estimate the missing 
% values of the y variable for the example given in this tutorial 
% using the ''PolyFit'' setting of the 'Type' parameter. The 
% 'PolyDegree' parameter is set to be 5 for reasons discussed 
% in the previous paragraph. 

xData = [0; 1; 3; 5; 8; 35; 37; 40; 45; 56; 57; 60; 66; 68];
yData = [10; 9; 8; 11; 13; 5; 4; 3; 2; 6; 11; 12; 2; 8];
xMissing = [-5; -4; -3; -2; -1; 2; 4; 6; 7; 9; 10; 11; 12; 13; 14; 15; ...
    16; 17; 18; 19; 20; 21; 22; 23; 24; 25; 26; 27; 28; 29; 30; 31; ...
    32; 33; 34; 36; 38; 39; 41; 42; 43; 44; 46; 47; 48; 49; 50; 51; ...
    52; 53; 54; 55; 58; 59; 61; 62; 63; 64; 65; 67; 69; ...
    70];   % The vector of missing integer values of the x variable 
              % at which the y variable was not measured. 
close all;
PolyDegree = 5;   % Setting the degree of the regression 
                               % polynomial. 
yMissingPolyFit = ZFindFit(xData, yData, xMissing, ...
    'Type', 'PolyFit', ...   % Setting the 'Type' parameter to 
...                                   % ''PolyFit''. 
    PolyDegree);
figure(1); hold on;
plot(xData, yData, 'bo', 'MarkerSize', 10);
plot(xMissing, yMissingPolyFit, 'ro', 'MarkerSize', 10);
xlabel('x'); ylabel('y'); legend('Data points', ...
    'Points estimated using ZFindFit function');
set(gca, 'FontSize', 14); grid on; hold off;
title('''Type'' = ''''PolyFit''''');
clearvars -except xData yData xMissing yMissingPolyFit; clc;


%                                           Page 6
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% So far, the ZFitTutorial function has been used to estimate the 
% missing values of the y variable. After that, the estimated data 
% points along with the measured data points were plotted 
% manually. 
% With ZFitFunction, the function which is calculated to estimate 
% the missing data points as well as the measured (i.e. input) 
% data points can easily be visualized by specifying the index of 
% the figure window in which the plot is to be performed. This 
% can be done by changing the optional parameter named 
% ''Figure'' from its default value of 0 to a desired natural 
% number which is to be the index of the figure window. 
% Run the following block of code to visualize the data points 
% along an example of the ZFitTutorial function calculated curve 
% used for the missing data estimation for the example 
% presented in this tutorial in Figure 4. 

xData = [0; 1; 3; 5; 8; 35; 37; 40; 45; 56; 57; 60; 66; 68];
yData = [10; 9; 8; 11; 13; 5; 4; 3; 2; 6; 11; 12; 2; 8];
xMissing = [-5; -4; -3; -2; -1; 2; 4; 6; 7; 9; 10; 11; 12; 13; 14; 15; ...
    16; 17; 18; 19; 20; 21; 22; 23; 24; 25; 26; 27; 28; 29; 30; 31; ...
    32; 33; 34; 36; 38; 39; 41; 42; 43; 44; 46; 47; 48; 49; 50; 51; ...
    52; 53; 54; 55; 58; 59; 61; 62; 63; 64; 65; 67; 69; ...
    70];   % The vector of missing integer values of the x variable 
              % at which the y variable was not measured. 
close all;
PseudoAccuracy = 3;   % 'PseudoAccuracy' paramater set to 3. 
Mode = 2;   % 'Mode' paramater set to 2. 
Figure = 4;
yMissing = ZFindFit(xData, yData, xMissing, ...
    'PseudoAccuracy', PseudoAccuracy, 'Mode', Mode, ...
    'Figure', Figure);   % 'Figure' paramater set to 4. 
clearvars -except xData yData xMissing yMissing; clc;


%                                           Page 7
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% This completes the tutorial for the ZFindFit function. 
% For further questions, the documentation and the code of the 
% function and its subfunctions should be referred to. 


%                                           Page 8
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%