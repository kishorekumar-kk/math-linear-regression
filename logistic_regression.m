% Identify optimal value of intercept and slope
% Inputs
syms m_intercept m_slope
data = readmatrix("https://raw.githubusercontent.com/kishorekumar-kk/assignment/master/olympic-data.csv");
x = data(:,1);
finish_times_m = data(:,2);
% Using fit method to draw optimal straight line
coefficients = polyfit(x, finish_times_m, 1);
xFit = linspace(min(x), max(x), 2000);
yFit = polyval(coefficients, xFit);

% Find value of intercept and slope by analytical approach
fprintf('Analytical approach\n')
[line_params, min_loss] = fminsearch(@(v) loss_function(v(1), v(2), x, finish_times_m), [-100,-100]);
intercept = line_params(1);
slope = line_params(2);
% Display the minimum values of x and y and the minimum value of the function
fprintf('Average loss is minimum when intercept and slope: %f, %f\n', intercept, slope);
fprintf('Minimum average loss by analytical approach is: %f\n', min_loss);
analytical_result_y = line_function(intercept, slope, x);

% Find value of intercept and slope by mathematical approach
fprintf('\nMathematical approach\n')
f_loss(m_intercept, m_slope) = mean((finish_times_m - m_intercept - (m_slope*x)).^2);
dloss_dintercept = diff(f_loss, m_intercept);
dloss_dslope = diff(f_loss, m_slope);
e = [mean(dloss_dintercept) == 0, mean(dloss_dslope) == 0];
ax = solve(e, m_intercept, m_slope);
intercept = double(ax.m_intercept);
slope = double(ax.m_slope);
fprintf('Derived Mathematical approach: intercept and slope: %f, %f\n', intercept, slope);


% Calculation of params
fprintf('\nDirect substitution\n')
average_x = mean(x);
average_finish_times = mean(finish_times_m);
xt = mean(x.*finish_times_m);
x_2 = mean(x.*x);

slope = (xt - (average_x*average_finish_times)) / (x_2 - (average_x.*average_x));
intercept = average_finish_times - (slope*average_x);
fprintf('From direct substitution intercept and slope: %f, %f\n', intercept, slope);
predicted_y = line_function(intercept, slope, x);

average_loss = loss_function(intercept, slope, x, finish_times_m);
fprintf('Minimum average loss by direct substituition is: %f\n', average_loss);

plot(x, finish_times_m,'red.', 'MarkerSize',12);
hold on;
plot(xFit, yFit, 'm-', 'LineWidth', 2);
hold on;
plot(x, predicted_y,'blackx', 'MarkerSize',12);
hold on;
plot(x, analytical_result_y,'green.', 'MarkerSize',12);
legend('actual','fit method', 'direct sub', 'analytical');