controlError = get(out.logsout,'controlError');
output = get(out.logsout,'output');
desiredOutput = get(out.logsout,'desiredOutput');
controlSignal = get(out.logsout,'controlSignal');
pwmControl = get(out.logsout,'pwmControl');
referenceVoltage = get(out.logsout,'referenceVoltage');
outputVoltage = get(out.logsout,'outputVoltage');
loadResistance = get(out.logsout,'loadResistance');
noise = get(out.logsout,'noise');

% MIMO case (here: to inputs, two outputs)
controlError1 = get(out.logsout,'controlError1');
output1 = get(out.logsout,'output1');
desiredOutput1 = get(out.logsout,'desiredOutput1');
controlSignal1 = get(out.logsout,'controlSignal1');
controlError2 = get(out.logsout,'controlError2');
output2 = get(out.logsout,'output2');
desiredOutput2 = get(out.logsout,'desiredOutput2');
controlSignal2 = get(out.logsout,'controlSignal2');