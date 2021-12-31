classdef simpleExampleExtendedTest < matlab.unittest.TestCase
    properties
        maskObj
        results
    end
    
    methods(TestClassSetup)
        function initializeSimpleExampleExtended(testCase)
            load_system('simple_example_extended');
            testCase.maskObj = Simulink.Mask.get('simple_example_extended/ADRC controller');
            testCase.results = sim('simple_example_extended');
        end
    end
    
    methods(TestClassTeardown)
        function closeSimpleExampleExtended(testCase)
            close_system('simple_example_extended', 0);
        end
    end
    
    methods (Test)
        %% Results
        function testFinalControlErrorValue(testCase)
            controlError = get(testCase.results.logsout, 'controlError');
            lastSecondSamples = controlError.Values.Time > controlError.Values.Time(end) - 1;
            meanFinalControlError = sum(controlError.Values.Data .* lastSecondSamples) / sum(lastSecondSamples);
            maxMeanFinalControlError = 1e-05;
            
            testCase.verifyLessThan(meanFinalControlError, maxMeanFinalControlError)
        end
        
        function testSaturation(testCase)
            controlSignal = get(testCase.results.logsout, 'controlSignal');
            maxControlSignal = max(controlSignal.Values.Data);
            minControlSignal = min(controlSignal.Values.Data);
            controlSignalUpperLimit = 100;
            controlSignalLowerLimit = -100;
            

            testCase.verifyLessThanOrEqual(maxControlSignal, controlSignalUpperLimit);
            testCase.verifyGreaterThanOrEqual(minControlSignal, controlSignalLowerLimit);
        end
        
        %% Default mask values
        function testDefaultDynamicsOrder(testCase)
            dynamicsOrderParameter = str2double(testCase.maskObj.getParameter('dynamicsOrder').Value);
            defaultDynamicsOrder = 4;
            
            testCase.verifyEqual(dynamicsOrderParameter, defaultDynamicsOrder);
        end

        function testDefaultInputGainValue(testCase)
            inputGainValue = get_param('simple_example_extended/hat_b', 'Value');
            testCase.verifyEqual(inputGainValue, '0.8');
        end        
%         function testDefaultInputGainValue(testCase)
%             inputGainValue = str2double(testCase.maskObj.getParameter('inputGainParameter').Value);
%             defaultInputGain = 0.8;
%             
%             testCase.verifyEqual(inputGainValue, defaultInputGain);
%         end
        
        function testDefaultInputGainSource(testCase)
            inputGainSource = testCase.maskObj.getParameter('inputGainSource').Value;
            defaultInputGainSource = 'External';
            
            testCase.verifyEqual(inputGainSource, defaultInputGainSource);
        end
        
        function testDefaultObserverBandwidth(testCase)
            observerBandwidth = get_param('simple_example_extended/omega_o', 'Value');
            testCase.verifyEqual(observerBandwidth, '50');
        end        
%         function testDefaultObserverBandwidth(testCase)
%             observerBandwidth = str2double(testCase.maskObj.getParameter('observerBandwidth').Value);
%             defaultObserverBandwidth = 50;
%             
%             testCase.verifyEqual(observerBandwidth, defaultObserverBandwidth);
%         end
        
        function testDefaultObserverBandwidthSource(testCase)
            observerBandwidthSource = testCase.maskObj.getParameter('observerBandwidthSource').Value;
            defaultObserverBandwidthSource = 'External';
            
            testCase.verifyEqual(observerBandwidthSource, defaultObserverBandwidthSource);
        end
        
        function testDefaultControllerBandwidth(testCase)
            controllerBandwidth = get_param('simple_example_extended/omega_c', 'Value');
            testCase.verifyEqual(controllerBandwidth, '5');
        end
