clc;
xData = [0;2;4;10;11;12;15;15.2;18;19;20;22;27];
yData = [-3;-1;-5;8;10;15;11;13;2;-4;-2;8;10];

xFitA = 13;

Parameters1 = {'PseudoAccuracy', 3, 'Mode', 0, 'Figure', 11};

Parameters2 = {'PseudoAccuracy', 2, 'Mode', 1};

Parameters3 = {'PseudoAccuracy', 2};

Parameters4 = {};

Parameters5 = {'Figure', 12};

Parameters6 = {'PseudoAccuracy', 3, 'Figure', 12};

[yFitA, Ipoints, Smatrix] = ZFitA(xData, yData, xFitA, Parameters6{:})