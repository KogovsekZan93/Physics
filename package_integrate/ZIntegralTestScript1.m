% errorMsg = 'figr must be a natural number'; 
% validationFcn = @(x)assert(isnumeric(x) && isscalar(x) && x > 0 && mod(x,1)==0, errorMsg)
% validationFcn(-1)

% p = inputParser;
% paramName = 'Psacc';
% defaultVal = 3;
% validationFcn = @(x)assert(isnumeric(x) && isscalar(x) && ...
%     x >= 0 && mod(x,1) == 0 && x < length(xData), errorMsg);
% addParameter(p,paramName,defaultVal,validationFcn)
% 
% 
% parse(p,'Psacc',1)
% p.Results.Psacc

xData = [-3; -2; 3; 4; 5; 8];
yData = sin(xData);
xmin = -2;   % Lower integration limit. 
xmax = 4;	% Upper integration limit. 
Psacc = 4;	% Pseudo-order of accuracy. 
mode = 1;	% Mode of integration. 
figr = 2;	% Figure number for the plot. 
ZIntegA = ZIntegralA(xData, yData, xmin, xmax, 'Figure', figr,'Mode', mode,'PseudoAccuracy', Psacc);
xlabel('x'); ylabel('y'); set(gca, 'FontSize', 14);
xx = linspace(min(xData), max(xData), 1000); yy = sin(xx);
hold on; plot(xx, yy, 'k', 'LineWidth', 1.5);   % Actual function plot. 
