%% Clear workspace
clear;
close all;
clc;

%% Load data
load('simple_example.mat')

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
ylim([-150 150]);
set(gca, 'FontSize', defaultFontSize);

fig_3 = figure;
axes_3 = axes;
hold on; box on; grid on;
legend;
x = xlabel('$t$[s]');
set(x, 'Interpreter', 'latex');
y = ylabel('$y$');
set(y, 'Interpreter', 'latex');
title('Output');
set(gca, 'FontSize', defaultFontSize);

%% Plot results for no measurements
out = out_no_noise_no_saturation;
readLogsoutData;

plot(axes_1, controlError.Values.Time, controlError.Values.Data, 'linewidth', 1.5);
figure(2);
plot(axes_2, controlSignal.Values.Time, controlSignal.Values.Data, 'linewidth', 1.5);
figure(3);
plot(axes_3, output.Values.Time, output.Values.Data, 'linewidth', 1.5, 'DisplayName', 'S1');

out = out_no_noise_saturation;
readLogsoutData;

figure(1);
plot(axes_1, controlError.Values.Time, controlError.Values.Data,'linewidth',1.5);
figure(2);
plot(axes_2, controlSignal.Values.Time, controlSignal.Values.Data,'linewidth',1.5);
figure(3);
plot(axes_3, output.Values.Time, output.Values.Data,'linewidth',1.5, 'DisplayName', 'S2');
plot(axes_3, desiredOutput.Values.Time, desiredOutput.Values.Data,'k--', 'linewidth', 1.5, 'DisplayName', 'Desired output'); 

%% Save figures
saveas(fig_1,'simulation_procedures/no_noise_no_saturation_control_error', 'epsc');
saveas(fig_2,'simulation_procedures/no_noise_no_saturation_control_signal', 'epsc');
saveas(fig_3,'simulation_procedures/no_noise_no_saturation_output', 'epsc');