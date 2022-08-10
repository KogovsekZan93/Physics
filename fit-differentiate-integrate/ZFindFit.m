function [yFit, varargout] = ZFindFit(xData, yData, xFit, varargin)
%% Curve fitting tool
% 
% Author: Žan Kogovšek
% Date: 8.10.2022
% 
%% Description
% 
% Given the input vector “xData” of the independent variable X 
% and the input vector “yData” of the values of the dependent 
% variable Y of an arbitrary function Y = f(X), this function returns 
% the vector of the estimated values of f(“xFit”), where “xFit” is 
% the input vector of values of the X variable. 
% By setting the optional parameters, the user can: 
%       (1) choose from various methods of the estimation, some 
%       of which offer additional optional parameters and outputs 
%       or need additional required parameters, 
%       (2) plot the estimated curve of the f function along with the 
%       data points represented by the pairs (“xData”(i), “yData”(i)). 
% 
%% Variables
% 
% This function has the form of 
% 
% yIntegralA = ZIntegralA_Revised(xData, yData, 'XIntegralA', ...
%     xIntegralA, 'PseudoAccuracy', psacc, 'Figure', figr, 'Mode', mode)
% 
% xData and yData are the vectors of the aforementioned values 
% xData(i) and yData(i), respectively, of the independent variable 
% X and of the dependent variable Y, respectively, of an arbitrary 
% function Y = f(X) (yData(i) = f(xData(i)). xData and yData both 
% have to be column vectors of real numbers of equal length. 
% xData vector does not have to be sorted (i.e. it is not required 
% that xData(i) > xData(j) for every i > j). 
% 
% xmin is the lower limit of integration and xmax is the upper limit 
% of integration. The limits do not have to be contained in the 
% [min(x), max(x)] interval. 
% 
% Psacc is the pseudo-order of accuracy of the integration, i.e. 
% the integration is accurate if the f function is a polynomial of 
% the degree of Psacc or less. It has to be an integer contained 
% in the interval [0, length(x) – 1]. 
% 
% mode is the selected mode of integration. 
%       If mode == 0, the basic mode of integration will be 
%       performed (see “Pseudo-order of accuracy integration 
%       principle” for further details). 
%       If mode == 1, an augmented mode of the basic mode of 
%       integration will be performed. In this mode, the limits of I(k) 
%       intervals (see “Pseudo-order of accuracy integration 
%       principle” for further details) are augmented so that 
%       Lagrange polynomial extrapolation is averted for every I(k) 
%       possible. 
%       If mode == 2, an augmented mode of the basic mode of 
%       integration will be performed. In this mode, the limits of I(k) 
%       intervals (see “Pseudo-order of accuracy integration 
%       principle” for further details) are augmented so that not 
%       more than 1 + half of x(i) values of the S(k) set are higher 
%       or lower than the limits of I(k) for every I(k) interval 
%       possible. 
% 
% figr is the index of the figure in which the integration will be 
% visualized. It has to be a nonzero integer. If figr == 0, the 
% integration will not be visualized. 
% 
% ZIntegA is the output of the ZIntegralA function and it is the 
% numerical integral of the f function with the limits of integration 
% xmin and xmax with the pseudo-order of accuracy Psacc. 
% 
%% Pseudo-order of accuracy integration principle
% 
% This function uses the GetPointsZIntegralA0 function to divide 
% the X axis into several intervals I(k). In every I(k) interval, there 
% is a set S(k) of Psacc + 1 x(i) values. For each point P in the 
% interval I(k), the x(i) values of S(k) are the closest Psacc + 1 
% x(i) values to the P point. In each I(k) interval, the f function is 
% approximated by the Lagrange polynomial p(k) which is based 
% on {(x(i), y(i)) | x(i) is in S(k)}. This approximation of the function 
% f is then integrated with the limits of integration xmin and xmax. 
% With the GetPointsZIntegralA1 function and the 
% GetPointsZIntegralA2 function, the limits of I(k) intervals are 
% further augmented. See the description of the two functions 
% for further details. 

%     In the following lines, the x and y values are sorted.

%     In the following lines, the xmin and xmax values are set so 
%     that xmax > xmin. To account for the case of xmax < xmin, 
%     the final result will be multiplied by the integer 
%     LimitOrder. LimitOrder integer serves as the indicator of 
%     whether the input xmax < xmin or not, and is assigned the 
%     value “-1” in the former case and the value “1” in the latter 
%     case. LimitOrder integer is also used to assign the proper 
%     color scheme to the optional visualization of the integration. 

%     If Psacc == 0, the basic mode of integration is the only 
%     sensible one. 

%     In the following line, the borders for the intervals I(k) are 
%     calculated and given in the vector Ipoints together with the 
%     corresponding S(k) sets, each of which is represented by 
%     the corresponding row in the matrix Smatrix, e.i. the 
%     x(Smatrix(k, :)) values are the closest Psacc + 1 x(i) values 
%     to each P point in the interval [Ipoints(k), Ipoints(k + 1)]. 
%     For more details see the GetPointsZIntegralA0 function 
%     documentation. If mode ~=0, the limits of I(k) are further 
%     augmented by either the GetPointsZIntegralA1 function 
%     (i.e. if mode == 1) or the GetPointsZIntegralA2 function 
%     (i.e. if mode == 2). 

[TypeList, TypeDeletedList] = SeparateOptionalParameter(varargin, 'Type');

pars = inputParser;

paramName = 'Type';
defaultVal = 'A';
errorMsg = '''Type'' must be either "A", "Spline", or "PolyFit".';
validationFcn = @(x)assert(strcmp(x, 'A') || strcmp(x, 'Spline') ...
    || strcmp(x, 'PolyFit') , errorMsg);
addParameter(pars, paramName, defaultVal, validationFcn);

parse(pars, TypeList{:});

type = pars.Results.Type;

if strcmp(type, 'A')
    [yFit, Ipoints, Smatrix] = ZFindFitA(xData, yData, xFit, TypeDeletedList{:});
    varargout = {Ipoints, Smatrix};
else
    if strcmp(type, 'Spline')
        yFit = ZFindFitSpline(xData, yData, xFit, TypeDeletedList{:});
    else
        [yFit, pFitPolyFit] = ZFindFitPolyFit(xData, yData, xFit, TypeDeletedList{:});
        varargout = {pFitPolyFit};
    end
end

end