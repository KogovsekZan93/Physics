function DrawSimpleLinearRegressionGraph...
    (figr, x_Data, y_Data, slope, intercept, ...
    sigma_x_Data, sigma_y_Data, sigma_slope, sigma_intercept)


N = power(10, 4);

figure(figr);
hold on;

x_Plot =(linspace(min(x_Data), max(x_Data), N))';
y_Plot_Avg = x_Plot * slope + intercept;
sigma_y_Plot = sqrt(power(x_Plot * sigma_slope, 2) + ...
    power(sigma_intercept, 2));
y_Plot_top = y_Plot_Avg + sigma_y_Plot;
y_Plot_bottom = y_Plot_Avg - sigma_y_Plot;

figure(figr);
hold on;

Area_Plot = fill...
    ([x_Plot', fliplr(x_Plot')], [y_Plot_bottom', fliplr(y_Plot_top')], 'b');
set(Area_Plot, 'facealpha', 0.5);
errorbar(x_Data, y_Data,sigma_y_Data, 'ro');
herrorbar(x_Data, y_Data,sigma_x_Data,sigma_x_Data, 'ro');
plot(x_Plot, y_Plot_Avg, 'k-', 'LineWidth', 1.5)

grid on;
set(gca,'fontsize',14)
hold off;

end