function RndValues = GetRndValues(Variables, N_Rnd)

length_Variables = length(Variables);
RndValues = num2cell(zeros(length_Variables, 1));

for i = 1 : length_Variables
    if iscell(Variables{i}) == 0
        RndValues{i} = (datasample(Variables{i}, N_Rnd))';
    else
        if ismatrix(Variables{i}{2}) && ~isvector(Variables{i}{2})
            RndValues{i} = ...
                (mvnrnd(Variables{i}{1}, Variables{i}{2}, N_Rnd))';
        else
            if Variables{i}{2} == 1
                RndValues{i} = 2 * Variables{i}{1}(2) * ...
                    (rand(1, N_Rnd) - (1 / 2)) + Variables{i}{1}(1);
            else
                if Variables{i}{2} == 2
                    RndValues{i} = normrnd...
                        (Variables{i}{1}(1), Variables{i}{1}(2), [1, N_Rnd]);
                else
                    if Variables{i}{2} == 3
                        variance_Variable = Variables{i}{1}(2) * sqrt(12) / 2;
                        RndValues{i} = 2 * variance_Variable * ...
                            (rand(1, N_Rnd) - (1 / 2)) + Variables{i}{1}(1);
                    end
                end
            end
        end
    end
end

RndValues = cell2mat(RndValues);

end