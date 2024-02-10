% Supposedly one has the following data of an object moving 
% along the X coordinate as a function of time T: X(T = 0) = 1 m, 
% X(T = 1 s) = 4 m, X(T = 3 s) = 12, X(T = 4 s) = 13, 
% X(T = 7 s) = 21 m, X(T = 8 s) = 26 m, X(T = 10 s) = 33 m, 
% which can be represented by the two data vectors: 'TData' and 
% 'XData'. Run the following two lines of code to introduce them 
% to the MATLAB workspace. 

TData = [0; 1; 3; 4; 7; 8; 10]
XData = [1; 15; 20; 10; 18; 30; 32]

% Supposedly one knows for a fact that there is no external 
% force acting on the object, meaning that its velocity is constant 
% and its movement linear. Plot the data points by running the 
% following block of code. 

close all;
figure(1);
plot(TData, XData, 'ro', 'MarkerSize', 10);
xlabel('T [s]'); ylabel('X [m]'); 
set(gca, 'FontSize', 14); grid on;
clear TData XData   % Clearing variables and workspace is done 
                                  % at or near the end of after each block of 
                                  % code for the purposes of clarity of this 
                                  % tutorial. 


%                                           Page 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% The plotted data seem to indicate linear movement in general 
% though not on a point-by-point basis, which can be explained 
% by measurement error. Supposedly one then wants to 
% estimate the values of the position X0 of the object at time 
% T = 0 and its velocity V, which correspond to the intercept and 
% the slope, respectively, of the linear curve represented by the 
% data points. The FindSimpleLinearRegressionCoefficients 
% function can be used to do just that through the least squares 
% method of the simple linear regression. Run the following 
% block of code to estimate the values of both the position X0 
% and the velocity V by using the 
% FindSimpleLinearRegressionCoefficients function.

TData = [0; 1; 3; 4; 7; 8; 10];
XData = [1; 15; 20; 10; 18; 30; 32];
[V_Estimated, X0_Estimated] = ...
    FindSimpleLinearRegressionCoefficients(TData, XData)
clear TData XData


%                                           Page 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Supposedly one wishes to estimate the error of the values of 
% the 'XData' vector. Assuming the standard deviation of each 
% measurement was identical and no measurement corelated 
% with another, the FindSimpleLinearRegressionCoefficients 
% function can be used for this purpose. In addition, the 
% covariance matrix of the slope and the intercept of the simple 
% linear regression curve, which are in the present case the 
% velocity V and the position X0, respectively, can be obtained. 
% Run the following block of code to, in addition to estimating 
% both the position X0 and the velocity V, estimate the variance 
% of the values of the 'XData' vector and the covariance matrix 
% of the velocity V and the position X0, and plot the data points 
% with the estimated standard deviation error bars. 

TData = [0; 1; 3; 4; 7; 8; 10];
XData = [1; 15; 20; 10; 18; 30; 32];
[V_Estimated, X0_Estimated, ...
    Var_XData_Estimated, CovarMat_VX0] = ...
    FindSimpleLinearRegressionCoefficients(TData, XData)
close all;
figure(1);
errorbar(TData, XData, ...
    sqrt(Var_XData_Estimated) * ones(length(XData), 1), ...
    'ro', 'MarkerSize', 10);
xlabel('T [s]'); ylabel('X [m]'); 
set(gca, 'FontSize', 14); grid on;
clear TData XData Var_XData_Estimated CovarMat_VX0


%                                           Page 3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Supposedly some information about the measurement error 
% of the position in the X coordinate is already known such that it 
% can be represented by the 'CovarMat_XData' covariance 
% matrix, where the variance of an arbitrary value 'XData'(i) is 
% 'CovarMat_XData'(i, i) and the covariance of two distinct 
% arbitrary values 'XData'(i) and 'XData'(j) is 
% 'CovarMat_XData'(i, j). Run the following  block of code to 
% introduce it to the MATLAB workspace. 

CovarMat_XData = [9, 13.5, 24, 14.7, 5.4, 2.4, 3.6;
   13.5, 25, 45, 28, 10.5, 6, 12;
   24, 45, 100, 63, 24, 14, 36;
   14.7, 28, 63, 49, 18.9, 11.2, 29.4;
    5.4, 10.5, 24, 18.9, 9, 5.4, 14.4;
    2.4, 6, 14, 11.2, 5.4, 4, 10.8;
    3.6, 12, 36, 29.4, 14.4, 10.8, 36]

% The FindSimpleLinearRegressionCoefficients function can 
% take into account the covariance matrix of the dependent 
% variable, which is in this case the position in the X coordinate. 
% Run the following block of code to estimate the values of both 
% the position X0 and the velocity V with the 'CovarMat_XData' 
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
clear TData XData CovarMat_XData V_Estimated X0_Estimated


%                                           Page 4
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% If the covariance matrix of the depended variable is provided 
% as the optional input variable, the only optional output variable 
% is the covariance matrix of the slope and the intercept of the 
% simple linear regression curve, which are in this case the 
% velocity V and the position X0, respectively. Run the following 
% block of code to obtain this covariance matrix of the velocity V 
% and the position X0. 

