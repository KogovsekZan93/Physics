function RectangleFunctionValueVector = EvaluateRectangleFunction(x)
%% Homemade version of the MATLAB rectangularPulse function
%
% Author: Žan Kogovšek
% Date: 10.1.2024
% Last changed: 10.7.2024
% 
%% Description
% 
% Given the input vector 'x' of real numbers, this function returns the 
% output vector 'RectangleFunctionValueVector' of values 
% 'RectangleFunctionValueVector'(i), each of which is the rectangle 
% function value for the input variable value 'x'(i) of the input vector 
% 'x'. 
% Thus, the EvaluateRectangleFunction function is similar to the MATLAB 
% function called the rectangularPulse function. 
% 
%% Variables
% 
% This function has the form of RectangleFunctionValueVector = ...
% EvaluateRectangleFunction(x)
% 
% 'x' is the vector of real numbers the image of which in respect to the 
% rectangle function is to be evaluated by this function. 
% 
% 'RectangleFunctionValueVector' is a column vector of values 
% 'RectangleFunctionValueVector'(i), each of which is the value of the 
% rectangle function for input variable value 'x'(i). 
% The rectangle function is defined such that its value is 0 if the 
% absolute value of its input variable is below 0.5 and 1 if the absolute 
% value of its input variable is above 0.5. If the absolute value of the 
% input variable of the rectangle function is exactly 0.5, the value of 
% the rectangle function is 0.5. 


Length_x = length(x);
RectangleFunctionValueVector = zeros(Length_x, 1);

for i = 1 : Length_x
    if abs(x(i)) == 0.5
        RectangleFunctionValueVector(i) = 0.5;
    else
        if abs(x(i)) < 0.5
            RectangleFunctionValueVector(i) = 1;
        else
            RectangleFunctionValueVector(i) = 0;
        end
    end
end

end