%% Clear workspace
clear;
close all;
clc;

%% Load data
load('tanks.mat')

%% Predefine figures
defaultFontSize = 18;

fig_1 = figure;
axes_1 = axes;
hold on; box on; grid on;
legend('Location','northeast');
x = xlabel('$t$[s]');
set(x, 'Interpreter', 'latex');
y = ylabel('$e_1,e_2$[m]');
set(y, 'Interpreter', 'latex');
title('Control errors', 'Interpreter', 'latex');
set(gca, 'FontSize', defaultFontSize);

fig_2 = figure;
axes_2 = axes;
hold on; box on; grid on;
legend('Location','southeast');
x = xlabel('$t$[s]');
set(x, 'Interpreter', 'latex');
y = ylabel('$u_1,u_2$[m$^3$/s]');
set(y, 'Interpreter', 'latex');
title('Control signals', 'Interpreter', 'latex');
set(gca, 'FontSize', defaultFontSize);

fig_3 = figure;
axes_3 = axes;
hold on; box on; grid on;
legend('Location','southeast');
x = xlabel('$t$[s]');
set(x, 'Interpreter', 'latex');
y = ylabel('$y^*_1,y^*_2$[m]');
set(y, 'Interpreter', 'latex');
title('Outputs', 'Interpreter', 'latex');
set(gca, 'FontSize', defaultFontSize);

%% Plot results
out = out_tanks;
readLogsoutData;

figure(1);
plot(axes_1, controlError1.Values.Time, controlError1.Values.Data, 'linewidth', 1.5, 'DisplayName', 'Tank 1 control error');
plot(axes_1, controlError2.Values.Time, controlError2.Values.Data, 'linewidth', 1.5, 'DisplayName', 'Tank 2 control error');

figure(2);
plot(axes_2, controlSignal1.Values.Time, controlSignal1.Values.Data, 'linewidth', 1.5, 'DisplayName', 'Tank 1 inlet flow');
plot(axes_2, controlSignal2.Values.Time, controlSignal2.Values.Data, 'linewidth', 1.5, 'DisplayName', 'Tank 2 inlet flow');

figure(3);
plot(axes_3, output1.Values.Time, output1.Values.Data, 'linewidth', 1.5, 'DisplayName', 'Tank 1 level');
plot(axes_3, output2.Values.Time, output2.Values.Data, 'linewidth', 1.5, 'DisplayName', 'Tank 2 level');
plot(axes_3, desiredOutput1.Values.Time, desiredOutput1.Values.Data, 'k--', 'linewidth', 1.5, 'DisplayName', 'Tank 1 reference level'); 
plot(axes_3, desiredOutput2.Values.Time, desiredOutput2.Values.Data, 'k-.', 'linewidth', 1.5, 'DisplayName', 'Tank 2 reference level');

%% Save figures

saveas(fig_1, 'simulation_procedures/tanks_control_error', 'epsc');
saveas(fig_2, 'simulation_procedures/tanks_control_signal', 'epsc');
saveas(fig_3, 'simulation_procedures/tanks_output', 'epsc');
