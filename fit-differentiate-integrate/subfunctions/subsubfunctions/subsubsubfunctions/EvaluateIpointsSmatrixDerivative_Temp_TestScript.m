xData = [0;2;4;6];
yData = [0;2;-2;2];
ordDeriv = 1;
Ipoints = [-Inf; 2; 4; Inf];
Smatrix = [1, 2; 2, 3; 3, 4];
xDerivativeA = 2;
yDerivativeA = EvaluateIpointsSmatrixDerivative...
    (xData, yData, xDerivativeA, ordDeriv, Ipoints, Smatrix);
plot(xData, yData, 'bo'); grid on;
