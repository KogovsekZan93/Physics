% Supposedly one measures a variable which is a function of 
% time t, such as the velocity v in the x coordinate. The value of v 
% is measured each second. This gives us two corresponding 
% vectors of measurements: T for time and V for the velocity v. 
% Let us plot the measurements. Run the following block of 
% code. 

T = [0; 1; 2; 3; 4; 5; 6; 7; 8];
V = [1.000000000000000; 1.909297426825682;
    0.243197504692072; 0.720584501801074;
    1.989358246623382; 0.455978889110630;
    0.463427081999565; 1.990607355694870;
    0.712096683334935];
close all; figure(1); plot(T, V, 'bo', 'MarkerSize', 10);
xlabel('t [s]'); ylabel('v [m / s]'); set(gca, 'FontSize', 14); grid on;
clear all; clc;   % Clearing variables and workspace is done at or 
                        % near the end of after each block of code for the 
                        %purposes of clarity of this tutorial. 


%                                           Page 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Supposedly one knows that the value of the x coordinate at 
% t == 0 is x == 3 m and wants to find the value of the x 
% coordinate at t === 8 s. In order to do that, one has to 
% integrate the velocity function v(t) from t == 0 to t == 8 s. In this 
% time interval, the velocity function as a whole is unknown as 
% only the values in nine specific time points have been 
% measured. In such cases, numerical integration can be 
% performed to give an estimation of the actual value of the x 
% coordinate at t == 0. 
% The ZFindDefiniteIntegral function is a tool which can be used 
% to do just that. 
% Run the following block of code to numerically integrate the 
% velocity function from t == 0 to t == 8. 

T = [0; 1; 2; 3; 4; 5; 6; 7; 8];
V = [1.000000000000000; 1.909297426825682;
    0.243197504692072; 0.720584501801074;
    1.989358246623382; 0.455978889110630;
    0.463427081999565; 1.990607355694870;
    0.712096683334935];
xData = T; yData = V; 
xMin = 0;   % Lower limit of integration. 
xMax = 8;   % Upper limit of integration. 
Limits = [xMin; xMax];   % Limits of integration. 
DefiniteIntegral = ZFindDefiniteIntegral(xData, yData, Limits);
close all;
clearvars -except DefiniteIntegral; clc;
DefiniteIntegral   %Display the calculated value in the command 
                             % window. 

% To calculate the value of the x coordinate at t == 8 s, add 3 
% (== x(t == 0) in meters) to the DefiniteIntegralA value. You can 
% do so by running the following block of code. 

clc;
x_at_t_equals_8_s = DefiniteIntegral + 3;
x_at_t_equals_8_s


%                                           Page 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% The idea behind numerical integration is to estimate the 
% function based on the numerical data and then integrate it. By 
% using the ZFindDefiniteIntegral function with its default 
% settings, the function being integrated is estimated to be 
% piecewise constant.
% Let’s visualize this by specifying the index of the Figure 
% window in which the measurements, the estimated function, 
% and the area under the integrated curve is to be plotted in the 
% optional parameters of the ZFindDefiniteIntegral function. 
% Run the following block of code. 

T = [0; 1; 2; 3; 4; 5; 6; 7; 8];
V = [1.000000000000000; 1.909297426825682;
    0.243197504692072; 0.720584501801074;
    1.989358246623382; 0.455978889110630;
    0.463427081999565; 1.990607355694870;
    0.712096683334935];
xData = T; yData = V; 
xMin = 2.2;   % Lower limit of integration. 
xMax = 11;   % Upper limit of integration. 
Limits = [xMin; xMax];   % Limits of integration. 
figr = 1;   % Index of the Figure window. 
close all;
ZFindDefiniteIntegral(xData, yData, Limits, 'Figure', figr);
xlabel('t [s]'); ylabel('v [m / s]');
clear all; clc;


%                                           Page 3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Now, in some cases, a piecewise interpolation polynomial of a 
% higher order may be more appropriate for the estimation of 
% the v(t) function. In such cases, we can specify the so called 
% “Pseudo Accuracy” parameter as the optional parameter of 
% the ZFindDefiniteIntegral function. The Pseudo Accuracy 
% parameter of the FindDefiniteIntegral function is the order of 
% the piecewise interpolation polynomial with which the function 
% is to be estimated. 
% Let’s try to estimate the v(t) function to be a piecewise cubic 
%  interpolation polynomial by running the following block of 
% code. 