TData = [0; 1; 3; 4; 7; 8; 10];
XData = [1; 15; 20; 10; 18; 30; 32];
CovarMat_XData = [9, 13.5, 24, 14.7, 5.4, 2.4, 3.6;
   13.5, 25, 45, 28, 10.5, 6, 12;
   24, 45, 100, 63, 24, 14, 36;
   14.7, 28, 63, 49, 18.9, 11.2, 29.4;
    5.4, 10.5, 24, 18.9, 9, 5.4, 14.4;
    2.4, 6, 14, 11.2, 5.4, 4, 10.8;
    3.6, 12, 36, 29.4, 14.4, 10.8, 36];
[V_Estimated, X0_Estimated, CovarMat_VX0] = ...
    FindSimpleLinearRegressionCoefficients...
    (TData, XData, 'CovarMat_yData', CovarMat_XData)
clear TData XData CovarMat_VX0 CovarMat_XData ...
    V_Estimated X0_Estimated


%                                           Page 5
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% The simple-linear-regression function package also provides 
% a plotting function which takes into the account the data points 
% as well as the values of the standard deviation of the values of 
% the dependent variable and the calculated values of the 
% intercept and the slope of the simple linear regression curve 
% as well as their correlation matrix to plot not only the data 
% points with the standard deviation bars of the dependent 
% variable, as it was done in this tutorial before, but also the 
% average linear regression curve and a blue shaded area of the 
% standard deviation of the linear regression curve. 
% Run the following block of code to do just that for the case 
% which was presented on the previous page. 

TData = [0; 1; 3; 4; 7; 8; 10];
XData = [1; 15; 20; 10; 18; 30; 32];
CovarMat_XData = [9, 13.5, 24, 14.7, 5.4, 2.4, 3.6;
   13.5, 25, 45, 28, 10.5, 6, 12;
   24, 45, 100, 63, 24, 14, 36;
   14.7, 28, 63, 49, 18.9, 11.2, 29.4;
    5.4, 10.5, 24, 18.9, 9, 5.4, 14.4;
    2.4, 6, 14, 11.2, 5.4, 4, 10.8;
    3.6, 12, 36, 29.4, 14.4, 10.8, 36];
[V_Estimated, X0_Estimated, CovarMat_VX0] = ...
    FindSimpleLinearRegressionCoefficients(TData, XData, ...
    'CovarMat_yData', CovarMat_XData);   % Up to this point, the 
                                                                      % code is the same as 
                                                                      % it was on the 
                                                                      % previous page. 
Std_XData = sqrt(diag(CovarMat_XData));
Figure = 1;   % The value of the index of the figure window in 
                      % which the figure is to be plotted. 
figure(Figure);clf(Figure);
DrawSimpleLinearRegressionGraph...
    (Figure, TData, XData, V_Estimated, X0_Estimated, ...
    Std_XData, CovarMat_VX0);
xlabel('T [s]'); ylabel('X [m]'); 
clear TData XData CovarMat_VX0 CovarMat_XData ...
    V_Estimated X0_Estimated Std_XData Figure


%                                           Page 6
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Finally, for quick calculations, the simple-linear-regression 
% function package provides a much faster version of the 
% FindSimpleLinearRegressionCoefficients function: the 
% FindSimpleLinearRegressionCoefficientsFAST function 
% which only takes as its input the vectors of the data points and 
% returns the slope and the intercept of the linear regression 
% curve, not taking into the account the values of the standard 
% deviation of the values of the dependent variables. 
% Run the following block of code to compare the runtimes of 
% the FindSimpleLinearRegressionCoefficients function and the 
% FindSimpleLinearRegressionCoefficientsFAST function. 

TData = [0; 1; 3; 4; 7; 8; 10];
XData = [1; 15; 20; 10; 18; 30; 32];
CovarMat_XData = [9, 13.5, 24, 14.7, 5.4, 2.4, 3.6;
   13.5, 25, 45, 28, 10.5, 6, 12;
   24, 45, 100, 63, 24, 14, 36;
   14.7, 28, 63, 49, 18.9, 11.2, 29.4;
    5.4, 10.5, 24, 18.9, 9, 5.4, 14.4;
    2.4, 6, 14, 11.2, 5.4, 4, 10.8;
    3.6, 12, 36, 29.4, 14.4, 10.8, 36];
tic
[V_Estimated, X0_Estimated] = ...
    FindSimpleLinearRegressionCoefficientsFAST...
    (TData, XData);
toc
tic
[V_Estimated, X0_Estimated, CovarMat_VX0] = ...
    FindSimpleLinearRegressionCoefficients...
    (TData, XData, 'CovarMat_yData', CovarMat_XData);
toc
clear TData XData CovarMat_VX0 CovarMat_XData ...
    V_Estimated X0_Estimated


%                                           Page 7
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% This concludes the tutorial for the simple-linear-regression 
% function package. 
% For further questions, the documentation and the code of the 
% functions should be referred to. 


%                                           Page 8
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%