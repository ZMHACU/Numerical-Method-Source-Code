clc; clear; close all;

% Data dari tabel pertama
U_ocv_1 = [4.1617, 4.0913, 4.0749, 4.0606, 4.0153, 3.9592, 3.9164, 3.8687, 3.8163, 3.7735, 3.7317, 3.6892, 3.6396, 3.5677, 3.5208, 3.4712, 3.3860, 3.2880, 3.2037, 3.0747];
SOC_1 = [100, 95.03, 90.07, 85.10, 80.13, 75.17, 70.20, 65.24, 60.27, 55.30, 50.34, 45.37, 40.40, 35.43, 30.46, 25.50, 20.53, 15.56, 10.59, 5.63];

% Data dari tabel kedua
E0_SOC_EKF_1 = [4.1617, 4.0913, 4.0749, 4.0606, 4.0153, 3.9592, 3.9164, 3.8687, 3.8163, 3.7735, 3.7317, 3.6892, 3.6396, 3.5677, 3.5208, 3.4712, 3.3860, 3.2880, 3.2037, 3.0747];
SOC_EKF_1 = [102.971286, 99.598969, 98.273589, 96.609964, 83.563460, 75.670151, 71.050041, 66.224239, 60.658650, 55.910895, 50.939415, 45.963723, 40.556700, 33.952234, 30.181458, 26.528364, 20.788291, 14.912721, 10.637178, 5.616915];

% Plot kedua grafik dalam satu figure
figure;
hold on;
plot(SOC_1, U_ocv_1, 'ro-', 'LineWidth', 2, 'DisplayName', 'U_{ocv} vs SOC');
plot(SOC_EKF_1, E0_SOC_EKF_1, 'b*-', 'LineWidth', 2, 'DisplayName', 'E_0(SOC)_{EKF} vs SOC_{EKF}');

% Format plot
xlabel('State of Charge (SOC) (%)');
ylabel('Open Circuit Voltage (U_{ocv}) / E_0(SOC)');
title('Perbandingan Grafik U_{ocv} dan E_0(SOC)_{EKF}');
legend('Location', 'best');
grid on;
hold off;
