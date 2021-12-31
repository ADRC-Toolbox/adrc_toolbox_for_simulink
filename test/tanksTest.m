classdef tanksTest < matlab.unittest.TestCase
    properties
        maskObj1
        maskObj2
        results
    end
    
    methods(TestClassSetup)
        function initializeTanks(testCase)
            load_system('tanks');
            testCase.maskObj1 = Simulink.Mask.get('tanks/ADRC controller1');
            testCase.maskObj2 = Simulink.Mask.get('tanks/ADRC controller2');
            testCase.results = sim('tanks');
        end
    end
    
    methods(TestClassTeardown)
        function closeTanks(testCase)
            close_system('tanks', 0);
        end
    end
    
    methods (Test)
        %% Results
        function testFinalControlError1Value(testCase)
            controlError = get(testCase.results.logsout, 'controlError1');
            lastTenSecondSamples = controlError.Values.Time > controlError.Values.Time(end) - 10;
            meanFinalControlError = sum(abs(controlError.Values.Data) .* lastTenSecondSamples) / sum(lastTenSecondSamples);
            maxMeanFinalControlError = 1e-05;
            
            testCase.verifyLessThan(meanFinalControlError, maxMeanFinalControlError)
        end
        
        function testFinalControlError2Value(testCase)
            controlError = get(testCase.results.logsout, 'controlError2');
            lastTenSecondSamples = controlError.Values.Time > controlError.Values.Time(end) - 10;
            meanFinalControlError = sum(abs(controlError.Values.Data) .* lastTenSecondSamples) / sum(lastTenSecondSamples);
            maxMeanFinalControlError = 2e-05;
            
            testCase.verifyLessThan(meanFinalControlError, maxMeanFinalControlError)
        end
        
        function testSaturation1(testCase)
            controlSignal = get(testCase.results.logsout, 'controlSignal1');
            maxControlSignal = max(controlSignal.Values.Data);
            minControlSignal = min(controlSignal.Values.Data);
            controlSignalUpperLimit = 4e-4;
            controlSignalLowerLimit = 0;
            

            testCase.verifyLessThanOrEqual(maxControlSignal, controlSignalUpperLimit);
            testCase.verifyGreaterThanOrEqual(minControlSignal, controlSignalLowerLimit);
        end
        
        function testSaturation2(testCase)
            controlSignal = get(testCase.results.logsout, 'controlSignal2');
            maxControlSignal = max(controlSignal.Values.Data);
            minControlSignal = min(controlSignal.Values.Data);
            controlSignalUpperLimit = 4e-4;
            controlSignalLowerLimit = 0;
            

            testCase.verifyLessThanOrEqual(maxControlSignal, controlSignalUpperLimit);
            testCase.verifyGreaterThanOrEqual(minControlSignal, controlSignalLowerLimit);
        end
        
        %% Default mask values for ADRC controller 1
        function testDefaultDynamicsOrder1(testCase)
            dynamicsOrderParameter = str2double(testCase.maskObj1.getParameter('dynamicsOrder').Value);
            defaultDynamicsOrder = 2;
            
            testCase.verifyEqual(dynamicsOrderParameter, defaultDynamicsOrder);
        end
        
        function testDefaultInputGainValue1(testCase)
            inputGainValue = str2double(testCase.maskObj1.getParameter('inputGainParameter').Value);
            defaultInputGain = 0.8;
            
            testCase.verifyEqual(inputGainValue, defaultInputGain);
        end
        
        function testDefaultInputGainSource1(testCase)
            inputGainSource = testCase.maskObj1.getParameter('inputGainSource').Value;
            defaultInputGainSource = 'Internal';
            
            testCase.verifyEqual(inputGainSource, defaultInputGainSource);
        end
        
        function testDefaultObserverBandwidth1(testCase)
            observerBandwidth = str2double(testCase.maskObj1.getParameter('observerBandwidth').Value);
            defaultObserverBandwidth = 3;
            
            testCase.verifyEqual(observerBandwidth, defaultObserverBandwidth);
        end
        
        function testDefaultObserverBandwidthSource1(testCase)
            observerBandwidthSource = testCase.maskObj1.getParameter('observerBandwidthSource').Value;
            defaultObserverBandwidthSource = 'Internal';
            
            testCase.verifyEqual(observerBandwidthSource, defaultObserverBandwidthSource);
        end
        
        function testDefaultControllerBandwidth1(testCase)
            controllerBandwidth = str2double(testCase.maskObj1.getParameter('controllerBandwidth').Value);
            defaultControllerBandwidth = 0.3;
            
            testCase.verifyEqual(controllerBandwidth, defaultControllerBandwidth);
        end
        
        function testDefaultControllerBandwidthSource1(testCase)
            controllerBandwidthSource = testCase.maskObj1.getParameter('observerBandwidthSource').Value;
            defaultControllerBandwidthSource = 'Internal';
            
            testCase.verifyEqual(controllerBandwidthSource, defaultControllerBandwidthSource);
        end
        
        function testDefaultSaturationEnabled1(testCase)
            saturationEnabled = testCase.maskObj1.getParameter('saturationEnabled').Value;
            defaultSaturationEnabled = 'on';
            
            testCase.verifyEqual(saturationEnabled, defaultSaturationEnabled);
        end
        
        function testDefaultSaturationUpperLimit1(testCase)
            saturationUpperLimit = str2double(testCase.maskObj1.getParameter('UpperLimit').Value);
            defaultSaturationUpperLimit = 4e-4;
            
            testCase.verifyEqual(saturationUpperLimit, defaultSaturationUpperLimit);
        end
        
        function testDefaultSaturationLowerLimit1(testCase)
            saturationLowerLimit = str2double(testCase.maskObj1.getParameter('LowerLimit').Value);
            defaultSaturationLowerLimit = 0;
            
            testCase.verifyEqual(saturationLowerLimit, defaultSaturationLowerLimit);
        end
        
        function testDefaulDeadTimeEnabled1(testCase)
            deadTimeEnabled = testCase.maskObj1.getParameter('deadTimeEnabled').Value;
            defaultDeadTimeEnabled = 'off';
            
            testCase.verifyEqual(deadTimeEnabled, defaultDeadTimeEnabled);
        end
        
        function testDefaulObserverOutputEnabled1(testCase)
            observerOutputEnabled = testCase.maskObj1.getParameter('observerOutputEnabled').Value;
            defaultObserverOutputEnabled = 'off';
            
            testCase.verifyEqual(observerOutputEnabled, defaultObserverOutputEnabled);
        end
        
        %% Default mask values for ADRC controller 2
        function testDefaultDynamicsOrder2(testCase)
            dynamicsOrderParameter = str2double(testCase.maskObj2.getParameter('dynamicsOrder').Value);
            defaultDynamicsOrder = 2;
            
            testCase.verifyEqual(dynamicsOrderParameter, defaultDynamicsOrder);
        end
        
        function testDefaultInputGainValue2(testCase)
            inputGainValue = str2double(testCase.maskObj2.getParameter('inputGainParameter').Value);
            defaultInputGain = 1;
            
            testCase.verifyEqual(inputGainValue, defaultInputGain);
        end
        
        function testDefaultInputGainSource2(testCase)
            inputGainSource = testCase.maskObj2.getParameter('inputGainSource').Value;
            defaultInputGainSource = 'Internal';
            
            testCase.verifyEqual(inputGainSource, defaultInputGainSource);
        end
        
        function testDefaultObserverBandwidth2(testCase)
            observerBandwidth = str2double(testCase.maskObj2.getParameter('observerBandwidth').Value);
            defaultObserverBandwidth = 1.2;
            
            testCase.verifyEqual(observerBandwidth, defaultObserverBandwidth);
        end
        
        function testDefaultObserverBandwidthSource2(testCase)
            observerBandwidthSource = testCase.maskObj2.getParameter('observerBandwidthSource').Value;
            defaultObserverBandwidthSource = 'Internal';
            
            testCase.verifyEqual(observerBandwidthSource, defaultObserverBandwidthSource);
        end
        
        function testDefaultControllerBandwidth2(testCase)
            controllerBandwidth = str2double(testCase.maskObj2.getParameter('controllerBandwidth').Value);
            defaultControllerBandwidth = 0.12;
            
            testCase.verifyEqual(controllerBandwidth, defaultControllerBandwidth);
        end
        
        function testDefaultControllerBandwidthSource2(testCase)
            controllerBandwidthSource = testCase.maskObj2.getParameter('observerBandwidthSource').Value;
            defaultControllerBandwidthSource = 'Internal';
            
            testCase.verifyEqual(controllerBandwidthSource, defaultControllerBandwidthSource);
        end
        
        function testDefaultSaturationEnabled2(testCase)
            saturationEnabled = testCase.maskObj2.getParameter('saturationEnabled').Value;
            defaultSaturationEnabled = 'on';
            
            testCase.verifyEqual(saturationEnabled, defaultSaturationEnabled);
        end
        
        function testDefaultSaturationUpperLimit2(testCase)
            saturationUpperLimit = str2double(testCase.maskObj2.getParameter('UpperLimit').Value);
            defaultSaturationUpperLimit = 4e-4;
            
            testCase.verifyEqual(saturationUpperLimit, defaultSaturationUpperLimit);
        end
        
        function testDefaultSaturationLowerLimit2(testCase)
            saturationLowerLimit = str2double(testCase.maskObj2.getParameter('LowerLimit').Value);
            defaultSaturationLowerLimit = 0;
            
            testCase.verifyEqual(saturationLowerLimit, defaultSaturationLowerLimit);
        end
        
        function testDefaulDeadTimeEnabled2(testCase)
            deadTimeEnabled = testCase.maskObj2.getParameter('deadTimeEnabled').Value;
            defaultDeadTimeEnabled = 'off';
            
            testCase.verifyEqual(deadTimeEnabled, defaultDeadTimeEnabled);
        end
        
        function testDefaulObserverOutputEnabled2(testCase)
            observerOutputEnabled = testCase.maskObj2.getParameter('observerOutputEnabled').Value;
            defaultObserverOutputEnabled = 'off';
            
            testCase.verifyEqual(observerOutputEnabled, defaultObserverOutputEnabled);
        end
        
        %% Simulation parameters
        function testSimulationTime(testCase)
            simulationTime = get_param('tanks', 'StopTime');
            testCase.verifyEqual(simulationTime, '200');
        end
        
        %% Reference parameters
        function testDefaultSetpoint1(testCase)
            defaultSetpointValue = get_param('tanks/Constant1', 'Value');
            testCase.verifyEqual(defaultSetpointValue, '0.2');
        end
        
        function testDefaultSetpoint21(testCase)
            defaultSetpointValue = get_param('tanks/Constant2', 'Value');
            testCase.verifyEqual(defaultSetpointValue, '0.35');
        end
        
        %% External disturbance 1 parameters 
        function testDefaultDisturbanceStepTime1(testCase)
            stepTime = get_param('tanks/ExternalDisturbance1', 'Time');
            testCase.verifyEqual(stepTime, '90');
        end
        
        function testDefaultDisturbanceInitialValue1(testCase)
            initialValue = get_param('tanks/ExternalDisturbance1', 'Before');
            testCase.verifyEqual(initialValue, '0');
        end
        
        function testDefaultDisturbanceFinalValue1(testCase)
            initialValue = get_param('tanks/ExternalDisturbance1', 'After');
            testCase.verifyEqual(initialValue, '-1.4e-4');
        end
        
        %% External disturbance 2 parameters 
        function testDefaultDisturbanceStepTime2(testCase)
            stepTime = get_param('tanks/ExternalDisturbance2', 'Time');
            testCase.verifyEqual(stepTime, '130');
        end
        
        function testDefaultDisturbanceInitialValue2(testCase)
            initialValue = get_param('tanks/ExternalDisturbance2', 'Before');
            testCase.verifyEqual(initialValue, '0');
        end
        
        function testDefaultDisturbanceFinalValue2(testCase)
            initialValue = get_param('tanks/ExternalDisturbance2', 'After');
            testCase.verifyEqual(initialValue, '-0.7e-4');
        end
