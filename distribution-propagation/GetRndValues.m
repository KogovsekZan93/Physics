function RndValues = GetRndValues...
    (VariablesDistributionInfo, N_Rnd)

pars = inputParser;

paramName = 'VariablesDistributionInfo';
errorMsg = '''VariablesDistributionInfo'' must be a horizontal cell.';
Size_VariablesDistributionInfo = size(VariablesDistributionInfo);
validationFcn = @(x)assert(iscell(x) && ...
    Size_VariablesDistributionInfo(1) == 1 && ...
    length(Size_VariablesDistributionInfo) <= 2, errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'N_Rnd';
errorMsg = '''N_Rnd'' must be a natural number.';
validationFcn = @(x)assert(isnumeric(x) && isscalar(x) && ...
    mod(x,1) == 0 && x > 0, errorMsg);
addRequired(pars, paramName, validationFcn);

parse(pars, VariablesDistributionInfo, N_Rnd);

length_Variables = length(VariablesDistributionInfo);
RndValues = num2cell(zeros(length_Variables, 1));

for i = 1 : length_Variables
    if iscell(VariablesDistributionInfo{i}) == 0
        RndValues{i} = ...
            (datasample(VariablesDistributionInfo{i}, N_Rnd))';
    else
        if ismatrix(VariablesDistributionInfo{i}{2}) && ...
                ~isvector(VariablesDistributionInfo{i}{2})
            RndValues{i} = (mvnrnd(VariablesDistributionInfo{i}{1}, ...
                VariablesDistributionInfo{i}{2}, N_Rnd))';
        else
            if VariablesDistributionInfo{i}{2} == 1
                RndValues{i} = 2 * VariablesDistributionInfo{i}{1}(2) * ...
                    (rand(1, N_Rnd) - (1 / 2)) + ...
                    VariablesDistributionInfo{i}{1}(1);
            else
                if VariablesDistributionInfo{i}{2} == 2
                    RndValues{i} = normrnd...
                        (VariablesDistributionInfo{i}{1}(1), ...
                        VariablesDistributionInfo{i}{1}(2), [1, N_Rnd]);
                else
                    if VariablesDistributionInfo{i}{2} == 3
                        variance_Variable = ...
                            VariablesDistributionInfo{i}{1}(2) * sqrt(12) / 2;
                        RndValues{i} = 2 * variance_Variable * ...
                            (rand(1, N_Rnd) - (1 / 2)) + ...
                            VariablesDistributionInfo{i}{1}(1);
                    else
                        error...
                            ('''VariablesDistributionInfo''{%d} does not satisfy proper form.', i)
                    end
                end
            end
        end
    end
end

RndValues = cell2mat(RndValues);

end