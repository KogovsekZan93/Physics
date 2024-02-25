# Welcome to the simple-linear-regression function package
This function package contains the functions for estimating 
simple linear regression coefficients of data points and plotting 
the estimated linear curves. 
Provided the data vectors "xData" and "yData" of some arbitrary 
linear function f 
(Y = f(X) = X * a + b, "yData" = f("xData") + error_yData), this 
function package can be used to estimate the values of the 
parameters a ("Slope") and b ("Intercept") as well as their 
correlation matrix "CovarMat_SlopeIntercept" and even the 
variance of the values of the "yData" vector if the covariance 
matrix of the "yData" is not already provided as the optional input 
parameter. This can be accomplished by the 
FindSimpleLinearRegressionCoefficients function, a faster and 
simplified version of which is the 
FindSimpleLinearRegressionCoefficientsFAST function. 
Additionally, the DrawSimpleLinearRegressionGraph function 
can be used to plot the estimated linear curve and its standard 
deviation area. 

# The tutorial
The tutorial folder provides the tutorial for the three functions of 
the function package. While the functions are designed to be 
intuitive to a degree and a quick skim through their 
documentation should be enough for the users to get started, the 
rather lengthy tutorial demonstrates the full scope of the 
functions of the simple-linear-regression function package, which 
may not be apparent to new users, and is thus warmly 
recommended to be gone through. 

# SimpleLinearRegressionTestScript
The SimpleLinearRegressionTestScript script is the test script 
which can be used upon changing the code to check whether it 
still performs as intended. If there are no error messages after 
running the test script, it can be assumed that the functions 
perform as intended. 

# Installation of the simple-linear-regression function package
On the "Home" tab, in the Environment section, click the 
"Set Path" button. The "Set Path" dialog box opens, listing all 
folders in the search path. 
Now, click the "Add Folder..." button in the dialog box. 
The "Add Folder to Path" dialog box opens. 
Now, search the "simple-linear-regression" folder by 
single-clicking it and then click the "Select Folder" button thereby 
closing the "Add Folder to Path" dialog box. 
Now, in the "Set Path" dialog box, click the "Move to Bottom" 
Click the "Save" button, then click the "Close" button. 
If upon clicking the "Close" button you are prompted by the Save 
Path dialogue box, click the "Yes" button. 

You have now completed the installation. 