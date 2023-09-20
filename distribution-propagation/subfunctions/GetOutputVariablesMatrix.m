function [OutputVariablesMatrix, varargout] = ...
    GetOutputVariablesMatrix(InputVariablesDistributionInfo, ...
    handle_f, N_Rnd)

pars = inputParser;

paramName = 'handle_f';
errorMsg = '''handle_f'' must be a function handle.';
validationFcn = @(x)assert(isa(x, 'function_handle'), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'N_Rnd';
errorMsg = '''N_Rnd'' must be a natural number.';
validationFcn = @(x)assert(isnumeric(x) && isscalar(x) && ...
    mod(x,1) == 0 && x > 0, errorMsg);
addRequired(pars, paramName, validationFcn);

parse(pars, handle_f, N_Rnd);

GeneratedInputVariables = GetRndValues...
    (InputVariablesDistributionInfo, N_Rnd);

length_OutputVariables = ...
    (length(handle_f([GeneratedInputVariables(:, 1)])) - 1) / 2;

OutputVariablesMatrix = zeros(length_OutputVariables, N_Rnd);

ColumnIndex_OutputVariablesMatrix = 1;
NumberofRemainingColumns_OutputVariablesMatrix = N_Rnd;
while N_Rnd >= ColumnIndex_OutputVariablesMatrix
    
    for i = 1 : NumberofRemainingColumns_OutputVariablesMatrix
        OutputVariablesVector = ...
            handle_f(GeneratedInputVariables(:, i));
        if OutputVariablesVector(end) ~= 0
            OutputVariablesMatrix...
                (:, ColumnIndex_OutputVariablesMatrix) = ...
                OutputVariablesVector(1 : length_OutputVariables);
            ColumnIndex_OutputVariablesMatrix = ...
                ColumnIndex_OutputVariablesMatrix + 1;
        end
    end
    NumberofRemainingColumns_OutputVariablesMatrix = ...
        N_Rnd - (ColumnIndex_OutputVariablesMatrix - 1);
    
    if NumberofRemainingColumns_OutputVariablesMatrix ~= 0
        GeneratedInputVariables = GetRndValues...
            (InputVariablesDistributionInfo, ...
            NumberofRemainingColumns_OutputVariablesMatrix);
    end
    
end

figureVector = OutputVariablesVector...
    (length_OutputVariables + 1 : end - 1);
varargout = {figureVector};

end