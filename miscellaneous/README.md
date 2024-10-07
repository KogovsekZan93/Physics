# Welcome to the miscellaneous function package
This function package contains a mix of functions, which can be used in 
synergy with the functions of many other function packages of the Physics 
suppository but do not strictly belong to any specific function package. 

# The functions
This function package contains three functions. 

The PlotHorizontalErrorbar function is a function NOT written by Žan 
Kogovšek. It is the equivalent of the MATLAB errorbar function for 
plotting vertical error bars at plot points. 

The GetCustomDistribution function can be used to generate a vector of 
variable values, the frequency of each is proportional to the arbitrary 
user-defined probability density function value at the aforementioned 
variable value. 
The vector of values can be used directly as an element of the input 
'InputVariablesDistributionInfo' cell array of either the 
FindOutputVariableAvgStd function or the 
FindOutputVariableAvgCovarMat function of the distribution-propagation 
function package to provide information about the probability density 
function of the aforementioned variable. 

The EvaluateRectangleFunction function can be used to evaluate the 
rectangle function at individual values of the input vector x. The 
EvaluateRectangleFunction function is similar to the MATLAB function 
called the rectangularPulse function. 

# MiscellaneousTestScript
The MiscellaneousTestScript script is the test script which can be used 
upon changing the code to check whether it still performs as intended. If 
there are no error messages after running the test script, it can be 
assumed that the functions perform as intended. 

# Installation of the miscellaneous function package
On the "Home" tab, in the Environment section, click the "Set Path" 
button. The "Set Path" dialog box opens, listing all folders in the search 
path. 
Now, click the "Add Folder..." button in the dialog box. 
The "Add Folder to Path" dialog box opens. 
Now, search the "miscellaneous" folder by single-clicking it and then 
click the "Select Folder" button thereby closing the "Add Folder to Path" 
dialog box. 
Now, in the "Set Path" dialog box, click the "Move to Bottom". 
Click the "Save" button, then click the "Close" button. 
If upon clicking the "Close" button you are prompted by the Save Path 
dialogue box, click the "Yes" button. 