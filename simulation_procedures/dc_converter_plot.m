%% Clear workspace
clear;
close all;
clc;

%% Load data
load('dc_converter.mat')

%% Predefine figures
defaultFontSize = 18;

fig_1 = figure;
axes_1 = axes;
hold on; box on; grid on;
x = xlabel('$t$[s]');
set(x, 'Interpreter', 'latex');
y = ylabel('$e$');
set(y, 'Interpreter', 'latex');
title('Control error');
set(gca, 'FontSize', defaultFontSize);

fig_2 = figure;
axes_2 = axes;
hold on; box on; grid on;
x = xlabel('$t$[s]');
set(x, 'Interpreter', 'latex');
y = ylabel('$u$');
set(y, 'Interpreter', 'latex');
title('Control signal');
set(gca, 'FontSize', defaultFontSize);

fig_3 = figure;
axes_3 = axes;
hold on; box on; grid on;
legend('Location','southeast');
x = xlabel('$t$[s]');
set(x, 'Interpreter', 'latex');
y = ylabel('$y$');
set(y, 'Interpreter', 'latex');
title('Output');
set(gca, 'FontSize', defaultFontSize);

fig_4 = figure;
axes_4 = axes;
hold on; box on; grid on;
x = xlabel('$t$[s]');
set(x, 'Interpreter', 'latex');
y = ylabel('$R_L$[$\Omega$]');
set(y, 'Interpreter', 'latex');
title('Load resistance');
set(gca, 'FontSize', defaultFontSize);

fig_5 = figure;
axes_5 = axes;
hold on; box on; grid on;
x = xlabel('$t$[s]');
set(x, 'Interpreter', 'latex');
y = ylabel('$y$');
set(y, 'Interpreter', 'latex');
title('PWM control signal');
set(gca, 'FontSize', defaultFontSize);
xlim([0 0.006]);
ylim([-0.2, 1.2]);

%% Plot results for no measurements
readLogsoutData;

figure(1);
plot(axes_1, controlError.Values.Time, controlError.Values.Data, 'linewidth', 1.5);
figure(2);
plot(axes_2, controlSignal.Values.Time, controlSignal.Values.Data, 'linewidth', 1.5);
figure(3);
plot(axes_3, outputVoltage.Values.Time, outputVoltage.Values.Data, 'linewidth', 1.5, 'DisplayName', 'Output voltage');
plot(axes_3, referenceVoltage.Values.Time, referenceVoltage.Values.Data, 'k--', 'linewidth', 1.5, 'DisplayName', 'Reference voltage');
figure(4);
plot(axes_4, loadResistance.Values.Time, loadResistance.Values.Data, 'linewidth', 1.5)
figure(5);
plot(axes_5, pwmControl.Values.Time, pwmControl.Values.Data, 'linewidth', 1.5)

%% Save figures
saveas(fig_1, 'simulation_procedures/dc_converter_control_error', 'epsc');
saveas(fig_2, 'simulation_procedures/dc_converter_control_signal', 'epsc');
saveas(fig_3, 'simulation_procedures/dc_converter_output', 'epsc');
saveas(fig_4, 'simulation_procedures/dc_converter_load_resistance', 'epsc');
saveas(fig_5,'simulation_procedures/dc_converter_pwm_control', 'epsc');