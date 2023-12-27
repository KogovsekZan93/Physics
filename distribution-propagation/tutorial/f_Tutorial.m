function Vec_f_Tutorial = f_Tutorial(Vec_Input)
%% Tool for calculating the heat transfer rate and the 
%% volume of the walls of a cuboid building
% 
% Author: Žan Kogovšek
% Date: 12.27.2023
% Last changed: 12.27.2023
% 
%% Description
% 
% Given the column vector 'Vec_Input' of the values of the 
% building height ('Vec_Input'(1) =  'Value_a'), width 
% ('Vec_Input'(2) =  'Value_b'), and length 
% ('Vec_Input'(3) =  'Value_c'), the inside temperature 
% ('Vec_Input'(4) =  'Value_ T_inside') and the outside 
% temperature ('Vec_Input'(5) =  'Value_ T_inside'), the thermal 
% conductivity ('Vec_Input'(6) =  'Value_Lambda'), and the wall 
% thickness ('Vec_Input'(7) =  'Value_d'), this function returns 
% the column vector 'Vec_f_Tutorial', which contains the values 
% of the building heat transfer rate 
% ('Vec_f_Tutorial'(1) = 'Value_P') and the volume of the walls 
% ('Vec_f_Tutorial'(1) = 'Value_V'). 


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

end