T = [0; 1; 2; 3; 4; 5; 6; 7; 8];
V = [1.000000000000000; 1.909297426825682;
    0.243197504692072; 0.720584501801074;
    1.989358246623382; 0.455978889110630;
    0.463427081999565; 1.990607355694870;
    0.712096683334935];
xData = T; yData = V; 
xMin = 0;   % Lower limit of integration. 
xMax = 8;   % Upper limit of integration. 
Limits = [xMin; xMax];   % Limits of integration. 
psacc = 3;   % Pseudo Accuracy parameter. 
figr = 1;   % Index of the Figure window. 
close all;
DefiniteIntegral = ZFindDefiniteIntegral(xData, yData, Limits, ...
    'PseudoAccuracy', psacc, 'Figure', figr);
clearvars -except DefiniteIntegral; clc;
xlabel('t [s]'); ylabel('v [m / s]');
x_at_t_equals_8_s = DefiniteIntegral + 3   % Remember, the 
                                                                        % value of the x 
                                                                        % coordinate at time 
                                                                        % t == 0 is 3 m. 
clearvars DefiniteIntegral;


%                                           Page 4
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% At this point, it may become apparent that the actual velocity 
% function might be a kind of a sinusoidal function. Indeed, the 
% velocity in m / s is represented by the function 
% v(t) = sin(2 * t) + 1 if time t is expressed in seconds. It is 
% important to note that increasing the value of the "Pseudo 
% Accuracy" parameter may not result in a more accurate 
% estimation of the function being integrated even if the function 
% is analytical. For example, if the "Pseudo Accuracy" parameter 
% is increased to the maximum possible value of 
% "PseudoAccuracy == 9 - 1" ("9" is the size of the velocity/time 
% data vector), the estimated velocity function resembles the 
% actual velocity function less. The estimated value of the x 
% coordinate at t == 8 s is also less close to the actual value, 
% which is about 11.98 m (it was estimated to be about 12.41 m 
% with "PseudoAccuracy == 3"). 
% Run the following block of code to see for yourself. 

T = [0; 1; 2; 3; 4; 5; 6; 7; 8];
V = [1.000000000000000; 1.909297426825682;
    0.243197504692072; 0.720584501801074;
    1.989358246623382; 0.455978889110630;
    0.463427081999565; 1.990607355694870;
    0.712096683334935];
xData = T; yData = V; 
xMin = 0;   % Lower limit of integration. 
xMax = 8;   % Upper limit of integration. 
Limits = [xMin; xMax];   % Limits of integration. 
psacc = 9 - 1;   % Pseudo Accuracy parameter. 
figr = 1;   % Index of the Figure window. 
close all;
DefiniteIntegral = ZFindDefiniteIntegral(xData, yData, Limits, ...
    'PseudoAccuracy', psacc, 'Figure', figr);
TT = linspace(min(T), max(T), 1000); VV = sin(2 * TT) + 1;
hold on; plot(TT, VV, 'k', 'LineWidth', 1.5);   % Plot the actual 
                                                                        % velocity function. 
xlabel('t [s]'); ylabel('v [m / s]'); legend('', 'Estimated', '', 'Actual');
clearvars -except DefiniteIntegral; clc;
x_at_t_equals_8_s = DefiniteIntegral + 3
clearvars DefiniteIntegral;


%                                           Page 5
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% It is also possible to find the numerical indefinite integral 
% VIndefiniteIntegral of the velocity function using the 
% ZFindIndefiniteIntegral function by providing the vector of 
% values TIntegralA at which the indefinite integral is to be 
% evaluated. 
% At the first (lowest) value of TIntegral, the value of 
% VIndefiniteIntegral is zero by default. At t == 0, the value of the 
% x coordinate is 3 m. Therefore, if "TIntegral (1) == 0", to 
% estimate the x coordinate at the time points of the TIntegral 
% vector, the number 3 has to be added to the 
% VIndefiniteIntegral vector for it to equal the vector X of 
% estimated values of the coordinate x at time points of 
% TIntegral. 
% Run the following block of code to see the comparison 
% between the actual and the estimated x(t) function for 
% Pseudo Accuracy == 3.

T = [0; 1; 2; 3; 4; 5; 6; 7; 8];
V = [1.000000000000000; 1.909297426825682;
    0.243197504692072; 0.720584501801074;
    1.989358246623382; 0.455978889110630;
    0.463427081999565; 1.990607355694870;
    0.712096683334935];
