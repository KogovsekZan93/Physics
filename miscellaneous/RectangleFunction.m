function RectangleFunctionValue = RectangleFunction(x)
%RECTANGLEFUNCTION Summary of this function goes here
%   Detailed explanation goes here
Length_x = length(x);
RectangleFunctionValue = zeros(Length_x, 1);

for i = 1 : Length_x
    if abs(x) == 0.5
        RectangleFunctionValue(i) = 0.5;
    else
        if abs(x) < 0.5
            RectangleFunctionValue(i) = 1;
        else
            RectangleFunctionValue(i) = 0;
        end
    end
end

end