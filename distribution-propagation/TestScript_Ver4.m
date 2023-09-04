x=[0;1;2;3];
R = [1, 0.2, 0.1, 0.4; 0.2, 2, 0.3, 0.5; 0.1, 0.3, 3, 1; 0.4, 0.5, 1, 5];
delx=ones(length(x), 1) * 0.2; 
ux=1;
y=[0;3;5;9];
dely=ones(length(y),1)*0.4;
FunTestFunction=@(vec)TestFunction(vec);
VARIABLES={{{x, delx(1)}, ux},{y, R}};
n=power(10,5);
[avg_f, CovarMatrix]=FindOutputVariableAvgCovarMat(VARIABLES,FunTestFunction,n);

k=avg_f(1);
delk=CovarMatrix(1,1);
n=avg_f(2);
deln=CovarMatrix(2,2);
% sqrt(diag(CovarMatrix))

figr=3;
figure(figr);
clf;

DrawSimpleLinearRegressionGraph(figr,x,y,k,n,delx,diag(R), CovarMatrix)

k
n
CovarMatrix