TIntegral = (linspace(0, 8, 1000))';
xData = T; yData = V; 
xIntegral = TIntegral;
psacc = 3;   % Pseudo Accuracy parameter. 
close all;
VIndefiniteIntegral = ZFindIndefiniteIntegral(xData, yData, ...
    xIntegral, 'PseudoAccuracy', psacc);
X_estimated = VIndefiniteIntegral + 3;
figure(1); clf;
plot(TIntegral, X_estimated, 'r', 'LineWidth', 1.2)   % Plot the 
                                                                                   % estimated 
                                                                                   % x(t) function. 
TT = linspace(0, 8, 1000); XX_actual = -cos(2 * TT)/2 + TT + 3.5;
hold on; plot(TT, XX_actual, 'k', 'LineWidth', 1.5);   % Plot the 
                                                                                     % actual x(t) 
                                                                                     % function. 
grid on;
xlabel('t [s]'); ylabel('x [m]'); set(gca, 'FontSize', 14);
legend('Estimated', 'Actual');
clearvars -except TIntegral XEstimated TT XX_actual; clc;


%                                           Page 6
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% There is also the optional "Mode" parameter for both the 
% ZFindDefiniteIntegral function and the ZFindIndefiniteIntegral 
% function, with which modes from 0 to 2 can be chosen 
% ("Mode == 1" being the default). If the sampling points are 
% reasonably equally spaced, the Mode parameter makes little 
% to no difference. If the sampling points are highly unequally far 
% apart, the three different “Modes” give different answers to the 
% question: “What are the appropriate points at which one piece 
% of the piecewise  interpolation polynomial function ends and 
% the other begins?” 
% For details, the documentation of the GetIpointsSmatrix 
% function should be read. In this tutorial, the impact of the 
% “Mode” parameter can be seen by running one of the two 
% following blocks of code. The three figures generated show 
% how the estimated y(x) function varies with the “Mode” 
% parameter when sampling points of the x variable are highly 
% unequally spaced. 

mode = 0;   % Mode parameter.
xData = [0; 1; 3; 5; 8; 35; 37; 40; 45];
yData = [10; 9; 8; 11; 13; 5; 4; 3; 2];
xMin = 0;   % Lower integration limit. 
xMax = 45;   % Upper integration limit. 
Limits = [xMin; xMax];   % Limits of integration. 
psacc = 3;	% Pseudo Accuracy parameter. 
figr = 1;   % Index of the Figure window. 
close all;
DefiniteIntegral = ZFindDefiniteIntegral(xData, yData, Limits, ...
    'PseudoAccuracy', psacc, 'Mode', mode, 'Figure', figr);
xlabel('x'); ylabel('y');
title(['Mode == 0, DefiniteIntegral = ', num2str(DefiniteIntegral)]);
mode = 1; figr = 2;    % Changing Mode parameter to 1
DefiniteIntegral = ZFindDefiniteIntegral(xData, yData, Limits, ...
    'PseudoAccuracy', psacc, 'Mode', mode, 'Figure', figr);
xlabel('x'); ylabel('y');
title(['Mode == 1, DefiniteIntegral = ', num2str(DefiniteIntegral)]);
mode = 2; figr = 3;    % Changing Mode parameter to 2
DefiniteIntegral = ZFindDefiniteIntegral(xData, yData, Limits, ...
    'PseudoAccuracy', psacc, 'Mode', mode, 'Figure', figr);
xlabel('x'); ylabel('y');
title(['Mode == 2, DefiniteIntegral = ', num2str(DefiniteIntegral)]);
clearvars; clc;

mode = 0;   % Mode parameter.
xData = [-3; -2; 3; 4; 5; 8];
yData = sin(xData);
xMin = -2;   % Lower integration limit. 
xMax = 4;	% Upper integration limit. 
Limits = [xMin; xMax];   % Limits of integration. 
psacc = 2;   % Pseudo Accuracy parameter. 
figr = 1;   % Index of the Figure window. 
close all;
DefiniteIntegral = ZFindDefiniteIntegral(xData, yData, Limits, ...
    'PseudoAccuracy', psacc, 'Mode', mode, 'Figure', figr);
xlabel('x'); ylabel('y');
title(['Mode == 0, DefiniteIntegral = ', num2str(DefiniteIntegral)]);
xx = linspace(min(xData), max(xData), 1000); yy_actual = sin(xx);
hold on; plot(xx, yy_actual, 'k', 'LineWidth', 1.5);   % Plot the 
                                                                                  % actual 
                                                                                  % function. 
