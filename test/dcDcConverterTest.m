classdef dcDcConverterTest < matlab.unittest.TestCase
    properties
        maskObj
        results
    end
    
    methods(TestClassSetup)
        function initializeDcDcConverter(testCase)
            load_system('dc_dc_converter');
            testCase.maskObj = Simulink.Mask.get('dc_dc_converter/ADRC controller');
            testCase.results = sim('dc_dc_converter');
        end
    end
    
    methods(TestClassTeardown)
        function closeDcDcConverter(testCase)
            close_system('dc_dc_converter', 0);
        end
    end
    
    methods (Test)
        %% Results
        function testFinalControlErrorValue(testCase)
            controlError = get(testCase.results.logsout, 'controlError');
            lastSecondSamples = controlError.Values.Time > controlError.Values.Time(end) - 0.1;
            meanFinalControlError = sum(abs(controlError.Values.Data) .* lastSecondSamples) / sum(lastSecondSamples);
            maxMeanFinalControlError = 0.025;
            
            testCase.verifyLessThan(meanFinalControlError, maxMeanFinalControlError)
        end
        
        function testSaturation(testCase)
            controlSignal = get(testCase.results.logsout, 'controlSignal');
            maxControlSignal = max(controlSignal.Values.Data);
            minControlSignal = min(controlSignal.Values.Data);
            controlSignalUpperLimit = 1;
            controlSignalLowerLimit = 0;
            

            testCase.verifyLessThanOrEqual(maxControlSignal, controlSignalUpperLimit);
            testCase.verifyGreaterThanOrEqual(minControlSignal, controlSignalLowerLimit);
        end
        
        %% Default mask values
        function testDefaultDynamicsOrder(testCase)
            dynamicsOrderParameter = str2double(testCase.maskObj.getParameter('dynamicsOrder').Value);
            defaultDynamicsOrder = 2;
            
            testCase.verifyEqual(dynamicsOrderParameter, defaultDynamicsOrder);
        end
        
        function testDefaultInputGainValue(testCase)
            inputGainValue = str2double(testCase.maskObj.getParameter('inputGainParameter').Value);
            defaultInputGain = 2e06;
            
            testCase.verifyEqual(inputGainValue, defaultInputGain);
        end
        
        function testDefaultInputGainSource(testCase)
            inputGainSource = testCase.maskObj.getParameter('inputGainSource').Value;
            defaultInputGainSource = 'Internal';
            
            testCase.verifyEqual(inputGainSource, defaultInputGainSource);
        end
        
        function testDefaultObserverBandwidth(testCase)
            observerBandwidth = str2double(testCase.maskObj.getParameter('observerBandwidth').Value);
            defaultObserverBandwidth = 3000;
            
            testCase.verifyEqual(observerBandwidth, defaultObserverBandwidth);
        end
        
        function testDefaultObserverBandwidthSource(testCase)
            observerBandwidthSource = testCase.maskObj.getParameter('observerBandwidthSource').Value;
            defaultObserverBandwidthSource = 'Internal';
            
            testCase.verifyEqual(observerBandwidthSource, defaultObserverBandwidthSource);
        end
        
        function testDefaultControllerBandwidth(testCase)
            controllerBandwidth = str2double(testCase.maskObj.getParameter('controllerBandwidth').Value);
            defaultControllerBandwidth = 500;
            
            testCase.verifyEqual(controllerBandwidth, defaultControllerBandwidth);
        end
        
        function testDefaultControllerBandwidthSource(testCase)
            controllerBandwidthSource = testCase.maskObj.getParameter('observerBandwidthSource').Value;
            defaultControllerBandwidthSource = 'Internal';
            
            testCase.verifyEqual(controllerBandwidthSource, defaultControllerBandwidthSource);
        end
        
        function testDefaultSaturationEnabled(testCase)
            saturationEnabled = testCase.maskObj.getParameter('saturationEnabled').Value;
            defaultSaturationEnabled = 'on';
            
            testCase.verifyEqual(saturationEnabled, defaultSaturationEnabled);
        end
        
        function testDefaultSaturationUpperLimit(testCase)
            saturationUpperLimit = str2double(testCase.maskObj.getParameter('UpperLimit').Value);
            defaultSaturationUpperLimit = 1;
            
            testCase.verifyEqual(saturationUpperLimit, defaultSaturationUpperLimit);
        end
        
        function testDefaultSaturationLowerLimit(testCase)
            saturationLowerLimit = str2double(testCase.maskObj.getParameter('LowerLimit').Value);
            defaultSaturationLowerLimit = 0;
            
            testCase.verifyEqual(saturationLowerLimit, defaultSaturationLowerLimit);
        end
        
        function testDefaulDeadTimeEnabled(testCase)
            deadTimeEnabled = testCase.maskObj.getParameter('deadTimeEnabled').Value;
            defaultDeadTimeEnabled = 'off';
            
            testCase.verifyEqual(deadTimeEnabled, defaultDeadTimeEnabled);
        end
        
        function testDefaulObserverOutputEnabled(testCase)
            observerOutputEnabled = testCase.maskObj.getParameter('observerOutputEnabled').Value;
            defaultObserverOutputEnabled = 'off';
            
            testCase.verifyEqual(observerOutputEnabled, defaultObserverOutputEnabled);
        end
        
        %% Simulation parameters
        function testSimulationTime(testCase)
            simulationTime = get_param('dc_dc_converter', 'StopTime');
            testCase.verifyEqual(simulationTime, '1');
        end
        
        %% Reference parameters
        function testDefaultPulseGeneratorAmplitude(testCase)
            pulseAmplitude = get_param('dc_dc_converter/Pulse Generator', 'Amplitude');
            testCase.verifyEqual(pulseAmplitude, '5');
        end
        
        function testDefaultPulseGeneratorPeriod(testCase)
            pulsePeriod = get_param('dc_dc_converter/Pulse Generator', 'Period');
            testCase.verifyEqual(pulsePeriod, '0.5');
        end
        
        function testDefaultPulseGeneratorPulseWidth(testCase)
            pulseWidth = get_param('dc_dc_converter/Pulse Generator', 'PulseWidth');
            testCase.verifyEqual(pulseWidth, '50');
        end
        
        function testDefaultReferenceConstantOffset(testCase)
            constantOffset = get_param('dc_dc_converter/Constant', 'Value');
            testCase.verifyEqual(constantOffset, '10');
        end
        
        function testDefaultReferenceFilterNumerator(testCase)
            numerator = get_param('dc_dc_converter/Low-pass filter', 'Numerator');
            testCase.verifyEqual(numerator, '[1]');
        end
        
        function testDefaultReferenceFilterDenominator(testCase)
            denominator = get_param('dc_dc_converter/Low-pass filter', 'Denominator');
            testCase.verifyEqual(denominator, '[0.0001 0.02 1]');
        end
        
        %% PWM
        function testDefaultPwmPeriod(testCase)
            pwmPeriod = get_param('dc_dc_converter/PWM', 'Period');
            testCase.verifyEqual(pwmPeriod, '0.0001');
            
            pwmPeriodPid = get_param('dc_dc_converter/PWM Pid', 'Period');
            testCase.verifyEqual(pwmPeriodPid, '0.0001');
        end
        
        %% Noise parameters
        function testDefaultMeasurementNoisePower(testCase)
            noisePower = get_param('dc_dc_converter/Measurement Noise', 'Cov');
            testCase.verifyEqual(noisePower, '5e-9');
            
            noisePowerPid = get_param('dc_dc_converter/Measurement Noise Pid', 'Cov');
            testCase.verifyEqual(noisePowerPid, '5e-9');
        end
        
        function testDefaultMeasurementNoiseSampleTime(testCase)
            sampleTime = get_param('dc_dc_converter/Measurement Noise', 'Ts');
            testCase.verifyEqual(sampleTime, '0.0001');
            
            sampleTimePid = get_param('dc_dc_converter/Measurement Noise Pid', 'Ts');
            testCase.verifyEqual(sampleTimePid, '0.0001');
        end
        
        function testDefaultMeasurementNoiseSeed(testCase)
            seed = get_param('dc_dc_converter/Measurement Noise', 'seed');
            testCase.verifyEqual(seed, '[23341]');
            
            seedPid = get_param('dc_dc_converter/Measurement Noise Pid', 'seed');
            testCase.verifyEqual(seedPid, '[23341]');
        end
        
        %% Control plant parameters
        function testMosfetParameters(testCase)
            desiredMosfetResistance = '0.1';
            desiredMosfetOffstateConductance = '1e-12';
            desiredMosfetThresholdVoltage = '0.5';
            
            mosfetResistance = get_param('dc_dc_converter/MOSFET', 'Rds');
            testCase.verifyEqual(mosfetResistance, desiredMosfetResistance);
            
            mosfetOffstateConductance = get_param('dc_dc_converter/MOSFET', 'Goff');
            testCase.verifyEqual(mosfetOffstateConductance, desiredMosfetOffstateConductance);
            
            mosfetThresholdVoltage = get_param('dc_dc_converter/MOSFET', 'Vth');
            testCase.verifyEqual(mosfetThresholdVoltage, desiredMosfetThresholdVoltage);
            
            mosfetResistancePid = get_param('dc_dc_converter/MOSFET Pid', 'Rds');
            testCase.verifyEqual(mosfetResistancePid, desiredMosfetResistance);
            
            mosfetOffstateConductancePid = get_param('dc_dc_converter/MOSFET Pid', 'Goff');
            testCase.verifyEqual(mosfetOffstateConductancePid, desiredMosfetOffstateConductance);
            
            mosfetThresholdVoltagePid = get_param('dc_dc_converter/MOSFET Pid', 'Vth');
            testCase.verifyEqual(mosfetThresholdVoltagePid, desiredMosfetThresholdVoltage);
        end
        
        function testDiodeParameters(testCase)
            desiredDiodeForwardVoltage = '0.6';
            desiredDiodeOnVoltage = '0.1';
            desiredDiodeOffConductance = '1e-8';
            desiredNumberOfSeriesDiodes = '1';
            desiredNumberOfParallelDiodes = '1';
           
            diodeForwardVoltage = get_param('dc_dc_converter/Diode', 'Vf');
            testCase.verifyEqual(diodeForwardVoltage, desiredDiodeForwardVoltage);
            
            diodeOnVoltage = get_param('dc_dc_converter/Diode', 'Ron');
            testCase.verifyEqual(diodeOnVoltage, desiredDiodeOnVoltage);
            
            diodeOffConductance = get_param('dc_dc_converter/Diode', 'Goff');
            testCase.verifyEqual(diodeOffConductance, desiredDiodeOffConductance);
            
            numberOfSeriesDiodes = get_param('dc_dc_converter/Diode', 'N_series');
            testCase.verifyEqual(numberOfSeriesDiodes, desiredNumberOfSeriesDiodes);
            
            numberOfParallelDiodes = get_param('dc_dc_converter/Diode', 'N_parallel');
            testCase.verifyEqual(numberOfParallelDiodes, desiredNumberOfParallelDiodes);
            
            diodeForwardVoltagePid = get_param('dc_dc_converter/Diode Pid', 'Vf');
            testCase.verifyEqual(diodeForwardVoltagePid, desiredDiodeForwardVoltage);
            
            diodeOnVoltagePid = get_param('dc_dc_converter/Diode Pid', 'Ron');
            testCase.verifyEqual(diodeOnVoltagePid, desiredDiodeOnVoltage);
            
            diodeOffConductancePid = get_param('dc_dc_converter/Diode Pid', 'Goff');
            testCase.verifyEqual(diodeOffConductancePid, desiredDiodeOffConductance);
            
            numberOfSeriesDiodesPid = get_param('dc_dc_converter/Diode Pid', 'N_series');
            testCase.verifyEqual(numberOfSeriesDiodesPid, desiredNumberOfSeriesDiodes);
            
            numberOfParallelDiodesPid = get_param('dc_dc_converter/Diode Pid', 'N_parallel');
            testCase.verifyEqual(numberOfParallelDiodesPid, desiredNumberOfParallelDiodes);
        end
        
        function testInductorParameters(testCase)
            desiredInductorInductance = '0.01';
            desiredInductorTolerance = '20';
            desiredInductorSeriesResistance = '0';
            desiredInductorParallelConductance = '1e-9';
            
            inductorInductance = get_param('dc_dc_converter/Inductor', 'l');
            testCase.verifyEqual(inductorInductance, desiredInductorInductance);
            
            inductorTolerance = get_param('dc_dc_converter/Inductor', 'L_tol');
            testCase.verifyEqual(inductorTolerance, desiredInductorTolerance);
            
            inductorSeriesResistance = get_param('dc_dc_converter/Inductor', 'r');
            testCase.verifyEqual(inductorSeriesResistance, desiredInductorSeriesResistance);
            
            inductorParallelConductance = get_param('dc_dc_converter/Inductor', 'g');
            testCase.verifyEqual(inductorParallelConductance, desiredInductorParallelConductance);
            
            inductorInductancePid = get_param('dc_dc_converter/Inductor Pid', 'l');
            testCase.verifyEqual(inductorInductancePid, desiredInductorInductance);
            
            inductorTolerancePid = get_param('dc_dc_converter/Inductor Pid', 'L_tol');
            testCase.verifyEqual(inductorTolerancePid, desiredInductorTolerance);
            
            inductorSeriesResistancePid = get_param('dc_dc_converter/Inductor Pid', 'r');
            testCase.verifyEqual(inductorSeriesResistancePid, desiredInductorSeriesResistance);
            
            inductorParallelConductancePid = get_param('dc_dc_converter/Inductor Pid', 'g');
            testCase.verifyEqual(inductorParallelConductancePid, desiredInductorParallelConductance);
        end
        
        function testVoltageSourceParameters(testCase)
            desiredVoltageSourceDcVoltage = '20';
            desiredVoltageSourceAcVoltage = '0';
            
            voltageSourceDcVoltage = get_param('dc_dc_converter/Voltage Source', 'dc_voltage');
            testCase.verifyEqual(voltageSourceDcVoltage, desiredVoltageSourceDcVoltage);
            
            voltageSourceAcVoltage = get_param('dc_dc_converter/Voltage Source', 'ac_voltage');
            testCase.verifyEqual(voltageSourceAcVoltage, desiredVoltageSourceAcVoltage);
            
            voltageSourceDcVoltagePid = get_param('dc_dc_converter/Voltage Source Pid', 'dc_voltage');
            testCase.verifyEqual(voltageSourceDcVoltagePid, desiredVoltageSourceDcVoltage);
            
            voltageSourceAcVoltagePid = get_param('dc_dc_converter/Voltage Source Pid', 'ac_voltage');
            testCase.verifyEqual(voltageSourceAcVoltagePid, desiredVoltageSourceAcVoltage);
        end
        
        function testCapacitorParameters(testCase)
            desiredCapacitorCapacitance = '0.001';
            desiredCapacitorTolerance = '5';
            desiredCapacitorSeriesResistance = '1e-6';
            desiredCapacitorParallelConductance = '0';
            
            capacitorCapacitance = get_param('dc_dc_converter/Capacitor', 'c');
            testCase.verifyEqual(capacitorCapacitance, desiredCapacitorCapacitance);
            
            capacitorTolerance = get_param('dc_dc_converter/Capacitor', 'C_tol');
            testCase.verifyEqual(capacitorTolerance, desiredCapacitorTolerance);
            
            capacitorSeriesResistance = get_param('dc_dc_converter/Capacitor', 'r');
            testCase.verifyEqual(capacitorSeriesResistance, desiredCapacitorSeriesResistance);
            
            capacitorParallelConductance = get_param('dc_dc_converter/Capacitor Pid', 'g');
            testCase.verifyEqual(capacitorParallelConductance, desiredCapacitorParallelConductance);
            
            capacitorCapacitancePid = get_param('dc_dc_converter/Capacitor Pid', 'c');
            testCase.verifyEqual(capacitorCapacitancePid, desiredCapacitorCapacitance);
            
            capacitorTolerancePid = get_param('dc_dc_converter/Capacitor Pid', 'C_tol');
            testCase.verifyEqual(capacitorTolerancePid, desiredCapacitorTolerance);
            
            capacitorSeriesResistancePid = get_param('dc_dc_converter/Capacitor Pid', 'r');
            testCase.verifyEqual(capacitorSeriesResistancePid, desiredCapacitorSeriesResistance);
            
            capacitorParallelConductancePid = get_param('dc_dc_converter/Capacitor Pid', 'g');
            testCase.verifyEqual(capacitorParallelConductancePid, desiredCapacitorParallelConductance);
        end
        
        function testResistorParameters(testCase)
            desiredResistorResistance = '50';
            desiredResistorTolerance = '5';
            
            resistorResistance = get_param('dc_dc_converter/Resistor', 'R');
            testCase.verifyEqual(resistorResistance, desiredResistorResistance);
            
            resistorTolerance = get_param('dc_dc_converter/Resistor', 'R_tol');
            testCase.verifyEqual(resistorTolerance, desiredResistorTolerance);
            
            resistorResistancePid = get_param('dc_dc_converter/Resistor Pid', 'R');
            testCase.verifyEqual(resistorResistancePid, desiredResistorResistance);
            
            resistorTolerancePid = get_param('dc_dc_converter/Resistor Pid', 'R_tol');
            testCase.verifyEqual(resistorTolerancePid, desiredResistorTolerance);
        end
        
        %% Unknown load parameters
        function testVariableLoadParameters(testCase)
            desiredResistorAmplitude = '85';
            desiredResistorBias = '100';
            desiredResistorFrequency = '20';
            
            resistorAmplitude = get_param('dc_dc_converter/PS Sine Wave', 'amplitude');
            testCase.verifyEqual(resistorAmplitude, desiredResistorAmplitude);
            
            resistorBias = get_param('dc_dc_converter/PS Sine Wave', 'bias');
            testCase.verifyEqual(resistorBias, desiredResistorBias);
            
            resistorFrequency = get_param('dc_dc_converter/PS Sine Wave', 'frequency_SI');
            testCase.verifyEqual(resistorFrequency, desiredResistorFrequency);
            
            resistorAmplitudePid = get_param('dc_dc_converter/PS Sine Wave Pid', 'amplitude');
            testCase.verifyEqual(resistorAmplitudePid, desiredResistorAmplitude);
            
            resistorBiasPid = get_param('dc_dc_converter/PS Sine Wave Pid', 'bias');
            testCase.verifyEqual(resistorBiasPid, desiredResistorBias);
            
            resistorFrequencyPid = get_param('dc_dc_converter/PS Sine Wave Pid', 'frequency_SI');
            testCase.verifyEqual(resistorFrequencyPid, desiredResistorFrequency);
        end
        
        %% PID tests
        function testProportionalPidGain(testCase)
            proportionalGain = get_param('dc_dc_converter/PID Controller', 'P');
            testCase.verifyEqual(proportionalGain, '0.2');
        end
        
        function testIntegralPidGain(testCase)
            integralGain = get_param('dc_dc_converter/PID Controller', 'I');
            testCase.verifyEqual(integralGain, '3');
        end
        
        function testDerivativePidGain(testCase)
            derivativeGain = get_param('dc_dc_converter/PID Controller', 'D');
            testCase.verifyEqual(derivativeGain, '0');
        end
        
        function testPidSaturation(testCase)
            saturationEnabled = get_param('dc_dc_converter/PID Controller', 'LimitOutput');
            testCase.verifyEqual(saturationEnabled, 'on');
            
            upperLimit = get_param('dc_dc_converter/PID Controller', 'UpperSaturationLimit');
            testCase.verifyEqual(upperLimit, '1');
            
            lowerLimit = get_param('dc_dc_converter/PID Controller', 'LowerSaturationLimit');
            testCase.verifyEqual(lowerLimit, '0');
        end
    end
end