%         function testDefaultControllerBandwidth(testCase)
%             controllerBandwidth = str2double(testCase.maskObj.getParameter('controllerBandwidth').Value);
%             defaultControllerBandwidth = 5;
%             
%             testCase.verifyEqual(controllerBandwidth, defaultControllerBandwidth);
%         end
        
        function testDefaultControllerBandwidthSource(testCase)
            controllerBandwidthSource = testCase.maskObj.getParameter('observerBandwidthSource').Value;
            defaultControllerBandwidthSource = 'External';
            
            testCase.verifyEqual(controllerBandwidthSource, defaultControllerBandwidthSource);
        end
        
        function testDefaultSaturationEnabled(testCase)
            saturationEnabled = testCase.maskObj.getParameter('saturationEnabled').Value;
            defaultSaturationEnabled = 'on';
            
            testCase.verifyEqual(saturationEnabled, defaultSaturationEnabled);
        end
        
        function testDefaultSaturationUpperLimit(testCase)
            saturationUpperLimit = str2double(testCase.maskObj.getParameter('UpperLimit').Value);
            defaultSaturationUpperLimit = 100;
            
            testCase.verifyEqual(saturationUpperLimit, defaultSaturationUpperLimit);
        end
        
        function testDefaultSaturationLowerLimit(testCase)
            saturationLowerLimit = str2double(testCase.maskObj.getParameter('LowerLimit').Value);
            defaultSaturationLowerLimit = -100;
            
            testCase.verifyEqual(saturationLowerLimit, defaultSaturationLowerLimit);
        end
        
        function testDefaulDeadTimeEnabled(testCase)
            deadTimeEnabled = testCase.maskObj.getParameter('deadTimeEnabled').Value;
            defaultDeadTimeEnabled = 'off';
            
            testCase.verifyEqual(deadTimeEnabled, defaultDeadTimeEnabled);
        end
        
        function testDefaulObserverOutputEnabled(testCase)
            observerOutputEnabled = testCase.maskObj.getParameter('observerOutputEnabled').Value;
            defaultObserverOutputEnabled = 'on';
            
            testCase.verifyEqual(observerOutputEnabled, defaultObserverOutputEnabled);
        end
        
        %% Simulation parameters
        function testSimulationTime(testCase)
            simulationTime = get_param('simple_example_extended', 'StopTime');
            testCase.verifyEqual(simulationTime, '20');
        end
        
        %% Step parameters
        function testDefaultDesiredOutputStepTime(testCase)
            stepTime = get_param('simple_example_extended/Step', 'Time');
            testCase.verifyEqual(stepTime, '1');
        end
        
        function testDefaultDesiredOutputInitialValue(testCase)
            initialValue = get_param('simple_example_extended/Step', 'Before');
            testCase.verifyEqual(initialValue, '0');
        end
        
        function testDefaultDesiredOutputFinalValue(testCase)
            initialValue = get_param('simple_example_extended/Step', 'After');
            testCase.verifyEqual(initialValue, '1');
        end
        
        %% Disturbance parameters
        function testDefaultDisturbanceStepTime(testCase)
            stepTime = get_param('simple_example_extended/Disturbance', 'Time');
            testCase.verifyEqual(stepTime, '10');
        end
        
        function testDefaultDisturbanceInitialValue(testCase)
            initialValue = get_param('simple_example_extended/Step', 'Before');
            testCase.verifyEqual(initialValue, '0');
        end
        
        function testDefaultDisturbanceFinalValue(testCase)
            initialValue = get_param('simple_example_extended/Disturbance', 'After');
            testCase.verifyEqual(initialValue, '70');
        end
        
        %% Noise parameters
        function testDefaultMeasurementNoisePower(testCase)
            noisePower = get_param('simple_example_extended/Measurement Noise', 'Cov');
            testCase.verifyEqual(noisePower, '1e-14');
        end
        
        function testDefaultMeasurementSampleTime(testCase)
            sampleTime = get_param('simple_example_extended/Measurement Noise', 'Ts');
            testCase.verifyEqual(sampleTime, '0.01');
        end
        
        function testDefaultMeasurementNoiseSeed(testCase)
            seed = get_param('simple_example_extended/Measurement Noise', 'seed');
            testCase.verifyEqual(seed, '[23341]');
        end
        
        %% Control plant parameters
        function testDefaultTransferFunctionNumerator(testCase)
            numerator = get_param('simple_example_extended/Transfer Fcn', 'Numerator');
            testCase.verifyEqual(numerator, '[1]')
        end
        
        function testDefaultTransferFunctionDenominator(testCase)
            denominator = get_param('simple_example_extended/Transfer Fcn', 'Denominator');
            testCase.verifyEqual(denominator, '[1 4 6 4 1]')
        end
    end
end