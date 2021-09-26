%% Clear workspace
clear;
close all;
clc;

%% Load data
load('dc_motor_data.mat')
controlSignal = get(data,'controlSignal');
position = get(data,'position');
velocity = get(data,'velocity');
controlError = get(data,'controlError');
desiredVelocity = get(data,'desiredVelocity');

%% Predefine figures
defaultFontSize = 18;

fig_1 = figure;
axes_1 = axes;
hold on; box on; grid on;
x = xlabel('$t$[s]');
set(x, 'Interpreter', 'latex');
y = ylabel('$e$[imp/s]');
set(y, 'Interpreter', 'latex');
title('Control error', 'Interpreter', 'latex');
set(gca, 'FontSize', defaultFontSize);

fig_2 = figure;
axes_2 = axes;
hold on; box on; grid on;
x = xlabel('$t$[s]');
set(x, 'Interpreter', 'latex');
y = ylabel('$u$');
set(y, 'Interpreter', 'latex');
title('Control signal', 'Interpreter', 'latex');
set(gca, 'FontSize', defaultFontSize);

fig_3 = figure;
axes_3 = axes;
hold on; box on; grid on;
legend('Location','southeast');
x = xlabel('$t$[s]');
set(x, 'Interpreter', 'latex');
y = ylabel('$y^*$[imp/s]');
set(y, 'Interpreter', 'latex');
title('Output', 'Interpreter', 'latex');
set(gca, 'FontSize', defaultFontSize);

%% Plot results for no measurements
figure(1);
plot(axes_1, controlError.Values.Time, reshape(controlError.Values.Data,[2001,1]), 'linewidth', 1.5);
figure(2);
plot(axes_2, controlSignal.Values.Time, controlSignal.Values.Data, 'linewidth', 1.5);
figure(3);
plot(axes_3, velocity.Values.Time, reshape(velocity.Values.Data, [2001,1]), 'linewidth', 1.5, 'DisplayName', 'Output voltage');
plot(axes_3, desiredVelocity.Values.Time, desiredVelocity.Values.Data, 'k--', 'linewidth', 1.5, 'DisplayName', 'Reference voltage');
%% Save figures
saveas(fig_1, 'simulation_procedures/dc_motor_control_error', 'epsc');
saveas(fig_2, 'simulation_procedures/dc_motor_control_signal', 'epsc');
saveas(fig_3, 'simulation_procedures/dc_motor_output', 'epsc');