% Supposedly one measures a variable which is a function of 
% time t, such as the position of an objected, which is 
% represented by the value of the x coordinate. The value of the 
% x coordinate is measured each second in the 8 second 
% interval. This gives us two corresponding vectors of 
% measurements: T for time and X for the x coordinate.
% Let us plot the measurements. Run the following block of 
% code. 

T = [0; 1; 2; 3; 4; 5; 6; 7; 8];
X = [0; 0.841470984807897; 0.909297426825682;
    0.141120008059867; -0.756802495307928;
    -0.958924274663138; -0.279415498198926;
   0.656986598718789; 0.989358246623382];
close all; figure(1); plot(T, X, 'bo', 'MarkerSize', 10);
xlabel('t [s]'); ylabel('x [m]'); set(gca, 'FontSize', 14); grid on;
clearvars; clc;   % Clearing variables and workspace is done at 
                          % or near the end of after each block of code for 
                          % the purposes of clarity of this tutorial. 


%                                           Page 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Supposedly one wants to find the value of the velocity v in the 
% x coordinate every 0.2 s not only during the time of 
% measurement but also a second before the start and a 
% second after the end of measurements. In such cases, 
% numerical differentiation can be performed to give an 
% estimation of the actual value of the velocity function v(t) at 
% desired time points. 
% The ZFindDerivative function is a tool which can be used to do 
% just that. Run the following block of code to plot the estimated 
% value of the v(t) function every 0.2 s in the time interval 
% [-1 s, 9 s]. 

T = [0; 1; 2; 3; 4; 5; 6; 7; 8];
X = [0; 0.841470984807897; 0.909297426825682;
    0.141120008059867; -0.756802495307928;
    -0.958924274663138; -0.279415498198926;
   0.656986598718789; 0.989358246623382];
xData = T; yData = X; 
xDerivative = (-1 : 0.2 : 9)';   % Time points at which v(t) is to be 
                                               % evaluated. 
yDerivative = ZFindDerivative(xData, yData, ...
    xDerivative);   % v(t) estimation. 
close all; figure(1);
plot(xDerivative, yDerivative, 'bo', 'MarkerSize', 10);
xlabel('t [s]'); ylabel('v [m / s]'); set(gca, 'FontSize', 14); grid on;
clearvars; clc;


%                                           Page 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% How accurate was that estimation of v(t)? It is almost 
% impossible to know exactly at this point. 
% The actual x(t) function in our case is x(t) = sin(t) if the value of 
% the x coordinate is expressed in meters and time t is 
% expressed in seconds. This means that the actual velocity 
% function v(t) is v(t) = cos(t) if the velocity v is expressed in 
% meters per second (m / s) and time t is expressed in seconds. 
% Run the following block of code to add the actual velocity 
% function v(t) to the plot of the estimated values of the velocity 
% function. 

T = [0; 1; 2; 3; 4; 5; 6; 7; 8];
X = [0; 0.841470984807897; 0.909297426825682;
    0.141120008059867; -0.756802495307928;
    -0.958924274663138; -0.279415498198926;
   0.656986598718789; 0.989358246623382];
xData = T; yData = X; 
xDerivative = (-1 : 0.2 : 9)';   % Time points at which v(t) is to be 
                                               % evaluated. 
yDerivative = ZFindDerivative(xData, yData, ...
    xDerivative);   % v(t) estimation. 
TT = (linspace(-1, 9, 1000))';
vActual = cos(TT);   % Actual v(t). 
close all; figure(1); hold on;
plot(TT, vActual, 'k', 'LineWidth', 1.5);
plot(xDerivative, yDerivative, 'bo', 'MarkerSize', 10);
xlabel('t [s]'); ylabel('v [m / s]'); set(gca, 'FontSize', 14); grid on;
legend('Actual', 'Estimated');
clearvars; clc;


%                                           Page 3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Supposedly one also wants to find the acceleration a in the x 
% coordinate every 0.5 second in the time interval [-1 s, 9 s]. 
% To find the acceleration in the x coordinate, the second-order 
% derivative of the position in the x coordinate would have to be 
% calculated. The second- and higher-order numerical 
% differentiation can, too, be performed using the 
% ZFindDerivative function to find an estimation of the a(t) 
% function. The order of differentiation can be specified using 
% the optional parameter “OrdDeriv”, the default value of which 
% is “OrdDeriv == 1”. 
% The actual acceleration function a(t) is a(t) = -sin(t) if time t is 
% expressed in seconds and the acceleration a in the x 
% coordinate is expressed in m / (s^2). 
% Run the following to block to compare the actual acceleration 
% function a(t) to the estimated values of a(t) in the specified 
% time points. 

T = [0; 1; 2; 3; 4; 5; 6; 7; 8];
X = [0; 0.841470984807897; 0.909297426825682;
    0.141120008059867; -0.756802495307928;
    -0.958924274663138; -0.279415498198926;
   0.656986598718789; 0.989358246623382];
xData = T; yData = X; 
xDerivative = (-1 : 0.5 : 9)';   % Time points at which a(t) is to be 
                                               % evaluated. 
ordDeriv = 2;   % Order of differentiation. 
yDerivative = ZFindDerivative(xData, yData, ...
    xDerivative, 'OrdDeriv', ordDeriv);   % a(t) estimation. 
