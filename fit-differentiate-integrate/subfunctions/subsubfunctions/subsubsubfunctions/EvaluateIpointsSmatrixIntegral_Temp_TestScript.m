Ipoints = [-Inf; 0; 2; Inf];
Smatrix = [1, 2, 3, 4;
    5, 6, 7, 8;
    9, 10, 11, 12];
xData = [-10; -8; -7; -3;...
    0.1; 0.2; 1; 1.5; ...
    4; 5; 7; 11];
yData = [-3; -2; 1; 4; ...
    2; -1; 2; 3; 
    1; -2; -3; -8];
plot(xData, yData, 'ro');grid on;

% xIntegralA = [-11; 0.01; 3];
% yIntegralA = EvaluateIpointsSmatrixIntegral...
%     (xData, yData, xIntegralA, Ipoints, Smatrix)
% yIntegralA =[0; -19.570833333333510; -10.976600721230376];
% xIntegralA = [-11; 0.02; 3];
% yIntegralA = EvaluateIpointsSmatrixIntegral...
%     (xData, yData, xIntegralA, Ipoints, Smatrix)
% yIntegralA = [0; -19.570833333333510; -11.032301429792646];

xIntegralA = [-11; 0.01; 3];
yIntegralA = EvaluateIpointsSmatrixIntegral...
    (xData, yData, xIntegralA, Ipoints, Smatrix)