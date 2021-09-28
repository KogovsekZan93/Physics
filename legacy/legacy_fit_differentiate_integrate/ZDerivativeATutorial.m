% Supposedly one measures a variable which is a function of 
% time t, such as the X coordinate of an object. 
% Let us plot the measurements. Run the following block of 
% code. 
 
t = [0; 1; 3; 5; 8; 35; 37; 40; 45];
X = [10; 9; 8; 11; 13; 5; 4; 3; 2];
figure(1); clf; plot(t, X, 'bo', 'MarkerSize', 10); xlabel('t [s]'); 
ylabel('X [m]'); set(gca, 'FontSize', 14); grid on; clear all; clc;
% Clearing variables and workspace is done at or near the end 
% of after each block of code for the purposes of clarity of this 
% tutorial. 
 
 
%                                           Page 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
 
% Supposedly one wishes to find the velocity V(t) curve in the X 
% direction in the time interval [0 s, 50 s]. In order to do that, one 
% has to differentiate the X(t) function. Only the values in nine 
% specific time points have been measured and the X(t) function 
% as a whole is unknown. In such cases, numerical 
% differentiation has to be performed to give an accurate 
% estimation of the actual V(t) curve. ZDerivativeA is a tool which 
% can be used to do just that. The simplest way of differentiating 
% a function numerically can be performed and the actual 
% function which is differentiated can be visualized using the 
% ZDerivativeA function by setting the order of accuracy to "1" 
% and the mode to "1". 
% Run the following block of code in order to do that. 
 
t = [0; 1; 3; 5; 8; 35; 37; 40; 45];
X = [10; 9; 8; 11; 13; 5; 4; 3; 2];
xData = t;
yData = X;
ordDeriv = 1;   % Derivative order. 
Acc = 1;    % Order of accuracy. 
xDeriv = (linspace(0, 50, 1000))';   % Time points in which the 
                                                          % derivative is to be 
                                                          % calculated. 
figr = 1;   % Figure number for the plot of the measurements and 
                % the actual function which is differentiated. 
mode = 1;   % Mode of differentition. See later. 
V = ZDerivativeA(xData, yData, ordDeriv, Acc, xDeriv, figr, mode);
xlabel('t [s]'); ylabel('X [m]'); set(gca, 'FontSize', 14);
figure(2); clf; 
plot(xDeriv, V, 'r', 'LineWidth', 1.2);
xlabel('t [s]'); ylabel('V [m / s]'); set(gca, 'FontSize', 14); grid on;
clear all; clc;
 
 
%                                           Page 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
 
% The principle of numerical differentiation is to estimate the 
% function based on the numerical data and then differentiate it. 
% In the previous case, the X(t) function is estimated to be 
% linearly connected pairs of neighboring measured points, 
% a piecewise linear function which is simply extrapolated for 
% t < 0 s and t > 45 s. 
% ZDerivativeA function offers more complex estimations such 
% as a piecewise Lagrange polynomial of the 
% "Acc - ordDeriv + 1 "-th order of the data if the "mode" 
% parameter is set to be either 0, 1, or 2. 
% Depending on the "mode" parameter, the construction of the 
% piecewise Lagrange polynomial changes. For simple use of 
% the ZDerivativeA function, the ZDerivativeASimple function 
% has the parameters "Acc" and "mode" fixed as Acc == 3 and 
% mode == 2 as it is good practice in most cases. Run the 
% following block of code to see these parameters used on the 
% examined set of data for yourself. 
 
t = [0; 1; 3; 5; 8; 35; 37; 40; 45];
X = [10; 9; 8; 11; 13; 5; 4; 3; 2];
xData = t;
yData = X;
ordDeriv = 1;   % Derivative order. 
Acc = 3;    % Order of accuracy. 
xDeriv = (linspace(0, 50, 1000))';   % Time points in which the 
                                                          % derivative is to be 
                                                          % calculated. 
figr = 1;   % Figure number for the plot of the measurements and 
                % the actual function which is differentiated. 
mode = 2;   % Mode of differentiation. See later. 
V = ZDerivativeA(xData, yData, ordDeriv, Acc, xDeriv, figr, mode);
xlabel('t [s]'); ylabel('X [m]'); set(gca, 'FontSize', 14);
figure(2); clf; 
plot(xDeriv, V, 'r', 'LineWidth', 1.2);
xlabel('t [s]'); ylabel('V [m / s]'); set(gca, 'FontSize', 14); grid on;
clear all; clc;
 
 
%                                           Page 3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
 
% The estimated V(t) curve in the previous case is 
% discontinuous, which may appear unsatisfactory. It may be 
% tempting to set the accuracy parameter "Acc" to the maximal 
% value of Acc == 9 - 1 ("9" is the size of the coordinate X/time 
% data vector and "1" is the order of the derivative) as at this 
% setting, the estimated X(t) function is a single Lagrange 
% polynomial of the measured data. Unfortunately, higher order 
% Lagrange polynomials can oscillate wildly between the data 
% points, which is why this is not recommended. 
% Run the following block of code to see for yourself. You can 
% also experiment by changing the "mode" and "Acc" 
% parameters or even numerically evaluate a higher order 
% derivative by raising the "ordDeriv" parameter. For complete 
% understanding, see the ZDerivativeA documentation and code. 
 
t = [0; 1; 3; 5; 8; 35; 37; 40; 45];
X = [10; 9; 8; 11; 13; 5; 4; 3; 2];
xData = t;
yData = X;
ordDeriv = 1;   % Derivative order. 
Acc = 8;    % Order of accuracy. 
xDeriv = (linspace(0, 45, 1000))';   % Time points in which the 
                                                          % derivative is to be 
                                                          % calculated. 
figr = 1;   % Figure number of the plot of the measurements and 
                % the actual function which is differentiated. 
mode = 2;   % Mode of differentiation. See later. 
V = ZDerivativeA(xData, yData, ordDeriv, Acc, xDeriv, figr, mode);
xlabel('t [s]'); ylabel('X [m]'); set(gca, 'FontSize', 14);
figure(2); clf; 
plot(xDeriv, V, 'r', 'LineWidth', 1.2);
xlabel('t [s]'); ylabel('V [m / s]'); set(gca, 'FontSize', 14); grid on;
clear all; clc;
 
 
%                                           Page 4
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%