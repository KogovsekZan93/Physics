%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
xData = [0; 1; 3; 5; 8; 35; 37; 40; 45; 56; 57; 60; 66; 68];
yData = [10; 9; 8; 11; 13; 5; 4; 3; 2; 6; 11; 12; 2; 8];
del_xData = 0.2;
del_yData = 0.4;
ux = 2;
uy = 1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
xMissing1 = ...
    [-5; -4; -3; -2; -1; 2; 4; 6; 7; 9; 10; 11; 12; 13; 14; 15;16; 17; ...
    18; 19; 20; 21; 22; 23; 24; 25; 26; 27; 28; 29; 30; 31; 32; 33; 34; ...
    36; 38; 39; 41; 42; 43; 44; 46; 47; 48; 49; 50; 51; 52; 53; 54; 55; ...
    58; 59; 61; 62; 63; 64; 65; 67; 69; 70];
xMissing2 = (linspace(-5, 70, 1000))';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
InputVariablesDistributionInfo = {{{xData, del_xData}, ux}, ...
{{yData, del_yData}, uy}};

PseudoAccuracy = 2;
FunctionHandle_FindFitPropagation1 = @(DataVector)FindFitPropagation...
    (DataVector, xMissing1, 'PseudoAccuracy', PseudoAccuracy);
FunctionHandle_FindFitPropagation2 = @(DataVector)FindFitPropagation...
    (DataVector, xMissing2, 'PseudoAccuracy', PseudoAccuracy);

N_Rnd = power(10, 3);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
AvgStd_f1 = FindOutputVariableAvgStd(InputVariablesDistributionInfo, ...
    FunctionHandle_FindFitPropagation1, N_Rnd);
AvgStd_f2 = FindOutputVariableAvgStd(InputVariablesDistributionInfo, ...
    FunctionHandle_FindFitPropagation2, N_Rnd);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1); clf; hold on;
plot(xData, yData, 'ro', 'MarkerSize', 10);
errorbar(xMissing1, AvgStd_f1(:, 1), AvgStd_f1(:, 2), ...
    'bo', 'MarkerSize', 10);
xlabel('x'); ylabel('y'); legend('Data points', ...
    'Points estimated using ZFindFit function');
set(gca, 'FontSize', 14); grid on; hold off;

figure(2); clf; hold on;
Avg_yMissing2 = AvgStd_f2(:, 1);
Std_yMissing2= AvgStd_f2(:, 2);
y_Plot_top = Avg_yMissing2 + Std_yMissing2;
y_Plot_bottom = Avg_yMissing2 - Std_yMissing2;
Area_Plot = fill([xMissing2', fliplr(xMissing2')], ...
    [y_Plot_bottom', fliplr(y_Plot_top')], 'b');
set(Area_Plot, 'facealpha', 0.5);
plot(xMissing2, Avg_yMissing2, 'k-', 'LineWidth', 1.5)
xlabel('x'); ylabel('y');
plot(xData, yData, 'ro', 'MarkerSize', 10);
set(gca, 'FontSize', 14); grid on; hold off;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%