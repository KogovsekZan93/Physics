function avg_sigma_f = ComposedVariable...
    (InputVariablesDistributionInfo, handle_f, N_Rnd)
%VARIABLES je cell data v obliki VARIABLES={{[avgx;delx],ux}, 
%{[avgy;dely],uy}, [z1;z2;z3;...], {[avgh;delh],uh}, {m_vec, P_m}}
%Ce je element VARIABLES vektor, se po njem nakljucno vzorci.
%Ce je element VARIABLES celica, je ta oblike {[avgx,delx],ux} in se 
%vzorci bodisi:
% isa(h, 'function_handle')
%z enakomerno porazdelitvijo, ce ux=1, na intervalu 
%[avgx-delx,avgx+delx]

%z normalno porazdelitvijo, ce ux=2, s povprecjem avgx in 
% standardno deviacijo delx

%z enakomerno porazdelitvijo, ce ux=3 in standardno deviacijo delx


%f je handle funkcije, ki sprejme vektor [x;y;z;h;...] in vrne 
%vektor fvec=[f1;f2;f3;...;repf1;repf2;repf3;...;validity].
%f1, f2, f3, ... so vrnjene vrednosti funkcije.
%Ce repfi=1, bodo vrednosti funkcije fi prikazane na histogramu.
%Parameter validity pove, ali je vrednost celotnega nabora 
%funkcijskih spremenljivk validen (v tem primeru je njegova 
%vrednost enaka validity=1), denimo, ce logaritmiramo negativno 
%stevilo, lahko rezultat oznacimo za invaliden in ga s tem 
%odstranimo iz vzorca.

%frepresnet je sestavljen kot
%[  avgf1,    stdf1;
%   avgf2,    stdf2;
%   avgf3,    stdf3;
%   ...       ...
%                   ]

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

OutputVariablesMatrix = zeros(N_Rnd, length_OutputVariables);

ColumnIndex_OutputVariablesMatrix = 1;
NumberofRemainingColumns_OutputVariablesMatrix = N_Rnd;
while N_Rnd >= ColumnIndex_OutputVariablesMatrix
    
    for i = 1 : NumberofRemainingColumns_OutputVariablesMatrix
        OutputVariablesVector = ...
            handle_f(GeneratedInputVariables(:, i));
        if OutputVariablesVector(end) ~= 0
            OutputVariablesMatrix...
                (ColumnIndex_OutputVariablesMatrix, :) = ...
                (OutputVariablesVector(1 : length_OutputVariables))';
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
    

avg_sigma_f = [length_OutputVariables, 2];

for j = 1 : length_OutputVariables
    avg_sigma_f(j, :) = [mean(OutputVariablesMatrix(:, j)), ...
        std(OutputVariablesMatrix(:, j))];
end


for j = 1 : length_OutputVariables
    if OutputVariablesVector(j + length_OutputVariables) ~= 0
        figure(OutputVariablesVector(j + length_OutputVariables));
        clf;
        hold on;
        
        histogram(OutputVariablesMatrix(:, j), 'Normalization', 'pdf');
        
        avg_f = avg_sigma_f(j, 1);
        sigma_f = avg_sigma_f(j, 2);
        length_x = power(10,3);
        x = linspace...
            (avg_f - 3 * sigma_f, avg_f + 3 * sigma_f, length_x);
        plot(x, normpdf(x, avg_f, sigma_f), 'r');
        
        xlim([avg_f - 3 * sigma_f, avg_f + 3 * sigma_f]);
        grid on;
        hold off;
    end
end

end