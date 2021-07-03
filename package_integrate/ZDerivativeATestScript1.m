xData = [-3; -2; 3; 4; 5; 8; 9; 10; 14; 16; 23; 27; 31];
yData = sin(xData);
ordDeriv = 1;
acc = 2;	% Pseudo-order of accuracy. 
mode = 2;	% Mode of integration. 
figr = 2;	% Figure number for the plot.
% xDerivativeA = 2;
xDerivativeA = (linspace(0, 31, 1000))';

tic;yDeriv = ZDerivativeA_Old(xData, yData, ordDeriv, acc, xDerivativeA, figr, mode);toc;
figr = 1;
tic;yDerivativeA = ZDerivativeA(xData, yData, ...
    xDerivativeA, 'OrdDeriv', ordDeriv, 'Accuracy', acc, 'Figure', figr, 'Mode', mode);toc;

sum(abs(yDeriv - yDerivativeA))
