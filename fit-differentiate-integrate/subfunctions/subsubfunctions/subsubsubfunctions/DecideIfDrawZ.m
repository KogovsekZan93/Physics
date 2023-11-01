function DecideIfDrawZ...
    (DrawZFunctionHandle, DrawZInput, varargin)
%% Tool for deciding whether or not to perform a 
%% DrawZFit... or a DrawZIntegral... function call
% 
% Author: Žan Kogovšek
% Date: 4.30.2023
% Last changed: 11.1.2023
% 
%% Description
% 
% Given a DrawZFit... or a DrawZIntegral... function handle 
% 'DrawZFunctionHandle' and the cell array 'DrawZInput' of 
% input parameters for the DrawZFit... or the DrawZIntegral... 
% function, this function either is a null function or the function 
% call 'DrawZFunctionHandle'('Figure', 'DrawZInput'{:}) is 
% performed, depending on the value of the 'Figure' parameter, 
% where 'Figure' is the value of the optional input parameter 
% named ''Figure'', the default value of which is 0. If 'Figure' = 0, 
% the function call will not be performed (thus, this function 
% effectively becomes a null function). If the 'Figure' parameter 
% is a natural number, the function call will be performed. 
% 
%% Variables
% 
% This function has the form of DecideIfDrawZ...
% (DrawZFunctionHandle, DrawZInput, varargin)
% 
% 'DrawZFunctionHandle' is the function handle for either one of 
% the three DrawZFit... functions or one of the three 
% DrawZIntegral... functions. 
% 
% 'DrawZInput' is the horizontal cell array of all input parameters 
% of the function the handle of which is the 
% 'DrawZFunctionHandle' function handle except the 'Figure' 
% parameter. The input parameters of the 'DrawZInput' cell array 
% must be in appropriate order in respect to the function the 
% handle of which is the 'DrawZFunctionHandle' function 
% handle. 
% 
% 'varargin' represents the optional input parameter named 
% ''Figure''. ''Figure'' is the name of the parameter the value of 
% which is the 'Figure' index. If 'Figure' = 0, this function is 
% effectively a null function (this is the default value). If the 
% 'Figure' parameter is a natural number, it will be the first 
% parameter of the function the handle of which is the 
% 'DrawZFunctionHandle' function handle, which is then followed 
% by the input parameters of the 'DrawZInput' horizontal cell 
% array when the call of the function via the 
% 'DrawZFunctionHandle' function handle is performed by this 
% function. 


pars = inputParser;

paramName = 'DrawZFunctionHandle';
errorMsg = '''DrawZFunctionHandle'' must be a function handle.';
validationFcn = @(x)assert(isa(x, 'function_handle'), errorMsg);
addRequired(pars, paramName, validationFcn);

paramName = 'Figure';
defaultVal = 0;
errorMsg = '''Figure'' must be a non-negative integer.';
validationFcn = @(x)assert(isnumeric(x) && isscalar(x) && ...
    x >= 0 && mod(x,1) == 0, errorMsg);
addParameter(pars, paramName, defaultVal, validationFcn);

parse(pars, DrawZFunctionHandle, varargin{:});

Figure = pars.Results.Figure;

if Figure ~= 0
    figure(Figure); clf;
    DrawZFunctionHandle(Figure, DrawZInput{:});
end

end