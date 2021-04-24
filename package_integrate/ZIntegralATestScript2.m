xData = [-3; -2; 3; 4; 5; 8; 9; 10; 14; 16; 23; 27; 31];
yData = sin(xData);
xmin = 0;   % Lower integration limit. 
xmax = 30;	% Upper integration limit. 
psacc = 2;	% Pseudo-order of accuracy. 
mode = 2;	% Mode of integration. 
figr = 2;	% Figure number for the plot.
Limits = [xmin; xmax];
% Varargin = {'PseudoAccuracy', psacc, 'Figure', figr, 'Mode', mode};
Varargin = {'Figure', figr, 'Mode', mode};

ZIntegALim = ZDefiniteIntegralA(xData, yData, Limits, Varargin{:});