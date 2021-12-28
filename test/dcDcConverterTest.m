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
            meanFinalControlError = sum(controlError.Values.Data .* lastSecondSamples) / sum(lastSecondSamples);
            maxMeanFinalControlError = 1e-05;
            
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
        end
        
        %% Noise parameters
        function testDefaultMeasurementNoisePower(testCase)
            noisePower = get_param('dc_dc_converter/Measurement Noise', 'Cov');
            testCase.verifyEqual(noisePower, '5e-9');
        end
        
        function testDefaultMeasurementNoiseSampleTime(testCase)
            sampleTime = get_param('dc_dc_converter/Measurement Noise', 'Ts');
            testCase.verifyEqual(sampleTime, '0.0001');
        end
        
        function testDefaultMeasurementNoiseSeed(testCase)
            seed = get_param('dc_dc_converter/Measurement Noise', 'seed');
            testCase.verifyEqual(seed, '[23341]');
        end
        
        %% Control plant parameters
        function testMosfetParameters(testCase)
            mosfetResistance = get_param('dc_dc_converter/MOSFET', 'Rds');
            testCase.verifyEqual(mosfetResistance, '0.1');
            
            mosfetOffstateConductance = get_param('dc_dc_converter/MOSFET', 'Goff');
            testCase.verifyEqual(mosfetOffstateConductance, '1e-12');
            
            mosfetThresholdVoltage = get_param('dc_dc_converter/MOSFET', 'Vth');
            testCase.verifyEqual(mosfetThresholdVoltage, '0.5');
        end
        
        function testDiodeParameters(testCase)
            diodeForwardVoltage = get_param('dc_dc_converter/Diode', 'Vf');
            testCase.verifyEqual(diodeForwardVoltage, '0.6');
            
            diodeOnVoltage = get_param('dc_dc_converter/Diode', 'Ron');
            testCase.verifyEqual(diodeOnVoltage, '0.1');
            
            diodeOffConductance = get_param('dc_dc_converter/Diode', 'Goff');
            testCase.verifyEqual(diodeOffConductance, '1e-8');
            
            numberOfSeriesDiodes = get_param('dc_dc_converter/Diode', 'N_series');
            testCase.verifyEqual(numberOfSeriesDiodes, '1');
            
            numberOfParallelDiodes = get_param('dc_dc_converter/Diode', 'N_parallel');
            testCase.verifyEqual(numberOfParallelDiodes, '1');
        end
        
        function testInductorParameters(testCase)
            inductorInductance = get_param('dc_dc_converter/Inductor', 'l');
            testCase.verifyEqual(inductorInductance, '0.01');
            
            inductorTolerance = get_param('dc_dc_converter/Inductor', 'L_tol');
            testCase.verifyEqual(inductorTolerance, '20');
            
            inductorSeriesResistance = get_param('dc_dc_converter/Inductor', 'r');
            testCase.verifyEqual(inductorSeriesResistance, '0');
            
            inductorParallelConductance = get_param('dc_dc_converter/Inductor', 'g');
            testCase.verifyEqual(inductorParallelConductance, '1e-9');
        end
        
        function testVoltageSourceParameters(testCase)
            voltageSourceDcVoltage = get_param('dc_dc_converter/Voltage Source', 'dc_voltage');
            testCase.verifyEqual(voltageSourceDcVoltage, '20');
            
            voltageSourceAcVoltage = get_param('dc_dc_converter/Voltage Source', 'ac_voltage');
            testCase.verifyEqual(voltageSourceAcVoltage, '0');
        end
        
        function testCapacitorParameters(testCase)
            capacitorCapacitance = get_param('dc_dc_converter/Capacitor', 'c');
            testCase.verifyEqual(capacitorCapacitance, '0.001');
            
            capacitorTolerance = get_param('dc_dc_converter/Capacitor', 'C_tol');
            testCase.verifyEqual(capacitorTolerance, '5');
            
            capacitorSeriesResistance = get_param('dc_dc_converter/Capacitor', 'r');
            testCase.verifyEqual(capacitorSeriesResistance, '1e-6');
            
            capacitorParallelConductance = get_param('dc_dc_converter/Capacitor', 'g');
            testCase.verifyEqual(capacitorParallelConductance, '0');
        end
        
        function testResistorParameters(testCase)
            resistorResistance = get_param('dc_dc_converter/Resistor', 'R');
            testCase.verifyEqual(resistorResistance, '50');
            
            resistorTolerance = get_param('dc_dc_converter/Resistor', 'R_tol');
            testCase.verifyEqual(resistorTolerance, '5');
        end
        
        %% Unknown load parameters
        function testVariableLoadParameters(testCase)
            resistorAmplitude = get_param('dc_dc_converter/PS Sine Wave', 'amplitude');
            testCase.verifyEqual(resistorAmplitude, '85');
            
            resistorBias = get_param('dc_dc_converter/PS Sine Wave', 'bias');
            testCase.verifyEqual(resistorBias, '100');
            
            resistorFrequency = get_param('dc_dc_converter/PS Sine Wave', 'frequency_SI');
            testCase.verifyEqual(resistorFrequency, '20');
        end
    end
end