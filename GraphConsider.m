clc; clear; close all;

% Data dari tabel pertama
U_ocv_1 = [4.1617, 4.0913, 4.0749, 4.0606, 4.0153, 3.9592, 3.9164, 3.8687, 3.8163, 3.7735, 3.7317, 3.6892, 3.6396, 3.5677, 3.5208, 3.4712, 3.3860, 3.2880, 3.2037, 3.0747];
SOC_1 = [100, 95.03, 90.07, 85.10, 80.13, 75.17, 70.20, 65.24, 60.27, 55.30, 50.34, 45.37, 40.40, 35.43, 30.46, 25.50, 20.53, 15.56, 10.59, 5.63];

% Data dari tabel kedua
E0_SOC_EKF_1 = [4.1617, 4.0913, 4.0749, 4.0606, 4.0153, 3.9592, 3.9164, 3.8687, 3.8163, 3.7735, 3.7317, 3.6892, 3.6396, 3.5677, 3.5208, 3.4712, 3.3860, 3.2880, 3.2037, 3.0747];
SOC_EKF_1 = [103.088890, 99.748493, 98.410511, 96.728770, 83.928085, 75.808053, 71.194115, 66.346354, 60.875186, 56.084637, 51.142761, 46.124586, 40.720016, 34.028527, 30.243020, 26.578111, 20.839430, 14.962672, 10.669390, 5.665093];

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
