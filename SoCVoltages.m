% Given or Simulated SoC vs OCV data (Replace with actual values)
SoC = [0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1]; 
OCV = [3.0, 3.4, 3.6, 3.7, 3.75, 3.8, 3.85, 3.9, 4.0, 4.1, 4.2]; % Example values

% Fit a polynomial of degree 7 (you can change the degree if needed)
poly_degree = 7;
p = polyfit(SoC, OCV, poly_degree);

% Generate fitted OCV values
SoC_fit = linspace(0, 1, 100); % Create smooth range for plotting
OCV_fit = polyval(p, SoC_fit);

% Display the polynomial equation
disp('Fitted Polynomial Equation (OCV as a function of SoC):');
disp(poly2sym(p));

% Plot the results
figure;
plot(SoC, OCV, 'ro', 'MarkerSize', 8, 'LineWidth', 2); hold on; % Original data points
plot(SoC_fit, OCV_fit, 'b-', 'LineWidth', 2); % Fitted curve
xlabel('State of Charge (SoC)');
ylabel('Open Circuit Voltage (OCV)');
title('OCV vs SoC Polynomial Fit');
legend('Original Data', 'Polynomial Fit');
grid on;