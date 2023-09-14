function [avg_f, CovarMat_f] = FindOutputVariableAvgCovarMat...
    (InputVariablesDistributionInfo, handle_F, N_Rnd)

[OutputVariablesMatrix, figureVector] = ...
    GetOutputVariablesMatrix...
    (InputVariablesDistributionInfo, handle_F, N_Rnd);

avg_f = (mean(OutputVariablesMatrix))';
CovarMat_f = cov(OutputVariablesMatrix);
sigma_f = sqrt(diag(CovarMat_f));

DrawOutputVariableDistribution...
    (OutputVariablesMatrix, figureVector, avg_f, sigma_f);

end