mode = 1; figr = 2;    % Changing Mode parameter to 1
DefiniteIntegral = ZFindDefiniteIntegral(xData, yData, Limits, ...
    'PseudoAccuracy', psacc, 'Mode', mode, 'Figure', figr);
xlabel('x'); ylabel('y');
title(['Mode == 1, DefiniteIntegral = ', num2str(DefiniteIntegral)]);
hold on; plot(xx, yy_actual, 'k', 'LineWidth', 1.5);
mode = 2; figr = 3;    % Changing Mode parameter to 2
DefiniteIntegral = ZFindDefiniteIntegral(xData, yData, Limits, ...
    'PseudoAccuracy', psacc, 'Mode', mode, 'Figure', figr);
xlabel('x'); ylabel('y');
title(['Mode == 2, DefiniteIntegral = ', num2str(DefiniteIntegral)]);
hold on; plot(xx, yy_actual, 'k', 'LineWidth', 1.5);
Actual_value = -cos(xMax) + cos(xMin);
clearvars -except Actual_value; clc;
Actual_value   %Display the actual value of the definite integral. 


%                                           Page 7
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Alternatively, the definite or the indefinite numerical integral 
% can be found by estimating the function being integrated to be 
% the cubic spline of the data points. This can be done by 
% altering the optional “Type” parameter to “Spline” of either the 
% ZDefiniteIntegral function or the ZIndefiniteIntegral function. 
% The default “Type” parameter, which has been used until this 
% point in the tutorial, is “A”. Note that due to spline being fully 
% defined by a specific set of data points, there are no optional 
% parameters “Pseudo Accuracy” and “Mode” with the “Type” 
% parameter set to “Spline”. 
% The following two blocks of code refer to the previous 
% problem of velocity being measured each second from t == 0 
% to t == 8 s. 
% Run the first block of code to estimate the value of the x 
% coordinate at t == 8 s by using definite numerical integration 
% with cubic spline interpolation. Just as a reminder, the actual 
% value of the x coordinate at t == 8 s is about 11.98 m. 
% Run the second block of code to estimate the x(t) function for 
% the time interval [0, 8 s] by using indefinite integration with 
% cubic spline interpolation and compare it to the actual x(t) 
% function.

T = [0; 1; 2; 3; 4; 5; 6; 7; 8];
V = [1.000000000000000; 1.909297426825682;
    0.243197504692072; 0.720584501801074;
    1.989358246623382; 0.455978889110630;
    0.463427081999565; 1.990607355694870;
    0.712096683334935];
xData = T; yData = V; 
xMin = 0;   % Lower limit of integration. 
xMax = 8;   % Upper limit of integration. 
Limits = [xMin; xMax];   % Limits of integration. 
figr = 1;   % Index of the Figure window. 
close all;
DefiniteIntegral = ZFindDefiniteIntegral(xData, yData, Limits, ...
    'Type', 'Spline', 'Figure', figr);
TT = linspace(min(T), max(T), 1000); VV = sin(2 * TT) + 1;
hold on; plot(TT, VV, 'k', 'LineWidth', 1.5);   % Plot the actual 
                                                                         % velocity function. 
xlabel('t [s]'); ylabel('v [m / s]'); legend('', 'Estimated', '', 'Actual');
clearvars -except DefiniteIntegral; clc;
x_at_t_equals_8_s = DefiniteIntegral + 3
clearvars DefiniteIntegral;


T = [0; 1; 2; 3; 4; 5; 6; 7; 8];
V = [1.000000000000000; 1.909297426825682;
    0.243197504692072; 0.720584501801074;
    1.989358246623382; 0.455978889110630;
    0.463427081999565; 1.990607355694870;
    0.712096683334935];
TIntegral = (linspace(0, 8, 1000))';
xData = T; yData = V; 
xIntegralA = TIntegral;
VIndefiniteIntegral = ZFindIndefiniteIntegral(xData, yData, ...
    xIntegralA, 'Type', 'Spline');
X_estimated = VIndefiniteIntegral + 3;
TT = linspace(min(T), max(T), 1000); VV = sin(2 * TT) + 1;
close all; figure(1); clf;
plot(TIntegral, X_estimated, 'r', 'LineWidth', 1.2)   % Plot the 
                                                                                   % estimated 
                                                                                   % x(t) function. 
TT = linspace(0, 8, 1000); XX_actual = -cos(2 * TT)/2 + TT + 3.5;
hold on; plot(TT, XX_actual, 'k', 'LineWidth', 1.5);   % Plot the 
                                                                                     % actual x(t) 
                                                                                     % function. 