TT = (linspace(-1, 9, 1000))';
aActual = -sin(TT);   % Actual a(t). 
close all; figure(1); hold on;
plot(TT, aActual, 'k', 'LineWidth', 1.5);
plot(xDerivative, yDerivative, 'bo', 'MarkerSize', 10);
xlabel('t [s]'); ylabel('a [m / s^2]'); set(gca, 'FontSize', 14); grid on;
legend('Actual', 'Estimated');
clearvars; clc;

% As with the velocity function v(t), the estimated acceleration 
% function is reasonably close to the actual acceleration function 
% a(t) inside the time interval in which the position in the x 
% coordinate was measured and much less so outside of it. 


%                                           Page 4
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% How is numerical differentiation performed? In general, a 
% differentiable function which is associated with the measured 
% data is assumed and then differentiated. With default settings 
% of the ZFindDerivative function, the function assumed is a 
% piecewise interpolation polynomial of the N-th degree, where 
% N is the sum of the desired order of accuracy and the order of 
% differentiation. The order of accuracy is represented by the 
% optional parameter “Accuracy”, the default value of which is 
% “Accuracy == 2”. 
% With the following block of code, you can vary the value of the 
% “Accuracy” parameter and see how this changes the 
% estimated values of the acceleration function considered in 
% the previous page and compare it to the actual acceleration 
% function a(t). 

T = [0; 1; 2; 3; 4; 5; 6; 7; 8];
X = [0; 0.841470984807897; 0.909297426825682;
    0.141120008059867; -0.756802495307928;
    -0.958924274663138; -0.279415498198926;
   0.656986598718789; 0.989358246623382];
xData = T; yData = X; 
xDerivative = (-1 : 0.5 : 9)';   % Time points at which a(t) is to be 
                                               % evaluated. 
ordDeriv = 2;   % Order of differentiation. 
acc = 2;   % Accuracy. 
yDerivative = ZFindDerivative(xData, yData, ...
    xDerivative, 'OrdDeriv', ordDeriv, ...
    'Accuracy', acc);   % a(t) estimation. 
TT = (linspace(-1, 9, 1000))';
aActual = -sin(TT);   % Actual a(t). 
close all; figure(1); hold on;
plot(TT, aActual, 'k', 'LineWidth', 1.5);
plot(xDerivative, yDerivative, 'bo', 'MarkerSize', 10);
xlabel('t [s]'); ylabel('a [m / s^2]'); set(gca, 'FontSize', 14); grid on;
legend('Actual', 'Estimated');
clearvars; clc;


%                                           Page 5
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% The construction of the piecewise interpolation polynomial 
% function is defined by the degree of the polynomials as well as 
% the data points for each polynomial and endpoints of the 
% intervals over which the polynomials are defined. The latter 
% two aspects differ among each of three predefined principles, 
% also called “modes”. They are represented by the optional 
% parameter “Mode”, the default value of which is “Mode == 1” 
% but can also be set to either “0” or “2”. To understand the 
% three modes in detail, documentation and the code of the 
% functions and their subfunctions should be referred to. 
% In general, the “Mode” parameter only changes the result if 
% the abscissa data points are at least moderately unequally 
% spaced. 
% By running the following block of code, the difference 
% between the three modes can be appreciated in the attempt to 
% differentiate a function for which the data points are highly 
% unequally spaced along the abscissa. 

xData = [0; 1; 3; 5; 8; 35; 37; 40; 45];    % Highly unequally 
                                                                  % spaced abscissa data 
                                                                  % points. 
yData = [10; 9; 8; 11; 13; 5; 4; 3; 2];
xDerivative = (linspace(-5, 35))';
yDerivativeActual = ZFindDerivative(xData, yData, xDerivative, ...
     'Type', 'Spline');   % Actual yDerivative. 
acc = 3;   % Accuracy. 
yDerivative0 = ZFindDerivative(xData, yData, xDerivative, ...
     'Accuracy', acc, 'Mode', 0);   % yDerivative estimate if 
                                                     % Mode paramater is 0. 
yDerivative1 = ZFindDerivative(xData, yData, xDerivative, ...
     'Accuracy', acc, 'Mode', 1);   % yDerivative estimate if 
                                                     % Mode paramater is 1. 
yDerivative2 = ZFindDerivative(xData, yData, xDerivative, ...
     'Accuracy', acc, 'Mode', 2);   % yDerivative estimate if 
                                                     % Mode paramater is 2. 
close all; figure(1); hold on;
plot(xDerivative, yDerivativeActual, 'k', 'LineWidth', 2);
plot(xDerivative, yDerivative0, 'b', 'LineWidth', 1.5);
plot(xDerivative, yDerivative1, 'r:', 'LineWidth', 1.5);
plot(xDerivative, yDerivative2, 'g--', 'LineWidth', 1.5);
legend('Actual', 'Estimated if "Mode == 0"', ...
    'Estimated if "Mode == 1"', 'Estimated if "Mode == 2"');
xlabel('x'); ylabel('y_D_e_r_i_v_a_t_i_v_e'); set(gca, 'FontSize', 14); grid on;
clearvars; clc;


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
figr1 = 1;   % Figure paramater value. 
yDerivativeDefault = ZFindDerivative(xData, yData, xDerivative, ...
    'Figure', figr1);   % v(t) estimation using default settings. 
title('Default settings of ZFindDerivative function');
figr2 = 2;   % Figure paramater value. 
yDerivativeSpline = ZFindDerivative(xData, yData, xDerivative, ...
    'Type', 'Spline', ...
    'Figure', figr2);   % v(t) estimation using spline interpolation. 
title('Spline interpolation');
polyDegree = 4;   % Degree of the regression polynomial. 
figr3 = 3;   % Figure paramater value. 
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