function [Avg_f, CovarMat_f] = FindOutputVariableAvgCovarMat...
    (InputVariablesDistributionInfo, handle_F, N_Rnd)
%% Tool for finding the average values and the covariance matrix of the 
%% output variables
% 
% Author: �an Kogov�ek
% Date: 9.17.2023
% Last changed: 6.13.2024
% 
%% Description
% 
% Given the input cell array 'InputVariablesDistributionInfo', which 
% contains information about the distribution of the input variables of 
% the f function, the input function handle 'handle_F' of the F function, 
% which contains the f function, and the input integer 'N_Rnd', this 
% function returns the vector 'Avg_f' and the 'CovarMat_f' matrix. The 
% 'Avg_f'(j) value is the average value of the j-th output variable of the 
% f function and the 'CovarMat_f'(j, jj) value is the value of the 
% covariance of the j-th and the jj-th output variable of the f function. 
% The distributions of the individual output variables can also be plotted 
% along with the normal distribution curves which have the same averages 
% and standard deviations as the output variables. 
% The values of the 'Avg_f' vector and the 'CovarMat_f' matrix are based 
% on 'N_Rnd' valid outputs of the f function, where the input values are 
% randomly generated based on the distribution of the input variables. 
% 
%% Variables
% 
% This function has the form of [Avg_f, CovarMat_f] = ...
% FindOutputVariableAvgCovarMat...
% (InputVariablesDistributionInfo, handle_F, N_Rnd)
% 
% 'InputVariablesDistributionInfo' is a horizontal cell array. Each 
% 'InputVariablesDistributionInfo'{i} cell contains the information about 
% the distribution of the i-th input variable or the f function. Each cell 
% of the 'InputVariablesDistributionInfo' cell array can only be of one of 
% the following five forms: 
%    1. 'InputVariablesDistributionInfo'{i} is a column vector of numbers. 
%          In this case, the i-th input variable of the f function is a 
%          number. The values of the i-th input variable will be generated 
%          by random selection of one of the numbers of the 
%          'InputVariablesDistributionInfo'{i} vector. 
%    2.	'InputVariablesDistributionInfo'{i} has the form {'V', 'R'}, where 
%       'V' is a column vector and 'R' a matrix of numbers. 
%          In this case, the i-th input variable of the f function is a 
%          column vector. The values of the i-th input variable will be 
%          the randomly generated vectors with the mean 'V' and the 
%          covariance matrix 'R' of the variables of the 'V' vector. 
%    3.	'InputVariablesDistributionInfo'{i} has the form {{'V', 'S'}, 1}, 
%       where 'V' is a column vector and 'S' is a nonnegative real number. 
%          In this case, the i-th input variable of the f function is a 
%          vector. The values of the i-th input variable will be vectors 
%          v, the values v(k) of each vector v being independently 
%          randomly and uniformly generated from the interval 
%          ['V'(k) - 'S', 'V'(k) + 'S']. 
%    4.	'InputVariablesDistributionInfo'{i} has the form 
%       {{'V', 'STD'}, 2}, where 'V' is a column vector and 'STD' is a 
%       nonnegative real number. 
%          In this case, the i-th input variable of the f function is a 
%          column vector. The values of the i-th input variable will be 
%          vectors v, the values v(k) of each vector v being independently 
%          randomly generated from the normal distribution with the mean 
%          'V'(k) and the standard deviation 'STD'. 
%    5.	'InputVariablesDistributionInfo'{i} has the form 
%       {{'V', 'S_STD'}, 3}, where 'V' is a column vector and 'S_STD' is a 
%       nonnegative real number. 
%          In this case, the i-th input variable of the f function is a 
%          column vector. The values of the i-th input variable will be 
%          vectors v, the values v(k) of each vector v being independently 
%          randomly and uniformly generated such that the mean value is 
%          'V'(k) and the standard deviation is 'S_STD' (the interval thus 
%          being ['V'(k) - 'S_STD' * sqrt(12) / 2, 
%          'V'(k) + 'S_STD' * sqrt(12) / 2]). 
% 
% 'handle_F' is the function handle of the F function. The input variables 
% of the F function are the same as that of the f function. The input 
% variables must have the form of a single column vector (i.e. the 
% previously discussed input variables, each either a vertical vector or a 
% number, vertically stacked to create a single column vector). 
% The output variables of the f function must be in the form of a single 
% column vector vec_f of some length length_f. The output of the F 
% function must also be a single column vector vec_F which consists of 
% three parts (i.e. column vectors) stacked vertically: 
%    1.	The first part (vec_F(1 : length_f)) is the output vector vec_f of 
%       the f function. 
%    2.	For the second part (vec_F(length_f + 1 : 2 * length_f)), the 
%       value of each variable vec_F(m + length_f) is the index of the 
%       figure window on which the distribution of the vec_f(m) variable 
%       is to be plotted (if vec_F(m + length_f) = 0, the distribution of 
%       the vec_f(m) variable will not be plotted). 
%    3.	Finally, the value of the last variable of the vec_F vector 
%       (vec_F(2 * length_f + 1)) must be either 0 if the values of the 
%       vec_f vector are invalid or 1 if the values of the vec_f vector 
%       are valid. The values of the vec_f vector will only be used in the 
%       calculation of the average and the covariance of the output 
%       variables of the f function if they are valid. If not, a new 
%       vector is randomly generated in place of the invalid one. 
% 
% 'N_Rnd' is the number of valid output vectors vec_f of the f function to 
% be randomly generated and used to calculate the average and the 
% covariance of each variable of the output vector of the f function. It 
% must be a natural number. 
% 
% 'Avg _f' is a column vector and 'CovarMat_f' is a matrix. The 'Avg_f'(j) 
% value is the average value of the j-th output variable of the f function 
% and the 'CovarMat_f'(j, jj) value is the value of the covariance of the 
% j-th and the jj-th output variable of the f function. 
% The values of the 'Avg _f' vector and the 'CovarMat_f' matrix are based 
% on 'N_Rnd' valid outputs of the f function, the validity of the outputs 
% being based on the value of the final output variable of the F function. 
% The input values for each valid output of the f function are randomly 
% generated based on the distribution of the input variables, specified by 
% the 'InputVariablesDistributionInfo' cell array. 


% In the following line, the 'N_Rnd' valid outputs of the f function are 
% generated. 
[OutputVariablesMatrix, FigureVector] = GetOutputVariablesMatrix...
    (InputVariablesDistributionInfo, handle_F, N_Rnd);

Avg_f = mean(OutputVariablesMatrix, 2);
CovarMat_f = cov(OutputVariablesMatrix');
Std_f = sqrt(diag(CovarMat_f));

% In the following line, for the output variables j for which the value 
% F(length_f + j) is a natural number, the distribution of the j-th output 
% variable as well as the normal distribution curve which has the same 
% average and standard deviation as the distribution of the j-th output 
% variable is plotted. 
DrawOutputVariableDistribution...
    (OutputVariablesMatrix, FigureVector, Avg_f, Std_f);

end