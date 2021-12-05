% xData = (linspace(0,10, 20))';
% yData=sin(xData);
% xFitPolyFit = (linspace(0,10, 5))';
% PolyDegree = 4;
% [yFitPolyFit, varargout] = ZFindFitPolyFit(xData, yData, xFitPolyFit, PolyDegree, 'Figure', 1);

% xData = (linspace(0,10, 20))';
% yData=sin(xData);
% xFitPolyFit = (linspace(0,10, 100))';
% PolyDegree = 8;
% yFitPolyFit = ZFindDerivativePolyFit(xData, yData, xFitPolyFit, PolyDegree, 'OrdDeriv', 4,'Figure', 2);
% figure(2);hold on; plot(xFitPolyFit, yFitPolyFit)

% xData = (linspace(0,10, 50))';
% yData=sin(xData);
% xIntegralPolyFit = (linspace(3,6, 100))';
% PolyDegree = 8;
% yIndefiniteIntegralPolyFit = ZFindIndefiniteIntegralPolyFit(xData, yData, xIntegralPolyFit, PolyDegree, 'Figure', 1);
% hold on; plot(xData,yData, 'k-')
% yIndefiniteIntegralPolyFit(end)
% -cos(6)+cos(3)


% xData = (linspace(0,10, 50))';
% yData=sin(xData);
% Limits = [0; 10];
% PolyDegree = 4;
% DefiniteIntegralPolyFit = ZFindDefiniteIntegralPolyFit(xData, yData, Limits, PolyDegree, 'Figure', 1);
% hold on; plot(xData,yData, 'k-')
% DefiniteIntegralPolyFit
% -cos(Limits(2))+cos(Limits(1))