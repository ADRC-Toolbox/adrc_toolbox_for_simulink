%% Clear workspace
clear;
close all;
clc;

%% Load data
load('tclab.mat')

%% Predefine figures
defaultFontSize = 18;

fig_1 = figure;
axes_1 = axes;
hold on; box on; grid on;
legend('Location','northeast');
x = xlabel('$t$[s]');
set(x, 'Interpreter', 'latex');
y = ylabel('$e_1,e_2$[$^\circ$C]');
set(y, 'Interpreter', 'latex');
title('Control errors', 'Interpreter', 'latex');
set(gca, 'FontSize', defaultFontSize);

fig_2 = figure;
axes_2 = axes;
hold on; box on; grid on;
legend('Location','southeast');
x = xlabel('$t$[s]');
set(x, 'Interpreter', 'latex');
y = ylabel('$u_1,u_2$');
set(y, 'Interpreter', 'latex');
title('Control signals', 'Interpreter', 'latex');
set(gca, 'FontSize', defaultFontSize);

fig_3 = figure;
axes_3 = axes;
hold on; box on; grid on;
legend('Location','southeast');
x = xlabel('$t$[s]');
set(x, 'Interpreter', 'latex');
y = ylabel('$y_1,y_2$[$^\circ$C]');
set(y, 'Interpreter', 'latex');
title('Outputs', 'Interpreter', 'latex');
set(gca, 'FontSize', defaultFontSize);

%% Plot results
out = out_tclab;
readLogsoutData;

figure(1);
plot(axes_1, controlError1.Values.Time, controlError1.Values.Data, 'linewidth', 1.5, 'DisplayName', 'Heater 1 control error');
hold on
plot(axes_1, controlError2.Values.Time, controlError2.Values.Data, 'linewidth', 1.5, 'DisplayName', 'Heater 2 control error');

figure(2);
plot(axes_2, controlSignal1.Values.Time, controlSignal1.Values.Data, 'linewidth', 1.5, 'DisplayName', 'Heater 1 PWM');
hold on 
plot(axes_2, controlSignal2.Values.Time, controlSignal2.Values.Data, 'linewidth', 1.5, 'DisplayName', 'Heater 2 PWM');

figure(3);
plot(axes_3, output1.Values.Time, output1.Values.Data, 'linewidth', 1.5, 'DisplayName', 'Heater 1 temperature');
plot(axes_3, output2.Values.Time, output2.Values.Data, 'linewidth', 1.5, 'DisplayName', 'Heater 2 temperature');
plot(axes_3, desiredOutput1.Values.Time, desiredOutput1.Values.Data, 'k--', 'linewidth', 1.5, 'DisplayName', 'Heater 1 reference temperature'); 
plot(axes_3, desiredOutput2.Values.Time, desiredOutput2.Values.Data, 'k-.', 'linewidth', 1.5, 'DisplayName', 'Heater 2 reference temperature');

%% Save figures

saveas(fig_1, 'simulation_procedures/tclab_control_error', 'epsc');
saveas(fig_2, 'simulation_procedures/tclab_control_signal', 'epsc');
saveas(fig_3, 'simulation_procedures/tclab_output', 'epsc');