% Supposedly one has the following data of an object moving 
% along the X coordinate as a function of time T: X(T = 0) = 1 m, 
% X(T = 1 s) = 4 m, X(T = 3 s) = 12, X(T = 4 s) = 13, 
% X(T = 7 s) = 21 m, X(T = 8 s) = 26 m, X(T = 10 s) = 33 m, 
% which can be represented by the two data vectors: 'TData' and 
% 'XData'. Run the following two lines of code to introduce them 
% to the MATLAB workspace. 

TData = [0; 1; 3; 4; 7; 8; 10];
XData = [1; 15; 20; 10; 18; 30; 32];

% Supposedly one knows for a fact that there is no external 
% force acting on the object, meaning that its velocity in constant 
% and its movement linear. Plot the data points by running the 
% following block of code. 

close all;
figure(1);
plot(TData, XData, 'ro', 'MarkerSize', 10);
xlabel('T [s]'); ylabel('X [m]'); 
set(gca, 'FontSize', 14); grid on;
clear TData XData


%                                           Page 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% The plotted data seem to indicate linear movement in general 
% though not by a point-by-point basis, which can be explained 
% by measurement error. Supposedly one then wants to 
% estimate the values of the position X0 of the object at time 
% T = 0 and its velocity V, which correspond to the intercept and 
% the slope, respectively, of the linear curve represented by the 
% data points. The FindSimpleLinearRegressionCoefficients 
% function can be used to do just that through the least squares 
% method of the simple linear regression. Run the following 
% block of code to estimate the values of both the position X0 
% and the velocity V by using the 
% FindSimpleLinearRegressionCoefficients function and plot 
% the data points with the estimated standard deviation error 
% bars. 

TData = [0; 1; 3; 4; 7; 8; 10];
XData = [1; 15; 20; 10; 18; 30; 32];
[V_Estimated, X0_Estimated] = ...
    FindSimpleLinearRegressionCoefficients(TData, XData)
close all;
figure(1);
plot(TData, XData, 'ro', 'MarkerSize', 10);
xlabel('T [s]'); ylabel('X [m]'); 
set(gca, 'FontSize', 14); grid on;
clear TData XData


%                                           Page 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Supposedly one wishes to estimate the error of the values of 
% the 'XData' vector. Assuming the standard deviation of each 
% measurement was identical and no measurement corelated 
% with another, the FindSimpleLinearRegressionCoefficients 
% function can be used for this purpose. Run the following block 
% of code to, in addition to estimating both the position X0 and 
% the velocity V, estimate the variance of the values of the 
% 'XData' vector and plot the data points with the estimated 
% standard deviation error bars. 

TData = [0; 1; 3; 4; 7; 8; 10];
XData = [1; 15; 20; 10; 18; 30; 32];
[V_Estimated, X0_Estimated, Var_XData_Estimated] = ...
    FindSimpleLinearRegressionCoefficients(TData, XData)
close all;
figure(1);
errorbar(TData, XData, ...
    sqrt(Var_XData_Estimated) * ones(length(XData), 1), ...
    'ro', 'MarkerSize', 10);
xlabel('T [s]'); ylabel('X [m]'); 
set(gca, 'FontSize', 14); grid on;
clear  TData XData Var_XData_Estimated


%                                           Page 3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Supposedly some information about the measurement error 
% of the position in the X coordinate is already know such that it 
% can be represented by the 'CovarMat_XData' covariance 
% matrix, where the variance of an arbitrary value 'XData'(i) is 
% 'CovarMat_XData'(i, i) and the covariance of two different 
% arbitrary values 'XData'(i) and 'XData'(j) is 
% 'CovarMat_XData'(i, j). Run the following  block of code to 
% introduce it to the MATLAB workspace. 

Var1 = 3; Var2 = 5; Var3 = 10; Var4 = 7; Var5 = 3; Var6 = 2; Var7 = 6;
r1 = 0.9; r2 = 0.8; r3 = 0.7; r4 = 0.6; r5 = 0.4; r6 = 0.2;
Var = [Var1; Var2; Var3; Var4; Var5; Var6; Var7];
r = [1; r1; r2; r3; r4; r5; r6; r7];
CovarMat_XData = zeros(7);
for i = 1 : 7
    for j = 1 : 7
        CovarMat_XData(i, j) = Var(i) * Var(j) * r(abs(i - j) + 1);
    end
end
CovarMat_XData = [9, 13.5, 24, 14.7, 5.4, 2.4, 3.6;
   13.5, 25, 45, 28, 10.5, 6, 12;
   24, 45, 100, 63, 24, 14, 36;
   14.7, 28, 63, 49, 18.9, 11.2, 29.4;
    5.4, 10.5, 24, 18.9, 9, 5.4, 14.4;
    2.4, 6, 14, 11.2, 5.4, 4, 10.8;
    3.6, 12, 36, 29.4, 14.4, 10.8, 36]

% The FindSimpleLinearRegressionCoefficients function can 
% take into account the covariation matrix of the dependent 
% variable, in this case the position in the X coordinate. Run the 
% following block of code to estimate the values of both the 
% position X0 and the velocity V with the 'CovarMat_XData' 
% covariation matrix taken into account. 

TData = [0; 1; 3; 4; 7; 8; 10];
XData = [1; 15; 20; 10; 18; 30; 32];
CovarMat_XData = [9, 13.5, 24, 14.7, 5.4, 2.4, 3.6;
   13.5, 25, 45, 28, 10.5, 6, 12;
   24, 45, 100, 63, 24, 14, 36;
   14.7, 28, 63, 49, 18.9, 11.2, 29.4;
    5.4, 10.5, 24, 18.9, 9, 5.4, 14.4;
    2.4, 6, 14, 11.2, 5.4, 4, 10.8;
    3.6, 12, 36, 29.4, 14.4, 10.8, 36];
[V_Estimated, X0_Estimated] = ...
    FindSimpleLinearRegressionCoefficients...
    (TData, XData, 'CovarMat_yData', CovarMat_XData)
clear  TData XData


%                                           Page 4
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

