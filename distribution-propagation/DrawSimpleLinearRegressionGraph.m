function DrawSimpleLinearRegressionGraph...
    (figr, x_Data, y_Data, Slope, Intercept, ...
    sigma_x_Data, sigma_y_Data, CovarMat_SlopeIntercept)


N = power(10, 4);

figure(figr);
hold on;

x_Plot =(linspace(min(x_Data), max(x_Data), N))';
y_Plot_Avg = x_Plot * Slope + Intercept;
sigma_y_Plot = sqrt(...
    power(x_Plot, 2) * CovarMat_SlopeIntercept(1, 1) + ...
    CovarMat_SlopeIntercept(2, 2) + ...
    2 * x_Plot * CovarMat_SlopeIntercept(1, 2));
y_Plot_top = y_Plot_Avg + sigma_y_Plot;
y_Plot_bottom = y_Plot_Avg - sigma_y_Plot;

figure(figr);
hold on;

Area_Plot = fill...
    ([x_Plot', fliplr(x_Plot')], [y_Plot_bottom', fliplr(y_Plot_top')], 'b');
set(Area_Plot, 'facealpha', 0.5);
errorbar(x_Data, y_Data,sigma_y_Data, 'ro');
GetHorizontalErrorbar...
    (x_Data, y_Data,sigma_x_Data,sigma_x_Data, 'ro');
plot(x_Plot, y_Plot_Avg, 'k-', 'LineWidth', 1.5)

grid on;
set(gca,'fontsize',14)
hold off;

end