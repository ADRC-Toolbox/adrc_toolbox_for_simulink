close all;

readLogsoutData;
figure;
% semilogy(controlError.Values.Time, abs(controlError.Values.Data),'linewidth',1.5);
plot(controlError.Values.Time, (controlError.Values.Data),'linewidth',1.5);
grid on; box on; hold on;
xlabel('t[s]');
ylabel('control error');

