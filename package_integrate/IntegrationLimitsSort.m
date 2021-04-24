function [LimitsSorted, LimitOrder, ColorFace] = IntegrationLimitsSort(Limits)
%INTEGRATIONLIMITSSORT Summary of this function goes here
%   Detailed explanation goes here
LimitOrder = 1;
LimitsSorted = Limits;

ColorFace = [0, 0, 1];
if Limits(2) < Limits(1)
    LimitOrder = -1;
    LimitsSorted = Limits([2; 1]);
    ColorFace = [1, 0, 0];
end

end