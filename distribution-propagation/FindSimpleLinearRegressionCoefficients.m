function [slope, intercept] = ...
    FindSimpleLinearRegressionCoefficients(xData, yData)
%Ta funkcija sprejme vektor linDATA=[x1;x2;...;xl;y1;y2;...;yl] in 
%vrne vektor par=[k;n] enacbe y=kx+n. 

length_xData=length(xData);

A=[xData, ones(length_xData, 1)];
parameters=A \ yData;
slope = parameters(1);
intercept = parameters(2);

end