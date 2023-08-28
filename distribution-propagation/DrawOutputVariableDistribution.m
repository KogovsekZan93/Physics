function DrawOutputVariableDistribution...
    (OutputVariablesMatrix, figureVector, avg_f, sigma_f)

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
    '''avg_f'' must be a column vector of real numbers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) && ...
    isreal(x), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'sigma_f';
errorMsg = ...
    '''sigma_f'' must be a column vector of real numbers.';
validationFcn = @(x)assert(isnumeric(x) && iscolumn(x) && ...
    isreal(x) == 1, errorMsg);
addRequired(pars, paramName, validationFcn);

parse(pars, OutputVariablesMatrix, figureVector, avg_f, sigma_f);

length_OutputVariables = length(OutputVariablesMatrix(1, :));

for j = 1 : length_OutputVariables
    if figureVector(j) ~= 0
        figure(figureVector(j));
        clf;
        hold on;
        
        histogram(OutputVariablesMatrix(:, j), 'Normalization', 'pdf');
        
        length_x = power(10,3);
        x = linspace(avg_f(j) - 3 * sigma_f(j), ...
            avg_f(j) + 3 * sigma_f(j), length_x);
        plot(x, normpdf(x, avg_f(j), sigma_f(j)), 'r');
        
        xlim([avg_f(j) - 3 * sigma_f(j), avg_f(j) + 3 * sigma_f(j)]);
        grid on;
        hold off;
    end
end

end