function frepresent = TestFunction(vec)
%TESTFUNCTION Summary of this function goes here
%   Detailed explanation goes here
par = LinearRegression(vec);
k=par(1);
n=par(2);
repk=1;
repn=1;
validity=1;
frepresent=[k;n;repk;repn;validity];

end

