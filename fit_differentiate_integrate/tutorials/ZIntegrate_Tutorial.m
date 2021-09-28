% Supposedly one measures a variable which is a function of 
% time t, such as velocity v in the x coordinate. A value of v is 
% measured each second. 
% Let us plot the measurements. Run the following block of 
% code. 

t = [0; 1; 2; 3; 4; 5; 6; 7; 8];
v = [1.000000000000000; 1.909297426825682; 
    0.243197504692072; 0.720584501801074; 
    1.989358246623382; 0.455978889110630; 
    0.463427081999565; 1.990607355694870; 
    0.712096683334935];
close all; figure(1); plot(t, v, 'bo', 'MarkerSize', 10);
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
% time interval, the velocity function as a whole is unknown, only 
% the values in nine specific time points have been measured. In 
% such cases, numerical integration can be performed to give an 
% estimation of the actual value of the x coordinate at t == 0. 
% ZDefiniteIntegralA is a tool which can be used to do just that. 
% Run the following block of code to numerically integrate the 
% velocity function from t == 0 to t == 8. 

t = [0; 1; 2; 3; 4; 5; 6; 7; 8];
V = [1.000000000000000; 1.909297426825682; 
    0.243197504692072; 0.720584501801074; 
    1.989358246623382; 0.455978889110630; 
    0.463427081999565; 1.990607355694870; 
    0.712096683334935];
xData = t;
yData = V; 
xMin = 0;   % Lower limit of integration. 
xMax = 8;   % Upper limit of integration. 
Limits = [xMin; xMax];   % Limits of integration.
DefiniteIntegralA = ZDefiniteIntegralA(xData, yData, Limits);
clearvars -except DefiniteIntegralA; clc;
DefiniteIntegralA   %Display the calculated value in the command 
                               % window. 

% To calculate the value of the x coordiante at t == 8 s, add 3 
% (== x(t==0) in meters) to the DefiniteIntegralA value. You can 
% do so by running the following block of code. 

clc;
x_at_t_equals_8_s = DefiniteIntegralA + 3;
x_at_t_equals_8_s
                               

%                                           Page 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% PAGE 3 NOT YET COMPLETED!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

% The principle of numerical integration is to estimate the 
% function based on the numerical data and then integrate it. In 
% the previous case, the V(t) function is estimated to be constant 
% between each two neighboring midway points between 
% neighboring data points. 
% ZIntegralA function offers more complex estimations such as 
% a piecewise Lagrange polynomial of the Psacc-th order of the 
% data if the "mode" parameter is set to be either 0, 1, or 2. 
% Depending on the "mode" parameter, the construction of the 
% piecewise Lagrange polynomial changes. For simple use of 
% the ZIntegralA function, the ZIntegralASimple function has the 
% parameters "Psacc" and "mode" are fixed as Psacc == 3 and 
% mode == 1 as it is good practice in most cases. Run the 
% following block of code to see these parameters used on the 
% examined set of data for yourself. 

t = [0; 1; 2; 3; 4; 5; 6; 7; 8];
V = [1.000000000000000; 1.909297426825682; 
    0.243197504692072; 0.720584501801074; 
    1.989358246623382; 0.455978889110630; 
    0.463427081999565; 1.990607355694870; 
    0.712096683334935];
x = t;
y = V; 
xmin = 0;   % Lower integration limit. 
xmax = 8;   % Upper integration limit. 
Psacc = 3; % Pseudo-order of accuracy. 
mode = 1;   % Mode of integration. See later. 
figr = 1;   % Figure number for the plot. 
X = ZIntegralA(x, y, xmin, xmax, Psacc, mode, figr);
xlabel('t [s]'); ylabel('V [m / s]'); set(gca, 'FontSize', 14);
clearvars -except X; clc;
X   %Display the calculated value in the command window. 
clearvars X;


%                                           Page 3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% At this point, it may become apparent that the actual velocity 
% function might be a kind of sinusoidal function. Indeed, the 
% velocity in m / s is V(t) = sin(2 * t) + 1 if time t is expressed in 
% seconds. It is important to note that increasing the Psacc may 
% not result in a more accurate estimation of the function being 
% integrated even if the function is analytical. For example, if 
% Psacc is increased to the maximum possible value of 
% Psacc == 9 - 1 ("9" is the size of the velocity/time data vector), 
% the estimation of the actual velocity function resembles the 
% actual function less. The integration result is also less close to 
% the actual value, which is about 8.98. 
% Run the following block of code to see for yourself. 

t = [0; 1; 2; 3; 4; 5; 6; 7; 8];
V = [1.000000000000000; 1.909297426825682; 
    0.243197504692072; 0.720584501801074; 
    1.989358246623382; 0.455978889110630; 
    0.463427081999565; 1.990607355694870; 
    0.712096683334935];
x = t;
y = V; 
xmin = 0;	% Lower integration limit. 
xmax = 8;	% Upper integration limit. 
Psacc = 9 - 1; % Pseudo-order of accuracy. 
mode = 1;	% Mode of integration. See later. 
figr = 1;	% Figure number for the plot. 
X = ZIntegralA(x, y, xmin, xmax, Psacc, mode, figr);
xlabel('t [s]'); ylabel('V [m / s]'); set(gca, 'FontSize', 14);
tt = linspace(min(t), max(t), 1000); VV = sin(2*tt) + 1;
hold on; plot(tt, VV, 'k', 'LineWidth', 1.5);   % Actual velocity plot. 
clearvars -except X; clc;
X   %Display the calculated value in the command window. 
clearvars X;


%                                           Page 4
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% The "mode" parameter is of little importance in most cases. It 
% only becomes truly relevant when the neighboring data points 
% are far apart in terms of the x axis. For complete 
% understanding, see the ZIntegralA documentation and code. 
% To explore the impact of the "mode" parameter, run one the 
% following two blocks of code and vary the "mode" parameter. 

x = [0; 1; 3; 5; 8; 35; 37; 40; 45];
y = [10; 9; 8; 11; 13; 5; 4; 3; 2];
xmin = 0;   % Lower integration limit. 
xmax = 45;   % Upper integration limit. 
Psacc = 3;	% Pseudo-order of accuracy. 
mode = 1;   % Mode of integration. 
figr = 1;   % Figure number for the plot. 
ZIntegA = ZIntegralA(x, y, xmin, xmax, Psacc, mode, figr);
xlabel('x'); ylabel('y'); set(gca, 'FontSize', 14);
clearvars -except  ZIntegA; clc;
ZIntegA   %Display the calculated value in the command window. 
clearvars  ZIntegA;


x = [-3; -2; 3; 4; 5; 8];
y = sin(x);
xmin = -2;   % Lower integration limit. 
xmax = 4;	% Upper integration limit. 
Psacc = 2;	% Pseudo-order of accuracy. 
mode = 0;	% Mode of integration. 
figr=1;	% Figure number for the plot. 
ZIntegA = ZIntegralA(x, y, xmin, xmax, Psacc, mode, figr);
xlabel('x'); ylabel('y'); set(gca, 'FontSize', 14);
xx = linspace(min(x), max(x), 1000); yy = sin(xx);
hold on; plot(xx, yy, 'k', 'LineWidth', 1.5);   % Actual function plot. 
clearvars -except ZIntegA; clc; 
ZIntegA   %Display the calculated value in the command window. 
clearvars ZIntegA;


%                                           Page 5
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%