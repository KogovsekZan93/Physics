function Vec_Ff_TutorialAlternative = ...
    Ff_TutorialAlternative(Vec_Input, Vec_Figure)
%% The incomplete alternative to the Ff_TutorialCombined 
%% function
% 
% Author: Žan Kogovšek
% Date: 12.31.2023
% Last changed: 1.6.2024
% 
%% Description
% 
% Given the column vectors 'Vec_Input' and 'Vec_Figure', this 
% function returns the vector VVec_Ff_TutorialAlternative, which 
% is the vector of the values of the variables of interest (P and 
% V), appended by the 'Vec_Figure' vector and the 'Validity' 
% number. 

Value_a = Vec_Input(1);
Value_b = Vec_Input(2);
Value_c = Vec_Input(3);
Value_T_Inside = Vec_Input(4);
Value_T_Outside = Vec_Input(5);
Value_Lambda = Vec_Input(6);
Value_d = Vec_Input(7);

Value_P = (2 * Value_a * Value_b + 2 * Value_a * Value_c + ...
    Value_b * Value_c) * (Value_T_Inside - Value_T_Outside) * ...
    Value_Lambda / Value_d;
Value_V = (2 * Value_a * Value_b + 2 * Value_a * Value_c + ...
    Value_b * Value_c) * Value_d;

Vec_f_Tutorial = [Value_P; Value_V];

if Value_V > 100
    Validity = 0;
else
    Validity = 1;
end
% If 'Validity' = 0, the 'Vec_f_Tutorial' vector is invalid, and if 
% 'Validity' = 1, the 'Vec_f_Tutorial' vector is valid. 

Vec_Ff_TutorialAlternative = ...
    [Vec_f_Tutorial; Vec_Figure; Validity];

end