%         
        %% Noise parameters for output 1
        function testDefaultMeasurementNoiseMean1(testCase)
            noiseMean = get_param('tanks/CoupledTanksSystem/SensorNoise1', 'Mean');
            testCase.verifyEqual(noiseMean, '0');
        end
        
        function testDefaultMeasurementNoiseVariance1(testCase)
            noiseVariance = get_param('tanks/CoupledTanksSystem/SensorNoise1', 'Variance');
            testCase.verifyEqual(noiseVariance, '0.8e-10');
        end
        
        function testDefaultMeasurementSampleTime1(testCase)
            sampleTime = get_param('tanks/CoupledTanksSystem/SensorNoise1', 'SampleTime');
            testCase.verifyEqual(sampleTime, '0.1');
        end
        
        function testDefaultMeasurementNoiseSeed1(testCase)
            seed = get_param('tanks/CoupledTanksSystem/SensorNoise1', 'Seed');
            testCase.verifyEqual(seed, '0');
        end
        
        %% Noise parameters for output 2
        function testDefaultMeasurementNoiseMean2(testCase)
            noiseMean = get_param('tanks/CoupledTanksSystem/SensorNoise2', 'Mean');
            testCase.verifyEqual(noiseMean, '0');
        end
        
        function testDefaultMeasurementNoiseVariance2(testCase)
            noiseVariance = get_param('tanks/CoupledTanksSystem/SensorNoise2', 'Variance');
            testCase.verifyEqual(noiseVariance, '0.8e-10');
        end
        
        function testDefaultMeasurementSampleTime2(testCase)
            sampleTime = get_param('tanks/CoupledTanksSystem/SensorNoise2', 'SampleTime');
            testCase.verifyEqual(sampleTime, '0.1');
        end
        
        function testDefaultMeasurementNoiseSeed2(testCase)
            seed = get_param('tanks/CoupledTanksSystem/SensorNoise2', 'Seed');
            testCase.verifyEqual(seed, '0');
        end
    end
end