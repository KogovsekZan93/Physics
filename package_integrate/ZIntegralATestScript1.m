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

xData = [-3; -2; 3; 4; 5; 8; 9; 10; 14; 16; 23; 27; 31];
yData = sin(xData);
xmin = -3;   % Lower integration limit. 
xmax = 30;	% Upper integration limit. 
psacc = 2;	% Pseudo-order of accuracy. 
mode = 2;	% Mode of integration. 
figr = 2;	% Figure number for the plot.
xIntegralA = [xmin; xmax];
tic;ZIntegA = ZIntegralA(xData, yData, xmin, xmax, 'Figure', figr,'Mode', mode,'PseudoAccuracy', psacc);toc;
tic;
xIntegral = sort(xIntegralA);
figr = 1;
Varargin = {'PseudoAccuracy', psacc, 'Figure', figr, 'Mode', mode};
% Varargin = {'PseudoAccuracy', psacc, 'Mode', mode}
yIntegralA = ZIntegralA_Revised(xData, yData, xIntegralA,...
    Varargin{:});
toc;
% ZIntegA_Revised = ZIntegralA_Revised(xData, yData, 'Figure', figr + 1,'Mode', mode,'PseudoAccuracy', Psacc);

% xlabel('x'); ylabel('y'); set(gca, 'FontSize', 14);
% xx = linspace(min(xData), max(xData), 1000); yy = sin(xx);
% hold on; plot(xx, yy, 'k', 'LineWidth', 1.5);   % Actual function plot. 
% ZIntegA - ZIntegA_Revised

% K = [4;3;2;1];
% [M, I] = sort(K);
% B = [5;6;7;8];
% L(I) = B;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Razmisli, èe je to smiselno! Kakšen je vrstni red vrednosti integrala?