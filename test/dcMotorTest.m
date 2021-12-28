classdef dcMotorTest < matlab.unittest.TestCase
    properties
        maskObj
    end
    
    methods(TestClassSetup)
        function initializeDcMotor(testCase)
            load_system('dc_motor');
            testCase.maskObj = Simulink.Mask.get('dc_motor/ADRC controller');
        end
    end
    
    methods(TestClassTeardown)
        function closeDcMotor(testCase)
            close_system('dc_motor', 0);
        end
    end
    
    methods (Test)   
        %% Default mask values
        function testDefaultDynamicsOrder(testCase)
            dynamicsOrderParameter = str2double(testCase.maskObj.getParameter('dynamicsOrder').Value);
            defaultDynamicsOrder = 2;
            
            testCase.verifyEqual(dynamicsOrderParameter, defaultDynamicsOrder);
        end
        
        function testDefaultInputGainValue(testCase)
            inputGainValue = str2double(testCase.maskObj.getParameter('inputGainParameter').Value);
            defaultInputGain = 600;
            
            testCase.verifyEqual(inputGainValue, defaultInputGain);
        end
        
        function testDefaultInputGainSource(testCase)
            inputGainSource = testCase.maskObj.getParameter('inputGainSource').Value;
            defaultInputGainSource = 'Internal';
            
            testCase.verifyEqual(inputGainSource, defaultInputGainSource);
        end
        
        function testDefaultObserverBandwidth(testCase)
            observerBandwidth = str2double(testCase.maskObj.getParameter('observerBandwidth').Value);
            defaultObserverBandwidth = 90;
            
            testCase.verifyEqual(observerBandwidth, defaultObserverBandwidth);
        end
        
        function testDefaultObserverBandwidthSource(testCase)
            observerBandwidthSource = testCase.maskObj.getParameter('observerBandwidthSource').Value;
            defaultObserverBandwidthSource = 'Internal';
            
            testCase.verifyEqual(observerBandwidthSource, defaultObserverBandwidthSource);
        end
        
        function testDefaultControllerBandwidth(testCase)
            controllerBandwidth = str2double(testCase.maskObj.getParameter('controllerBandwidth').Value);
            defaultControllerBandwidth = 40;
            
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
            defaultObserverOutputEnabled = 'off';
            
            testCase.verifyEqual(observerOutputEnabled, defaultObserverOutputEnabled);
        end
        
        %% Reference parameters
        function testDefaultDesiredOutputStepTime(testCase)
            stepTime = get_param('dc_motor/Step1', 'Time');
            testCase.verifyEqual(stepTime, '3');
        end
        
        function testDefaultDesiredOutputInitialValue(testCase)
            initialValue = get_param('dc_motor/Step1', 'Before');
            testCase.verifyEqual(initialValue, '0');
        end
        
        function testDefaultDesiredOutputFinalValue(testCase)
            finalValue = get_param('dc_motor/Step1', 'After');
            testCase.verifyEqual(finalValue, '15');
        end
        
        function testSinusoidalReferenceMultiplierStepTime(testCase)
            stepTime = get_param('dc_motor/Step2', 'Time');
            testCase.verifyEqual(stepTime, '3');
        end
        
        function testSinusoidalReferenceMultiplierInitialValue(testCase)
            initialValue = get_param('dc_motor/Step2', 'Before');
            testCase.verifyEqual(initialValue, '0');
        end
        
        function testSinusoidalReferenceMultiplierFinalValue(testCase)
            finalValue = get_param('dc_motor/Step2', 'After');
            testCase.verifyEqual(finalValue, '1');
        end
        
        function testSinusoidalReferenceAmplitude(testCase)
            sineAmplitude = get_param('dc_motor/Sine Wave', 'Amplitude');
            testCase.verifyEqual(sineAmplitude, '5');
        end
        
        function testSinusoidalReferenceFrequency(testCase)
            sineFrequency = get_param('dc_motor/Sine Wave', 'Frequency');
            testCase.verifyEqual(sineFrequency, '6.28/4');
        end
    end
end