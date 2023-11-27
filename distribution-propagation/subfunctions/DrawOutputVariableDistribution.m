function DrawOutputVariableDistribution...
    (OutputVariablesMatrix, FigureVector, Avg_f, Std_f)
%% Tool for plotting the distribution of the selected 
%% function output variables
% 
% Author: Žan Kogovšek
% Date: 9.17.2023
% Last changed: 11.27.2023
% 
%% Description
% 
% Given the matrix 'OutputVariablesMatrix' of column vectors of 
% valid outputs of the f function, the 'FigureVector' vector of 
% integers, the vector 'Avg_f' of average values of the output 
% variables of the f function, and the vector 'Std_f' of the 
% standard deviations of the output variables of the f function, 
% this function plots the distribution of all j-th output variables of 
% the f function for which 'FigureVector'(j) is a natural number 
% and thus the index of the figure window on which the 
% distribution is to be plotted. Additionally, in each figure window 
% with the index 'FigureVector'(j) ~= 0, a normal distribution 
% curve which has the same mean (i.e. 'Avg_f'(j)) and standard 
% deviation (i.e. 'Std_f'(j)) as the distribution of the j-th output 
% variable of the f function is plotted.
% 
%% Variables
% 
% This function has the form of DrawOutputVariableDistribution...
% (OutputVariablesMatrix, FigureVector, Avg_f, Std_f)
% 
% 'OutputVariablesMatrix' is a matrix of horizontally stacked 
% column vectors, each of which is an output of the f function, 
% the input of the f function being provided by random 
% generation of the values of the input variables based on the 
% information on their distribution. 
% 
% 'FigureVector' is a vector of nonnegative integers. If the 
% integer 'FigureVector'(j) is a natural number, it is considered 
% as the index of the figure window in which the distribution of 
% j-th output variable of the f function is to be plotted in the form 
% of a blue normalized histogram. Also, the normal distribution 
% curve with the same mean value and standard distribution as 
% the distribution of the j-the output variable of the f function will 
% be plotted in the same figure window in the form of a red 
% curve. If 'FigureVector'(j) = 0, neither the distribution of the j-th 
% output variable of the f function or the corresponding normal 
% distribution curve will not be plotted. The 'FigureVector' vector 
% must be a column vector of nonnegative integers with the 
% same length as the 'OutputVariablesMatrix' matrix. 
% 
% 'Avg_f' is the column vector of average values 'Avg_f'(j) of 
% each corresponding row 'OutputVariablesMatrix'(:, j) of the 
% 'OutputVariablesMatrix' matrix. The 'Avg_f' vector must be a 
% column vector. 
% 
% 'Std_f' is the column vector of standard deviation values 
% 'Std_f'(j) of each corresponding row 
% 'OutputVariablesMatrix'(:, j) of the 'OutputVariablesMatrix' 
% matrix. The 'Std_f' vector must be a column vector. 


pars = inputParser;

paramName = 'OutputVariablesMatrix';
errorMsg = ...
    '''OutputVariablesMatrix'' must be a matrix of real numbers.';
validationFcn = @(x)assert(isnumeric(x) && ismatrix(x) && ...
    isreal(x), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'FigureVector';
errorMsg = ...
    '''FigureVector'' must be a column vector of non-negative integers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) ...
    && (sum(mod(x,1) == 0) == 0  - length(x)) == 0 && ...
    sum(x >= 0) - length(x) == 0, errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'Avg_f';
errorMsg = ...
    '''Avg_f'' must be a column vector.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x), ...
    errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'sigma_f';
errorMsg = ...
    '''sigma_f'' must be a column vector.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x), ...
    errorMsg);
addRequired(pars, paramName, validationFcn);

parse(pars, OutputVariablesMatrix, FigureVector, Avg_f, Std_f);

length_OutputVariables = length(OutputVariablesMatrix(:, 1));

for j = 1 : length_OutputVariables
    if FigureVector(j) ~= 0
        figure(FigureVector(j));
        clf;
        hold on;
        
        histogram(OutputVariablesMatrix(j, :), 'Normalization', 'pdf');
        
% In the following block of code, the normal distribution curve 
% with the same mean value and standard distribution as the 
% distribution of the j-the output variable of the f function will be 
% plotted in the same figure window in the form of a red curve. 
        length_x = power(10,3);
        x = linspace(Avg_f(j) - 3 * Std_f(j), ...
            Avg_f(j) + 3 * Std_f(j), length_x);
        plot(x, normpdf(x, Avg_f(j), Std_f(j)), 'r');
        
        xlim([Avg_f(j) - 3 * Std_f(j), Avg_f(j) + 3 * Std_f(j)]);
        grid on;
        hold off;
    end
end

end