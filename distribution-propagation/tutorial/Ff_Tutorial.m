function Vec_Ff_Tutorial = Ff_Tutorial(Vec_Input)
%% The function with the imbedded f_Tutorial function
% 
% Author: Žan Kogovšek
% Date: 12.27.2023
% Last changed: 6.17.2024
% 
%% Description
% 
% Given the column vector 'Vec_Input', this function returns the vector 
% Vec_Ff_Tutorial, which is the output vector of the f_Tutorial function 
% with the 'Vec_Input' vectors as its input, which is appended by the 
% 'Vec_Figure' vector and the 'Validity' number. 


Vec_f_Tutorial = f_Tutorial(Vec_Input);

Vec_Figure = [23; 0];
% The distribution of the variable represented by the first value of the 
% 'Vec_f_Tutorial' vector is to be plotted in the figure window 23 while 
% the variable represented by the second value of the 'Vec_f_Tutorial' 
% vector is not to be plotted. 

Value_V = Vec_f_Tutorial(2);

if Value_V > 100
    Validity = 0;
else
    Validity = 1;
end
% If 'Validity' = 0, the 'Vec_f_Tutorial' vector is invalid, and if 
% 'Validity' = 1, the 'Vec_f_Tutorial' vector is valid. 

Vec_Ff_Tutorial = [Vec_f_Tutorial; Vec_Figure; Validity];

end