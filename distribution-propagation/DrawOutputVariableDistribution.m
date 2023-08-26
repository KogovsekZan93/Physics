function DrawOutputVariableDistribution(OutputVariablesMatrix, figureVector, avg_f, sigma_f)
%DRAWOUTPUTVARIABLEDISTRIBUTION Summary of this function goes here
%   Detailed explanation goes here
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