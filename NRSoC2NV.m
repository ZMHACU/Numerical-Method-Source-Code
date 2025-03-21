clc; clear; close all;

% Definisikan koefisien polinomial orde 7
coeffs = [8.905e-13 -3.129e-10 4.378e-8 -3.139e-6 1.252e-4 -2.944e-3 5.444e-2 2.841];

% Nilai OCV dalam fungsi SoC yang diketahui
y = 3.9580;

% Definisikan fungsi P(x)
syms x;
P = poly2sym(coeffs, x);  % Konversi ke fungsi simbolik
P_numeric = matlabFunction(P); % Konversi ke fungsi numerik
P_deriv = diff(P, x); % Turunan P(x)
P_deriv_numeric = matlabFunction(P_deriv); % Konversi ke fungsi numerik

% Rentang x untuk plot (0 hingga 100)
x_range = linspace(0, 100, 1000);
y_vals = P_numeric(x_range);

% Tebakan awal (pilih nilai dalam rentang 0-100)
x0 = 50;  
tol = 1e-6;
max_iter = 100;
solusi_ditemukan = false; % Flag untuk menandai keberhasilan

% Simpan iterasi untuk plotting
x_iters = x0;
y_iters = P_numeric(x0);

% Tampilkan header tabel di Command Window
fprintf('Iterasi |      x       |     P(x)      |    P''(x)     |  |P(x) - y|   | Perubahan x |\n');
fprintf('---------------------------------------------------------------------------------------\n');

% Metode Newton-Raphson
for i = 1:max_iter
    P_x0 = P_numeric(x0);
    P_deriv_x0 = P_deriv_numeric(x0);
    error = abs(P_x0 - y);  % Selisih antara P(x) dan y
    
    % Hindari pembagian dengan nol
    if abs(P_deriv_x0) < 1e-10
        fprintf('Turunan mendekati nol pada iterasi ke-%d. Metode gagal.\n', i);
        break;
    end
    
    % Iterasi Newton-Raphson untuk mencari x_n+1
    x1 = x0 - (P_x0 - y) / P_deriv_x0;
    
    % Simpan hasil iterasi
    x_iters = [x_iters, x1];
    y_iters = [y_iters, P_numeric(x1)];
    
    % Tampilkan hasil tiap iterasi di Command Window
    fprintf('%7d | %10.6f | %12.6f | %12.6f | %12.6f | %12.6f |\n', ...
            i, x0, P_x0, P_deriv_x0, error, abs(x1 - x0));

    % Cek konvergensi
    if abs(x1 - x0) < tol
        fprintf('\nSolusi ditemukan: x = %.6f setelah %d iterasi\n', x1, i);
        solusi_ditemukan = true;
        break;
    end
    
    % Update nilai x
    x0 = x1;
end

% Jika metode tidak menemukan solusi setelah iterasi maksimal
if ~solusi_ditemukan
    fprintf('\nMetode tidak konvergen setelah %d iterasi.\n', max_iter);
end

% Plot fungsi polinomial P(x)
figure;
plot(x_range, y_vals, 'b', 'LineWidth', 2); hold on;
yline(y, '--k', 'LineWidth', 1.5); % Garis y = 4.0606

% Plot titik-titik iterasi Newton-Raphson
scatter(x_iters, y_iters, 100, 'ro', 'filled'); % Titik iterasi
plot(x_iters, y_iters, 'r-', 'LineWidth', 1.5); % Garis penghubung iterasi

% Tambahkan anotasi pada titik iterasi
for k = 1:length(x_iters)
    text(x_iters(k), y_iters(k), sprintf('  x_{%d}', k-1), 'FontSize', 12, 'Color', 'red');
end

% Atur skala sumbu
xlim([0, 100]); % Batasi sumbu x antara 0 dan 100
ylim([min(y_vals)*0.9, max(y_vals)*1.1]); % Sesuaikan skala sumbu y
xlabel('SoC (%)');
ylabel('OCV');
title(sprintf('Iterasi Newton-Raphson untuk P(x) dengan OCV = %.4f', y));
legend('P(x)', sprintf('y = %.4f', y), 'Iterasi Newton-Raphson', 'Location', 'best');
grid on;
hold off;
