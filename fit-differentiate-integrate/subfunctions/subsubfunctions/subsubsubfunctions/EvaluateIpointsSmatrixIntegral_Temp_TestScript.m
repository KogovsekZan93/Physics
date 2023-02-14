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


xData = [0;1;2;3;4;5;6;7;8;9];
xData = power(xData,4);
yData = xData;
plot(xData,yData,'ro');grid on;
xIntegralA = (linspace(-2,6561.5,10))';
xIntegralA = [xIntegralA(1); 83; xIntegralA(2:end)];
% xIntegralSpline = xData;
% xIntegralSpline = [-1;2;400; 410];
[yIntegralA, Ipoints, Smatrix] = ZFindIntegralABasic...
    (xData, yData, xIntegralA, 'PseudoAccuracy', 3);
% yIntegralA
((power(xIntegralA,2)-power(xIntegralA(1),2))/2) - yIntegralA