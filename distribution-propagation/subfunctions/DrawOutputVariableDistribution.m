function DrawOutputVariableDistribution...
    (OutputVariablesMatrix, figureVector, avg_f, std_f)
%% Tool for plotting the distribution of the selected 
%% function output variables
% 
% Author: Žan Kogovšek
% Date: 9.17.2024
% Last changed: 9.20.2024
% 
%% Description
% 
% Given the matrix "OutputVariablesMatrix" of column vectors of 
% valid outputs of the f function, the "figureVector" vector of 
% integers, the vector "avg_f" of average values of the output 
% variables of the f function, and the vector "std_f" of the 
% standard deviations of the output variables of the f function, 
% this function plots the distribution of all j-th output variables of 
% the f function for which "figureVector"(j) is a natural number 
% and thus the index of the figure on which the distribution is to 
% be plotted. Additionally, on each figure with the index 
% "figureVector"(j) != 0, a normal distribution curve which has the 
% same mean (ie. "avg_f"(j)) and standard deviation (ie. 
% "std_f"(j)) as the distribution of the j-th output variable of the f 
% function is plotted.
% 
%% Variables
% 
% This function has the form of DrawOutputVariableDistribution...
% (OutputVariablesMatrix, figureVector, avg_f, std_f)
% 
% "OutputVariablesMatrix" is a matrix of horizontally stacked 
% column vectors, each of which is an output of the f function, 
% the input of the f function being provided by random 
% generation of the values of the input variables based on the 
% information on their distribution. 
% 
% "figureVector" is a vector of nonnegative integers. If the 
% integer "figureVector"(j) is a natural number, it is considered 
% as the index of the figure on which the distribution of j-th output 
% variable of the f function is to be plotted in the form of a blue 
% normalized histogram. Also, the normal distribution curve with 
% the same mean value and standard distribution as the 
% distribution of the j-the output variable of the f function will be 
% plotted in the same figure in the form of a red curve. If 
% "figureVector"(j) == 0, the distribution of the j-th output variable 
% of the f function or the corresponding normal distribution curve 
% will not be plotted. 
% The "figureVector" vector must be a column vector of 
% nonnegative integers with the same length as the 
% "OutputVariablesMatrix" matrix. 
% 
% "avg_f" is a column vector of average values "avg_f"(j) of 
% each corresponding row of the "OutputVariablesMatrix"(:, j). 
% The "avg_f" vector must be a column vector. 
% 
% "std_f" is a column vector of standard deviation values 
% "std_f"(j) of each corresponding row of the 
% "OutputVariablesMatrix"(:, j). The "std_f" vector must be a 
% column vector. 


pars = inputParser;

paramName = 'OutputVariablesMatrix';
errorMsg = ...
    '''OutputVariablesMatrix'' must be a matrix of real numbers.';
validationFcn = @(x)assert(isnumeric(x) && ismatrix(x) && ...
    isreal(x), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'figureVector';
errorMsg = ...
    '''figureVector'' must be a column vector of non-negative integers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) ...
    && (sum(mod(x,1) == 0) == 0  - length(x)) == 0 && ...
    sum(x >= 0) - length(x) == 0, errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'avg_f';
errorMsg = ...
    '''avg_f'' must be a column vector.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x), ...
    errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'sigma_f';
errorMsg = ...
    '''sigma_f'' must be a column vector.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x), ...
    errorMsg);
addRequired(pars, paramName, validationFcn);

parse(pars, OutputVariablesMatrix, figureVector, avg_f, std_f);

length_OutputVariables = length(OutputVariablesMatrix(:, 1));

for j = 1 : length_OutputVariables
    if figureVector(j) ~= 0
        figure(figureVector(j));
        clf;
        hold on;
        
        histogram(OutputVariablesMatrix(j, :), 'Normalization', 'pdf');
        
% In the following block of code, the normal distribution curve 
% with the same mean value and standard distribution as the 
% distribution of the j-the output variable of the f function will be 
% plotted in the same figure in the form of a red curve. 
        length_x = power(10,3);
        x = linspace(avg_f(j) - 3 * std_f(j), ...
            avg_f(j) + 3 * std_f(j), length_x);
        plot(x, normpdf(x, avg_f(j), std_f(j)), 'r');
        
        xlim([avg_f(j) - 3 * std_f(j), avg_f(j) + 3 * std_f(j)]);
        grid on;
        hold off;
    end
end

end