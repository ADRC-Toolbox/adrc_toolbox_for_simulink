classdef tclabTempControlTest < matlab.unittest.TestCase
    properties
        maskObj1
        maskObj2
    end
    
    methods(TestClassSetup)
        function initializeTclabTempControl(testCase)
            load_system('tclab_temp_control');
            testCase.maskObj1 = Simulink.Mask.get('tclab_temp_control/ADRC controller1');
            testCase.maskObj2 = Simulink.Mask.get('tclab_temp_control/ADRC controller2');
        end
    end
    
    methods(TestClassTeardown)
        function closeTclabTempControl(testCase)
            close_system('tclab_temp_control', 0);
        end
    end
    
    methods (Test)   
        %% Default mask values for ADRC controller 1
        function testDefaultDynamicsOrder1(testCase)
            dynamicsOrderParameter = str2double(testCase.maskObj1.getParameter('dynamicsOrder').Value);
            defaultDynamicsOrder = 1;
            
            testCase.verifyEqual(dynamicsOrderParameter, defaultDynamicsOrder);
        end
        
        function testDefaultInputGainValue1(testCase)
            inputGainValue = str2double(testCase.maskObj1.getParameter('inputGainParameter').Value);
            defaultInputGain = 0.4;
            
            testCase.verifyEqual(inputGainValue, defaultInputGain);
        end
        
        function testDefaultInputGainSource1(testCase)
            inputGainSource = testCase.maskObj1.getParameter('inputGainSource').Value;
            defaultInputGainSource = 'Internal';
            
            testCase.verifyEqual(inputGainSource, defaultInputGainSource);
        end
        
        function testDefaultObserverBandwidth1(testCase)
            observerBandwidth = str2double(testCase.maskObj1.getParameter('observerBandwidth').Value);
            defaultObserverBandwidth = 7;
            
            testCase.verifyEqual(observerBandwidth, defaultObserverBandwidth);
        end
        
        function testDefaultObserverBandwidthSource1(testCase)
            observerBandwidthSource = testCase.maskObj1.getParameter('observerBandwidthSource').Value;
            defaultObserverBandwidthSource = 'Internal';
            
            testCase.verifyEqual(observerBandwidthSource, defaultObserverBandwidthSource);
        end
        
        function testDefaultControllerBandwidth1(testCase)
            controllerBandwidth = str2double(testCase.maskObj1.getParameter('controllerBandwidth').Value);
            defaultControllerBandwidth = 2;
            
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
            defaultSaturationUpperLimit = 100;
            
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
            defaultDynamicsOrder = 1;
            
            testCase.verifyEqual(dynamicsOrderParameter, defaultDynamicsOrder);
        end
        
        function testDefaultInputGainValue2(testCase)
            inputGainValue = str2double(testCase.maskObj2.getParameter('inputGainParameter').Value);
            defaultInputGain = 0.4;
            
            testCase.verifyEqual(inputGainValue, defaultInputGain);
        end
        
        function testDefaultInputGainSource2(testCase)
            inputGainSource = testCase.maskObj2.getParameter('inputGainSource').Value;
            defaultInputGainSource = 'Internal';
            
            testCase.verifyEqual(inputGainSource, defaultInputGainSource);
        end
        
        function testDefaultObserverBandwidth2(testCase)
            observerBandwidth = str2double(testCase.maskObj2.getParameter('observerBandwidth').Value);
            defaultObserverBandwidth = 7;
            
            testCase.verifyEqual(observerBandwidth, defaultObserverBandwidth);
        end
        
        function testDefaultObserverBandwidthSource2(testCase)
            observerBandwidthSource = testCase.maskObj2.getParameter('observerBandwidthSource').Value;
            defaultObserverBandwidthSource = 'Internal';
            
            testCase.verifyEqual(observerBandwidthSource, defaultObserverBandwidthSource);
        end
        
        function testDefaultControllerBandwidth2(testCase)
            controllerBandwidth = str2double(testCase.maskObj2.getParameter('controllerBandwidth').Value);
            defaultControllerBandwidth = 2;
            
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
            defaultSaturationUpperLimit = 100;
            
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
        
        %% Reference parameters
        function testDefaultSetpointValue1(testCase)
            setpointValue = get_param('tclab_temp_control/Constant1', 'Value');
            testCase.verifyEqual(setpointValue, '35');
        end
        
        function testDefaultSetpointValue2(testCase)
            setpointValue = get_param('tclab_temp_control/Constant2', 'Value');
            testCase.verifyEqual(setpointValue, '45');
        end
    end
end