grid on;
xlabel('t [s]'); ylabel('x [m]'); set(gca, 'FontSize', 14);
legend('Estimated', 'Actual');
clearvars; clc;


%                                           Page 8
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Another alternative is to find either the definite integral or the 
% indefinite integral by integrating the regression polynomial of 
% the data points. This can be done by altering the optional 
% “Type” parameter to “PolyFit” of either the ZDefiniteIntegral 
% function or the ZIndefiniteIntegral function. With this setting of 
% the “Type” parameter, the “PolyDegree” required parameter 
% must be set to specify the degree of the regression 
% polynomial. As with the “Spline” setting of the “Type” 
% parameter, there are no optional parameters 
% “Pseudo Accuracy” and “Mode”. 
% As in the previous page, the following two blocks of code refer 
% to the previous problem of velocity being measured each 
% second from t == 0 to t == 8 s. 
% Run the first block of code to estimate the value of the x 
% coordinate at t == 8 s using the “PolyFit” setting of the “Type” 
% parameter of the ZDefiniteIntegral function. Just as a 
% reminder, the actual value of the x coordinate at t == 8 s is 
% about 11.98 m. 
% Run the second block of code to estimate the x(t) function for 
% the time interval [0, 8 s] by using the “PolyFit” setting of the 
% “Type” parameter of the ZIndefiniteIntegral function and 
% compare it to the actual x(t) function. 
% The »PolyDegree« parameter in both cases is set to 
% "PolyDegree == 6". 

T = [0; 1; 2; 3; 4; 5; 6; 7; 8];
V = [1.000000000000000; 1.909297426825682;
    0.243197504692072; 0.720584501801074;
    1.989358246623382; 0.455978889110630;
    0.463427081999565; 1.990607355694870;
    0.712096683334935];
xData = T; yData = V; 
xMin = 0;   % Lower limit of integration. 
xMax = 8;   % Upper limit of integration. 
Limits = [xMin; xMax];   % Limits of integration. 
PolyDegree = 6;   % Degree of the regression polynomial. 
figr = 1;   % Index of the Figure window. 
close all;
DefiniteIntegral = ZFindDefiniteIntegral(xData, yData, Limits, ...
    'Type', 'PolyFit', PolyDegree, 'Figure', figr);
TT = linspace(min(T), max(T), 1000); VV = sin(2 * TT) + 1;
hold on; plot(TT, VV, 'k', 'LineWidth', 1.5);   % Plot the actual 
                                                                         % velocity function. 
xlabel('t [s]'); ylabel('v [m / s]'); legend('', 'Estimated', '', 'Actual');
clearvars -except DefiniteIntegral; clc;
x_at_t_equals_8_s = DefiniteIntegral + 3
clearvars DefiniteIntegral;


T = [0; 1; 2; 3; 4; 5; 6; 7; 8];
V = [1.000000000000000; 1.909297426825682;
    0.243197504692072; 0.720584501801074;
    1.989358246623382; 0.455978889110630;
    0.463427081999565; 1.990607355694870;
    0.712096683334935];
TIntegral = (linspace(0, 8, 1000))';
xData = T; yData = V; 
xIntegralA = TIntegral;
PolyDegree = 6;   % Degree of the regression polynomial. 
VIndefiniteIntegral = ZFindIndefiniteIntegral(xData, yData, ...
    xIntegralA, 'Type', 'PolyFit', PolyDegree);
X_estimated = VIndefiniteIntegral + 3;
TT = linspace(min(T), max(T), 1000); VV = sin(2 * TT) + 1;
close all; figure(1); clf;
plot(TIntegral, X_estimated, 'r', 'LineWidth', 1.2)   % Plot the 
                                                                                   % estimated 
                                                                                   % x(t) function. 
TT = linspace(0, 8, 1000); XX_actual = -cos(2 * TT)/2 + TT + 3.5;
hold on; plot(TT, XX_actual, 'k', 'LineWidth', 1.5);   % Plot the 
                                                                                     % actual x(t) 
                                                                                     % function. 
grid on;
xlabel('t [s]'); ylabel('x [m]'); set(gca, 'FontSize', 14);
legend('Estimated', 'Actual');
clearvars; clc;


%                                           Page 9
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% This concludes the tutorial for the functions ZDefiniteIntegral 
% and ZIndefiniteIntegral. For further questions, the 
% documentation and the code of the functions and their 
% subfunctions should be referred to. 


%                                           Page 10
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%