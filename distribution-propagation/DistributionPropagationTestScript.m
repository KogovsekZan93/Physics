% The test for the distribution-propagation function package is passed if 
% the command window is empty after running this script. Due to the random 
% nature of the functions of the distribution-propagation function 
% package, this test will not always be passed even in the absence of any 
% defects in the functions themselves. For this reason, in case the test 
% is not passed, run the script two more times. A function defect is 
% highly probable if it is consistent during all three runs of this 
% script. 


clc;
Figure23 = 23;
Vec_Figure1 =  [Figure23; 0];
handle_F_TestScript1 = @(x)Ff_TestScript(x, Vec_Figure1);

Avg_a = 14;
Std_a = 2;
DistributionMode_a = 2;
Distribution_a = {{Avg_a, Std_a}, DistributionMode_a};

Avg_b = 6;
Error_b= 1;
DistributionMode_b = 1;
Distribution_b = {{Avg_b, Error_b}, DistributionMode_b};

Avg_c = 4;
Error_c= 0.5;
DistributionMode_c = 1;
Distribution_c = {{Avg_c, Error_c}, DistributionMode_c};

Avg_T_Inside = 23;
Avg_T_Outside = 13;
Avg_T = [Avg_T_Inside; Avg_T_Outside];
Std_T_Inside = 2;
Std_T_Outside = 9;
TCorrCoeff = 0.9;
CorrelationMatrix_T = [power(Std_T_Inside, 2), ...
    TCorrCoeff * Std_T_Inside * Std_T_Outside; ...
    TCorrCoeff * Std_T_Inside * Std_T_Outside, power(Std_T_Outside, 2)];
Distribution_T = {Avg_T, CorrelationMatrix_T};

ProposedLambdaValues = [1.33; 1.95; 3; 1.4; 1.61; 1.21; 1.88; 1.92; 1.31];
Distribution_Lambda = ProposedLambdaValues;

Avg_d = 0.3;
Std_d = 0.1;
DistributionMode_d = 3;
Distribution_d = {{Avg_d, Std_d}, DistributionMode_d};

InputVariablesDistributionInfo = {Distribution_a, Distribution_b, ...
    Distribution_c, Distribution_T, Distribution_Lambda, Distribution_d};

N_Rnd = power(10, 6);

Avg_Std_f_TestScript = FindOutputVariableAvgStd...
    (InputVariablesDistributionInfo, handle_F_TestScript1, N_Rnd);
close(Figure23);

Avg_P = Avg_Std_f_TestScript(1, 1);
if abs((Avg_P / (2.379041095476084 * power(10, 4))) - 1) > power(10, -2)
    fprintf(...
        'There is a problem with FindOutputVariableAvgStd: ''Avg_P''\n');
end
Avg_V = Avg_Std_f_TestScript(2, 1);
if abs((Avg_V / 68.465707690481878) - 1) > power(10, -2)
    fprintf(...
        'There is a problem with FindOutputVariableAvgStd: ''Avg_V''\n');
end
Std_P = Avg_Std_f_TestScript(1, 2);
if abs((Std_P / (2.243970250979463 * power(10, 4))) - 1) > power(10, -2)
    fprintf(...
        'There is a problem with FindOutputVariableAvgStd: ''Std_P''\n');
end
Std_V = Avg_Std_f_TestScript(2, 2);
if abs((Std_V / 18.411993462889569) - 1) > power(10, -2)
    fprintf(...
        'There is a problem with FindOutputVariableAvgStd: ''Std_V''\n');
end

Figure4 = 4;
Vec_Figure2 =  [Figure4; Figure23];
handle_F_TestScript2 = @(x)Ff_TestScript(x, Vec_Figure2); clear Vec_Figure;
[Avg_f_TestScript, CovarMat_f_TestScript] = ...
    FindOutputVariableAvgCovarMat...
    (InputVariablesDistributionInfo, handle_F_TestScript2, N_Rnd);

Avg_P = Avg_f_TestScript(1);
if abs((Avg_P / (2.369923014611711 * power(10, 4))) - 1) > power(10, -2)
    fprintf(...
        'There is a problem with FindOutputVariableAvgCovarMat: ''Avg_P''\n');
end
Avg_V = Avg_f_TestScript(2);
if abs((Avg_V / 68.491866525230037) - 1) > power(10, -2)
    fprintf(...
        'There is a problem with FindOutputVariableAvgCovarMat: ''Avg_V''\n');
end
Std_P = sqrt(CovarMat_f_TestScript(1, 1));
if abs((Std_P / (2.237370919475807* power(10, 4))) - 1) > power(10, -2)
    fprintf(...
        'There is a problem with FindOutputVariableAvgCovarMat: ''Std_P''\n');
end
Std_V = sqrt(CovarMat_f_TestScript(2, 2));
if abs((Std_V / 18.414277583206498) - 1) > power(10, -2)
    fprintf(...
        'There is a problem with FindOutputVariableAvgCovarMat: ''Std_V''\n');
end
PVCorrCoeff = CovarMat_f_TestScript(1, 2) / (Std_P * Std_V);
if abs((PVCorrCoeff / -0.240922037552307) - 1) > power(10, -1)
    fprintf(...
        'There is a problem with FindOutputVariableAvgCovarMat: ''PVCorrCoeff''\n');
end

close(Figure4);
close(Figure23);
clear Avg_a Avg_b Avg_c Avg_d Avg_f_TestScript Avg_P ...
    Avg_Std_f_TestScript Avg_T Avg_T_Inside Avg_T_Outside Avg_V ...
    CorrelationMatrix_T CovarMat_f_TestScript Distribution_a ...
    Distribution_b Distribution_c Distribution_d Distribution_Lambda ...
    Distribution_T DistributionMode_a DistributionMode_b ...
    DistributionMode_c DistributionMode_d Error_b Error_c Figure23 ...
    Figure4 handle_F_TestScript1 handle_F_TestScript2 ...
    InputVariablesDistributionInfo N_Rnd ProposedLambdaValues ...
    PVCorrCoeff Std_a Std_d Std_P Std_T_Inside Std_T_Outside Std_V ...
    TCorrCoeff Vec_Figure1 Vec_Figure2

function Vec_Ff_TestScript = Ff_TestScript(Vec_Input, Vec_Figure)

Value_a = Vec_Input(1);
Value_b = Vec_Input(2);
Value_c = Vec_Input(3);
Value_T_Inside = Vec_Input(4);
Value_T_Outside = Vec_Input(5);
Value_Lambda = Vec_Input(6);
Value_d = Vec_Input(7);

Value_P = ...
    (2 * Value_a * Value_b + 2 * Value_a * Value_c + Value_b * Value_c) ...
    * (Value_T_Inside - Value_T_Outside) * Value_Lambda / Value_d;
Value_V = (2 * Value_a * Value_b + ...
    2 * Value_a * Value_c + Value_b * Value_c) * Value_d;

Vec_f_TestScript = [Value_P; Value_V];

if Value_V > 100
    Validity = 0;
else
    Validity = 1;
end

Vec_Ff_TestScript = [Vec_f_TestScript; Vec_Figure; Validity];

end