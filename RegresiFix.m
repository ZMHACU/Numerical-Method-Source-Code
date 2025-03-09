% Data dari grafik
SoC = [5.63 10.59 15.56 20.53 25.50 30.46 35.43 40.40 45.37 50.34 55.30 60.27 65.24 70.20 75.17 80.13 85.10 90.07 95.03 100];
OCV = [3.074 3.2037 3.2880 3.3860 3.4712 3.5208 3.5677 3.6396 3.6892 3.7317 3.7735 3.8163 3.8687 3.9164 3.9592 4.0153 4.0606 4.0749 4.0913 4.1617];


% Melakukan fitting polinomial orde 7
poly_coeffs = polyfit(SoC, OCV, 7);

% Fungsi untuk menghitung OCV dari SoC
ocv_from_soc = @(x) polyval(poly_coeffs, x);

% Contoh penggunaan
soc_test = 55; % Contoh SoC% yang ingin dihitung
ocv_result = ocv_from_soc(soc_test);

% Menampilkan hasil
fprintf('OCV untuk SoC %d%% adalah %.4f V\n', soc_test, ocv_result);

% Membuat grafik
SoC_fine = linspace(0, 100, 1000); % Membuat titik-titik halus untuk plot
OCV_fine = ocv_from_soc(SoC_fine);

figure;
plot(SoC, OCV, 'bo', 'MarkerSize', 8, 'DisplayName', 'Original Data'); % Data asli
grid on;
hold on;
plot(SoC_fine, OCV_fine, 'r-', 'LineWidth', 2, 'DisplayName', 'Polynomial Fit (Order 7)'); % Kurva polinomial
xlabel('State of Charge (SoC%)');
ylabel('Open Circuit Voltage (OCV V)');
title('Polynomial Regression Order 7 for OCV vs SoC');
legend;
hold off;