xData=[0;1;2;3];
R = [1, 0.2, 0.1, 0.4; 0.2, 2, 0.3, 0.5; 0.1, 0.3, 3, 1; 0.4, 0.5, 1, 5];
delx=ones(length(xData),1)*0.2;
ux=1;
yData=[0;3;5;9];
dely=ones(length(yData),1)*0.4;
FunTestFunction=@(vec)TestFunction(vec);

[slope, intercept, CovarMatrix] = ...
    FindSimpleLinearRegressionCoefficients...
    (xData, yData,  'CovarMat_yData', R)

figr=3;
figure(figr);
clf;

DrawSimpleLinearRegressionGraph(figr,xData,yData,slope, intercept,delx,diag(R), CovarMatrix)



