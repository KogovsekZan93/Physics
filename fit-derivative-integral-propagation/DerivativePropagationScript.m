%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
xData = [0; 1; 3; 5; 8; 35; 37; 40; 45; 56; 57; 60; 66; 68];
yData = [10; 9; 8; 11; 13; 5; 4; 3; 2; 6; 11; 12; 2; 8];
del_xData = 0.2;
del_yData = 0.4;
ux = 2;
uy = 1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
xDerivative1 = ...
    [-5; -4; -3; -2; -1; 2; 4; 6; 7; 9; 10; 11; 12; 13; 14; 15; 16; 17; ...
    18; 19; 20; 21; 22; 23; 24; 25; 26; 27; 28; 29; 30; 31; 32; 33; 34; ...
    36; 38; 39; 41; 42; 43; 44; 46; 47; 48; 49; 50; 51; 52; 53; 54; 55; ...
    58; 59; 61; 62; 63; 64; 65; 67; 69; 70];
xDerivative2 = (linspace(-5, 70, 1000))';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
InputVariablesDistributionInfo = {{{xData, del_xData}, ux}, ...
{{yData, del_yData}, uy}};

Accuracy = 2;
FunctionHandle_FindDerivativePropagation1 = ...
    @(DataVector)FindDerivativePropagation...
    (DataVector, xDerivative1, 'Accuracy', Accuracy);
FunctionHandle_FindDerivativePropagation2 = ...
    @(DataVector)FindDerivativePropagation...
    (DataVector, xDerivative2, 'Accuracy', Accuracy);

N_Rnd = power(10, 3);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
AvgStd_f1 = FindOutputVariableAvgStd(InputVariablesDistributionInfo, ...
    FunctionHandle_FindDerivativePropagation1, N_Rnd);
AvgStd_f2 = FindOutputVariableAvgStd(InputVariablesDistributionInfo, ...
    FunctionHandle_FindDerivativePropagation2, N_Rnd);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1); clf; hold on;
errorbar(xDerivative1, AvgStd_f1(:, 1), AvgStd_f1(:, 2), ...
    'bx', 'MarkerSize', 10);
xlabel('x'); ylabel('yDerivative');
set(gca, 'FontSize', 14); grid on; hold off;

figure(2); clf; hold on;
Avg_yDerivative2 = AvgStd_f2(:, 1);
Std_y_Derivative2= AvgStd_f2(:, 2);
y_Plot_top = Avg_yDerivative2 + Std_y_Derivative2;
y_Plot_bottom = Avg_yDerivative2 - Std_y_Derivative2;
Area_Plot = fill([xDerivative2', fliplr(xDerivative2')], ...
    [y_Plot_bottom', fliplr(y_Plot_top')], 'b');
set(Area_Plot, 'facealpha', 0.5);
plot(xDerivative2, Avg_yDerivative2, 'k-', 'LineWidth', 1.5)
xlabel('x'); ylabel('yDerivative');
set(gca, 'FontSize', 14); grid on; hold off;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%