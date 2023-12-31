% Supposedly one wishes to determine the rate of heat transfer 
% P through the walls of a building in the shape of a rectangular 
% cuboid (i.e. a box) and the volume V of the walls, which are 
% determined by the following two equation, respectively: 
% 
% (1) P = s * delT * Lambda = (2 * a * b + 2 * a * c + b * c) * 
%       (T_Inside - T_Outside) * Lambda / d, 
% (2) V = (2 * a * b + 2 * a * c + b * c) * d, 
% 
% where s is the total surface area of the walls the, delT is the 
% temperature difference between the inside temperature 
% T_Inside and the outside temperature 
% T_Outside, Lambda is the thermal conductivity, a is the 
% height of the building, b is the width of the building, c is the 
% length of the building, and d is the thickness of the walls. 


%                                           Page 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Supposedly one managed to gather the following 7 pieces of 
% information regarding the aforementioned variables: 
% 
% (1) The measurements of the height a of the building are 
%       normally distributed with the average value Avg_a = 14 m 
%       and the standard deviation Std_a = 2 m. 
% 
%  (2) The width b of the building is between 5 m and 7 m. In 
%        other words, the width of the building can be described by 
%        'Avg_b' +- 'Error_b' = 6 m +- 1 m. 
% 
% (3) Similarly to the width of the building , the length c of the 
%       building is between 3.5 m and 4.5m. In other words, the 
%       length of the building can be described by 
%       'Avg_c' +- 'Error_c' = 4 m +- 0.5 m. 
% 
% (4) The average values inside temperature T_Inside and the 
%       outside temperature T_Outside, are 
%       'Avg_T_Inside' = 23 °C and 'Avg_T_Outside' = 13 °C, 
%       respectively. Both the T_Outside temperature and the 
%       T_ Inside temperature are assumed to be normally 
%       distributed with the values of the standard deviation 
%       'Std_T_Inside' = 2 °C and 'Std_T_Outside' = 9 °C, 
%       respectively. The two temperatures are also closely 
%       correlated, with the value of the correlation coefficient 
%       assumed to be 'Coeff' = 0.9. 
% 
% (5) 9 values of the thermal conductivity Lambda have been 
%       found on the internet, each claimed to be accurate: 
%       1.33 W / (m * K), 1.95 W / (m * K), 3 W / (m * K), 
%       1.4 W / (m * K), 1.61 W / (m * K), 1.21 W / (m * K), 
%       1.88 W / (m * K), 1.92 W / (m * K), and 1.31 W / (m * K). 
% 
% (6) The average value 'Avg_d' of the thickness d of the walls 
%       is 0.3 m and the value of the standard deviation 'Std_d' is 
%       0.1 m. The distribution of the thickness d of the walls is 
%       unknown otherwise but it cannot be assumed to be normal 
%       because that would imply negative thickness in some 
%       areas. That is why uniform distribution with the 
%       aforementioned average value and standard deviation 
%       value will be assumed. 
% 
% (7) Because only 10 trucks were used for the transport of 
%       concrete, each carrying 10 m^3 of concrete, the total 
%       volume V of the walls cannot be greater than 
%       10 * (10 m^3) = 100 m^3. 


%                                           Page 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% In this tutorial, the FindOutputVariableAvgStd function will be 
% used to determine the average value and the standard 
% deviation of both the rate of heat transfer P and the volume V 
% of the walls. 
% 
% The first order of business is to define the function f_Tutorial, 
% which returns the column vector 'Vec_f_Tutorial' of values 
% 'Value_P' and 'Value_V' if given the column vector 'Vec_Input' 
% of values 'Value_a', 'Value_b', 'Value_c', 'Value_T_Inside', 
% 'Value_T_Outside', 'Value_Lambda', and 'Value_d'. Such a 
% function can readily be found in this Tutorial folder (the 
% f_Tutorial.m function) . Open it to inspect it. 


%                                           Page 3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% To use the FindOutputVariableAvgStd function, the f_Tutorial 
% function needs to be imbedded inside a function which returns 
% the output vector of the f_Tutorial function appended by the 
% vector of integers 'Vec_Figure' and the 'Validity' number. 
% The 'Vec_Figure' contains information about whether or not 
% and in which figure windows the distributions of the output 
% variables of the f_Tutorial function are to be plotted and 
% compared to the normal distribution with the same average 
% values and the same standard deviation values. The 'Validity' 
% number gives information about which output vectors of the 
% f_Tutorial function are to be taken into account when 
% calculating the average values and the standard deviation 
% values of the output variables of the f_Tutorial function. 
% 
% Such a function can readily be found in this Tutorial folder  
% (the Ff_Tutorial.m function). Open it to inspect it. 
% 
% The 'FigureVector' is set so that the distribution of the rate of 
% heat transfer P, which is represented by the first value of the 
% f_Tutorial function output vector, is to be plotted in the figure 
% window 23, while the distribution of the volume V of the walls, 
% which is represented by the second value of the f_Tutorial 
% function output vector, is not to be plotted in any figure 
% window. This done by setting the 'Vec_Figure' vector to 
% 'Vec_Figure' = [23; 0]. 
% The 'Validity' number is set so that the output vector of the 
% f_Tutorial function is only valid if the volume of the walls is not 
% above 100 m^3, which was asserted on Page 2 of this 
% Tutorial. 


%                                           Page 4
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Finally, the function handle of the Ff_Tutorial need to be 
% defined. This is done in the line below. 

handle_Ff_Tutorial = @(x)Ff_Tutorial(x);

% It is important to note that there was no actual need to define 
% two separate functions. Instead of defining both the f_Tutorial 
% function and the Ff_Tutorial function, a single combined 
% function could be defined instead, such as the 
% f_TutorialCombined function, which can readily be found in 
% this Tutorial folder. Open it to inspect it. Its handle is defined in 
% the line below. 

handle_Ff_TutorialCombined = @(x)Ff_TutorialCombined(x);

% It would even be possible to use a function which would only 
% become properly defined by its handle. An example is the the 
% Ff_TutorialAlternative function, which can readily be found in 
% this Tutorial folder. Open it to inspect it. In this function, the 
% 'Vec_Figure' vector is not predefined but it can become so 
% by defining its function handle as shown in the two lines below. 

Vec_Figure =  [23; 0];
handle_Ff_TutorialAlternative = @(x)...
    Ff_TutorialAlternative(x, Vec_Figure); clear Vec_Figure;


% All three previous handles are equivalent and can be sued 
% interchangeably from this point on. The idea conveyed by this 
% page is that the function the handle of which is ultimately used 
% as the input of the FindOutputVariableAvgStd function is not 
% necessarily a conventionally defined function in the MATLAB 
% space but an abstract one. Notice how the 
% handle_Ff_TutorialAlternative function handle represents one 
% such abstract function, which happens to be equivalent to the 
% Ff_TutorialCombined function, which is formally defined by its 
% own file. The advantage with the handle_Ff_TutorialAlternative 
% function handle is that one can manipulate the 'Vec_Figure' 
% vector inside the MATLAB script file (in this case, the 
% Tuturial.m file). 
% In summary, the function handle given as the input to the 
% FindOutputVariableAvgStd function can be defined in 
% whichever way as long as the output of the function handle is 
% the vector which contains the values of the variables of 
% interest, followed by the integers which give information about 
% the plotting of the distribution of the individual aforementioned 
% variables of interest, and finally followed by the value which 
% determines the validity of the aforementioned variables of 
% interest as a whole by setting it to either 1 or 0. 


%                                           Page 5
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%