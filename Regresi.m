% Data dari grafik
SoC = [0 10 20 30 40 50 60 70 80 90 100];
OCV = [3.00 3.25 3.40 3.50 3.65 3.75 3.85 3.95 4.05 4.10 4.15];

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
