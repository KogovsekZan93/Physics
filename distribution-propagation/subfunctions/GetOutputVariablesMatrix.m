function [OutputVariablesMatrix, varargout] = ...
    GetOutputVariablesMatrix(InputVariablesDistributionInfo, ...
    handle_F, N_Rnd)
%% Tool for finding the output vectors of a function based on random 
%% values of input variables
% 
% Author: �an Kogov�ek
% Date: 9.24.2023
% Last changed: 6.17.2024
% 
%% Description
% 
% Given the input cell array 'InputVariablesDistributionInfo', which 
% contains information about the distribution of the input variables of 
% the f function, the input function handle 'handle_F' of the F function, 
% which contain the f function, and the input integer 'N_Rnd', this 
% function returns the matrix 'OutputVariablesMatrix' of horizontally 
% stacked vectors 'OutputVariablesMatrix'(:, j), each of which is the 
% valid output vector of the f function using the j-th randomly generated 
% vector of values of input variables based on the information about their 
% distribution. 
% Also, using this function, the optional output variable 'FigureVector' 
% can be obtained, which can be used as an input parameter of the 
% DrawOutputVariableDistribution function. 
% 
%% Variables
% 
% This function has the form of [OutputVariablesMatrix, varargout] = ...
% GetOutputVariablesMatrix...
% (InputVariablesDistributionInfo, handle_F, N_Rnd)
% 
% 'InputVariablesDistributionInfo' is a horizontal cell array. Each 
% 'InputVariablesDistributionInfo'{i} cell contains the information about 
% the distribution of the i-th input variable or the f function. 
% Each cell of the 'InputVariablesDistributionInfo' cell array can only be 
% of one of the following five forms: 
%    1. 'InputVariablesDistributionInfo'{i} is a column vector of 
%       numbers. 
%          In this case, the i-th input variable of the f function is a 
%          number. The values of the i-th input variable will be generated 
%          by random selection of one of the numbers of the 
%          'InputVariablesDistributionInfo'{i} vector. 
%    2.	'InputVariablesDistributionInfo'{i} has the form {'V', 'R'}, where 
%       'V' is a column vector and 'R' a matrix of numbers. 
%          In this case, the i-th input variable of the f function is a 
%          column vector. The values of the i-th input variable will be 
%          the randomly generated vectors with the mean 'V' and the 
%          covariance matrix 'R' of the variables of the vector. 
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
%    1. The first part (vec_F(1 : length_f)) is the output vector vec_f of 
%       the f function. 
%    2.	For the second part (vec_F('length_f' + 1 : 2 * 'length_f')), the 
%       value of each variable vec_F(m + 'length_f') is the m-th value of 
%       the 'FigureVector', which can be used as an input parameter of the 
%       DrawOutputVariableDistribution function. 
%    3. Finally, the value of the last variable of the vec_F vector 
%       (vec_F(2 * length_f + 1)) must be either 0 if the values of the 
%       vec_f vector are invalid or 1 if the values of the vec_f vector 
%       are valid. The vec_f vector will only used to construct the 
%       'OutputVariablesMatrix' matrix if it is valid. If not, a new 
%       vector is randomly generated in place of the invalid one. 
% 
% 'N_Rnd' is the number of valid output vectors vec_f of the f function to 
% be randomly generated and used to construct the 'OutputVariablesMatrix' 
% matrix by stacking them horizontally together. It must be a natural 
% number. 
% 
% 'OutputVariablesMatrix' is a matrix of 'N_Rnd' horizontally stacked 
% vectors vec_f, each of which is a valid output vector of the f function 
% produced by randomly generated values of the input variables based on 
% their distribution. 
% 
% 'varargout' represents the optional output parameter 'FigureVector', 
% which can be used as an input parameter of the 
% DrawOutputVariableDistribution function. 


pars = inputParser;

paramName = 'handle_f';
errorMsg = '''handle_f'' must be a function handle.';
validationFcn = @(x)assert(isa(x, 'function_handle'), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'N_Rnd';
errorMsg = '''N_Rnd'' must be a natural number.';
validationFcn = @(x)assert(isnumeric(x) && isscalar(x) && mod(x,1) == 0 ...
    && x > 0, errorMsg);
addRequired(pars, paramName, validationFcn);

parse(pars, handle_F, N_Rnd);

GeneratedInputVariables = GetRndValues...
    (InputVariablesDistributionInfo, N_Rnd);

length_f = (length(handle_F(GeneratedInputVariables(:, 1))) - 1) / 2;

% In the following while loop, the 'OutputVariablesMatrix' matrix, 
% initially a properly sized matrix of zeros, is to be constructed by 
% replacing its columns of zeroes by valid f_vec vectors. The 
% 'ColumnIndex_OutputVariablesMatrix' is the index of the column of the 
% 'OutputVariablesMatrix' to be next replaced by a valid f_vec vector. The 
% 'NumberofRemainingColumns_OutputVariablesMatrix' variable is the number 
% of columns of zeros of the 'OutputVariablesMatrix' matrix which still 
% have to be replaced by valid vec_f vectors. 
% At each pass of the while loop, until all columns of zeros of the 
% 'OutputVariablesMatrix' are replaced by valid vec_f vectors, 
% 'NumberofRemainingColumns_OutputVariablesMatrix' output vectors 'vec_F' 
% of the F function are generated using the input values generated by the 
% GetRndValues function. Then, from the 'vec_F' vectors which are valid 
% (i.e. 'vec_F'(end) = 1), the vec_f vectors (i.e. 'vec_F'(1 : 'length_f') 
% are extracted and used to replace the yet nonreplaced columns of zeros 
% of the 'OutputVariablesMatrix' matrix. 
OutputVariablesMatrix = zeros(length_f, N_Rnd);
ColumnIndex_OutputVariablesMatrix = 1;
NumberofRemainingColumns_OutputVariablesMatrix = N_Rnd;
while N_Rnd >= ColumnIndex_OutputVariablesMatrix
    
    for i = 1 : NumberofRemainingColumns_OutputVariablesMatrix
        vec_F = handle_F(GeneratedInputVariables(:, i));
        if vec_F(end) ~= 0
            OutputVariablesMatrix...
                (:, ColumnIndex_OutputVariablesMatrix) = vec_F...
                (1 : length_f);
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

FigureVector = vec_F(length_f + 1 : end - 1);
varargout = {FigureVector};

end