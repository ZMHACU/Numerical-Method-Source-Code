function filtered_voltages = ekf_voltage_filtering()
    % Define system parameters
    R0 = 0.0013;
    R1 = 0.0042;
    R2 = 0.0024;
    C1 = 17111;
    C2 = 440.57;
    eta = 1; % Coulomb efficiency

    % OCV-SOC table (from your data)
    SOC = [1.0000; 0.9503; 0.9007; 0.8510; 0.8013; 0.7517; 0.7020; 0.6524; 0.6027; 0.5530; 
           0.5034; 0.4537; 0.4040; 0.3543; 0.3046; 0.2550; 0.2053; 0.1556; 0.1059; 0.0563];
    OCV = [4.1617; 4.0913; 4.0749; 4.0606; 4.0153; 3.9592; 3.9164; 3.8687; 3.8163; 3.7735; 
           3.7317; 3.6892; 3.6396; 3.5677; 3.5208; 3.4712; 3.3860; 3.2880; 3.2037; 3.0747];

    % Interpolate OCV-SOC relationship
    ocv_soc_fit = fit(SOC, OCV, 'linearinterp');

    % Initial state [v1; v2; SOC]
    x = [0; 0; 0.5]; % Initial guess for v1, v2, SOC
    P = eye(3) * 0.1; % Initial state covariance

    % Process noise covariance
    Q = diag([1e-6, 1e-6, 1e-8]); % Adjust based on system noise

    % Measurement noise covariance
    R = 0.0001; % Adjust based on sensor noise

    % Simulated voltage measurements (replace with real sensor data)
    voltage_measurements = OCV + randn(size(OCV)) * sqrt(R); % Noisy OCV measurements

    % Time step
    dt = 1; % Adjust based on your sampling rate

    % Store filtered voltages
    filtered_voltages = zeros(size(voltage_measurements));

    % EKF loop
    for k = 1:length(voltage_measurements)
        % Current measurement
        measured_voltage = voltage_measurements(k);

        % --- Predict Step ---
        [x_pred, F] = state_transition(x, 0, dt, R1, C1, R2, C2, eta); % No input current (u = 0)
        P_pred = F * P * F' + Q;

        % --- Update Step ---
        [y_pred, H] = measurement_model(x_pred, ocv_soc_fit);
        y_residual = measured_voltage - y_pred;
        S = H * P_pred * H' + R;
        K = P_pred * H' / S;

        x = x_pred + K * y_residual;
        P = (eye(3) - K * H) * P_pred;

        % Store filtered voltage (v1 + v2 + OCV)
        filtered_voltages(k) = x(1) + x(2) + ocv_soc_fit(x(3));
    end

    % Display Filtered Voltages in Command Window
    disp('Filtered Voltages (After EKF Noise Reduction):');
    disp(filtered_voltages);
end

%% --- State Transition Function (Nonlinear Model) ---
function [x_pred, F] = state_transition(x, u, dt, R1, C1, R2, C2, eta)
    v1 = x(1);
    v2 = x(2);
    soc = x(3);

    % Nonlinear state transition
    dv1 = (u / C1) - (v1 / (R1 * C1));
    dv2 = (u / C2) - (v2 / (R2 * C2));
    dsoc = -eta * u;

    x_pred = [v1 + dv1 * dt;
              v2 + dv2 * dt;
              soc + dsoc * dt];

    % Jacobian of state transition (Linearized)
    F = [1 - dt / (R1 * C1), 0, 0;
         0, 1 - dt / (R2 * C2), 0;
         0, 0, 1];
end

%% --- Measurement Function (Nonlinear Model) ---
function [y_pred, H] = measurement_model(x, ocv_soc_fit)
    v1 = x(1);
    v2 = x(2);
    soc = x(3);

    % Nonlinear measurement model
    ocv = ocv_soc_fit(soc); % Get OCV from SOC using the fitted curve
    y_pred = v1 + v2 + ocv; % Example measurement model

    % Jacobian of measurement model (Linearized)
    H = [1, 1, 0]; % Partial derivatives of y_pred w.r.t. [v1, v2, soc]
end
