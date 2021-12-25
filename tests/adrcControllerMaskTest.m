classdef adrcControllerMaskTest < matlab.unittest.TestCase
    properties
        maskObj
    end
    
    methods(TestMethodSetup)
        function initializeMaskObject(testCase)
            load_system('adrc_toolbox_library');
            set_param('adrc_toolbox_library', 'Lock', 'off');
            testCase.maskObj = Simulink.Mask.get('adrc_toolbox_library/ADRC controller');
        end
    end
    
    methods(TestMethodTeardown)
        function closeModel(testCase)
            close_system('adrc_toolbox_library', 0);
        end
    end
    
    methods (Test)
        %% General mask tests
        function testParameterNumber(testCase)
            parameterCount = 14;
            
            testCase.verifyEqual(numel(testCase.maskObj.Parameters), parameterCount)
        end
        
        function testParameterOrder(testCase)
            expectedParameterNames = {'dynamicsOrder',...
                'inputGainParameter',...
                'inputGainSource',...
                'observerBandwidth',...
                'observerBandwidthSource',...
                'controllerBandwidth',...
                'controllerBandwidthSource',...
                'saturationEnabled',...
                'UpperLimit',...
                'LowerLimit',...
                'deadTimeEnabled',...
                'deadTime',...
                'observerOutputEnabled',...
                'observerOutputChoice'};
            
            parameterNames = cell(1, numel(testCase.maskObj.Parameters));
            [parameterNames{:}] = testCase.maskObj.Parameters.Name;
            
            testCase.verifyEqual(parameterNames, expectedParameterNames)
        end
        
        %% Parameters tab tests
        function testDefaultDynamicsOrder(testCase)
            dynamicsOrderParameter = str2double(testCase.maskObj.getParameter('dynamicsOrder').Value);
            defaultDynamicsOrder = 2;
            
            testCase.verifyEqual(dynamicsOrderParameter, defaultDynamicsOrder);
        end
        
        function testDefaultInputGainValue(testCase)
            inputGainValue = str2double(testCase.maskObj.getParameter('inputGainParameter').Value);
            defaultInputGain = 1;
            
            testCase.verifyEqual(inputGainValue, defaultInputGain);
        end
        
        function testDefaultInputGainSource(testCase)
            inputGainSource = testCase.maskObj.getParameter('inputGainSource').Value;
            defaultInputGainSource = 'Internal';
            
            testCase.verifyEqual(inputGainSource, defaultInputGainSource);
        end
        
        function testDefaultObserverBandwidth(testCase)
            observerBandwidth = str2double(testCase.maskObj.getParameter('observerBandwidth').Value);
            defaultObserverBandwidth = 25;
            
            testCase.verifyEqual(observerBandwidth, defaultObserverBandwidth);
        end
        
        function testDefaultObserverBandwidthSource(testCase)
            observerBandwidthSource = testCase.maskObj.getParameter('observerBandwidthSource').Value;
            defaultObserverBandwidthSource = 'Internal';
            
            testCase.verifyEqual(observerBandwidthSource, defaultObserverBandwidthSource);
        end
        
        function testDefaultControllerBandwidth(testCase)
            controllerBandwidth = str2double(testCase.maskObj.getParameter('controllerBandwidth').Value);
            defaultControllerBandwidth = 5;
            
            testCase.verifyEqual(controllerBandwidth, defaultControllerBandwidth);
        end
        
        function testDefaultControllerBandwidthSource(testCase)
            controllerBandwidthSource = testCase.maskObj.getParameter('observerBandwidthSource').Value;
            defaultControllerBandwidthSource = 'Internal';
            
            testCase.verifyEqual(controllerBandwidthSource, defaultControllerBandwidthSource);
        end
        
        function testInputGainSourceChange(testCase)
            inportCount = numel(find_system('adrc_toolbox_library/ADRC controller',...
                'LookUnderMasks', 'on',...
                'SearchDepth', 1,...
                'BlockType', 'Inport'...
            ));
            blockType = get_param('adrc_toolbox_library/ADRC controller/inputGainParameterIn', 'BlockType');
            testCase.verifyEqual(inportCount, 1);
            testCase.verifyEqual(blockType, 'Ground');
            
            inputGainSource = testCase.maskObj.getParameter('inputGainSource');
            inputGainSource.set('Value', 'External')
            eval(testCase.maskObj.Initialization);
            inportCount = numel(find_system('adrc_toolbox_library/ADRC controller',...
                'LookUnderMasks', 'on',...
                'SearchDepth', 1,...
                'BlockType', 'Inport'...
            ));
            blockType = get_param('adrc_toolbox_library/ADRC controller/inputGainParameterIn', 'BlockType');
            testCase.verifyEqual(inportCount, 2);
            testCase.verifyEqual(blockType, 'Inport');
        end
        
        function testObserverBandwidthSourceChange(testCase)
            inportCount = numel(find_system('adrc_toolbox_library/ADRC controller',...
                'LookUnderMasks', 'on',...
                'SearchDepth', 1,...
                'BlockType', 'Inport'...
            ));
            blockType = get_param('adrc_toolbox_library/ADRC controller/observerBandwidthIn', 'BlockType');
            testCase.verifyEqual(inportCount, 1);
            testCase.verifyEqual(blockType, 'Ground');
            
            observerBandwidthSource = testCase.maskObj.getParameter('observerBandwidthSource');
            observerBandwidthSource.set('Value','External')
            eval(testCase.maskObj.Initialization)
            inportCount = numel(find_system('adrc_toolbox_library/ADRC controller',...
                'LookUnderMasks', 'on',...
                'SearchDepth', 1,...
                'BlockType', 'Inport'...
            ));
            blockType = get_param('adrc_toolbox_library/ADRC controller/observerBandwidthIn', 'BlockType');
            testCase.verifyEqual(inportCount,2);
            testCase.verifyEqual(blockType, 'Inport');
        end
        
        function testControllerBandwidthSourceChange(testCase)
            inportCount = numel(find_system('adrc_toolbox_library/ADRC controller',...
                'LookUnderMasks', 'on',...
                'SearchDepth', 1,...
                'BlockType', 'Inport'...
            ));
            blockType = get_param('adrc_toolbox_library/ADRC controller/controllerBandwidthIn', 'BlockType');
            testCase.verifyEqual(inportCount, 1);
            testCase.verifyEqual(blockType, 'Ground');
            
            controllerBandwidthSource = testCase.maskObj.getParameter('controllerBandwidthSource');
            controllerBandwidthSource.set('Value','External')
            eval(testCase.maskObj.Initialization);
            inportCount = numel(find_system('adrc_toolbox_library/ADRC controller',...
                'LookUnderMasks', 'on',...
                'SearchDepth', 1,...
                'BlockType', 'Inport'...
            ));
            blockType = get_param('adrc_toolbox_library/ADRC controller/controllerBandwidthIn', 'BlockType');
            testCase.verifyEqual(inportCount,2);
            testCase.verifyEqual(blockType, 'Inport');
        end
        
        %% Saturation tab tests
        function testDefaultSaturationEnabled(testCase)
            saturationEnabled = testCase.maskObj.getParameter('saturationEnabled').Value;
            defaultSaturationEnabled = 'off';
            
            testCase.verifyEqual(saturationEnabled, defaultSaturationEnabled);
        end
        
        function testDefaultSaturationUpperLimit(testCase)
            saturationUpperLimit = str2double(testCase.maskObj.getParameter('UpperLimit').Value);
            defaultSaturationUpperLimit = 10;
            
            testCase.verifyEqual(saturationUpperLimit, defaultSaturationUpperLimit);
        end
        
        function testDefaultSaturationLowerLimit(testCase)
            saturationLowerLimit = str2double(testCase.maskObj.getParameter('LowerLimit').Value);
            defaultSaturationLowerLimit = -10;
            
            testCase.verifyEqual(saturationLowerLimit, defaultSaturationLowerLimit);
        end
        
        function testSaturationEnabledChange(testCase)
            saturationLowerLimit = testCase.maskObj.getParameter('LowerLimit');
            saturationUpperLimit = testCase.maskObj.getParameter('UpperLimit');
            testCase.verifyEqual(saturationLowerLimit.Enabled, 'off');
            testCase.verifyEqual(saturationUpperLimit.Enabled, 'off');
            
            saturationEnabled = testCase.maskObj.getParameter('saturationEnabled');
            saturationEnabled.set('Value','on')
            eval(saturationEnabled.Callback);
            saturationLowerLimit = testCase.maskObj.getParameter('LowerLimit');
            saturationUpperLimit = testCase.maskObj.getParameter('UpperLimit');
            testCase.verifyEqual(saturationLowerLimit.Enabled, 'on');
            testCase.verifyEqual(saturationUpperLimit.Enabled, 'on');
        end
        
        %% Anti-peaking tab
        function testDefaulDeadTimeEnabled(testCase)
            deadTimeEnabled = testCase.maskObj.getParameter('deadTimeEnabled').Value;
            defaultDeadTimeEnabled = 'off';
            
            testCase.verifyEqual(deadTimeEnabled, defaultDeadTimeEnabled);
        end
        
        function testDefaultDeadTime(testCase)
            deadTime = str2double(testCase.maskObj.getParameter('deadTime').Value);
            defaultDeadTime = 0.2;
            
            testCase.verifyEqual(deadTime, defaultDeadTime);
        end
        
        function testDeadTimeEnabledChange(testCase)
            deadTime = testCase.maskObj.getParameter('deadTime');
            testCase.verifyEqual(deadTime.Enabled, 'off');
            
            deadTimeEnabled = testCase.maskObj.getParameter('deadTimeEnabled');
            deadTimeEnabled.set('Value','on')
            eval(deadTimeEnabled.Callback);
            deadTime = testCase.maskObj.getParameter('deadTime');
            testCase.verifyEqual(deadTime.Enabled, 'on');
        end
        
        %% Observer output tab
        function testDefaulObserverOutputEnabled(testCase)
            observerOutputEnabled = testCase.maskObj.getParameter('observerOutputEnabled').Value;
            defaultObserverOutputEnabled = 'off';
            
            testCase.verifyEqual(observerOutputEnabled, defaultObserverOutputEnabled);
        end
        
        function testDefaultObserverOutput(testCase)
            observerOutputChoice = testCase.maskObj.getParameter('observerOutputChoice').Value;
            defaultObserverOutputChoice = 'Estimated total disturbance';
            
            testCase.verifyEqual(observerOutputChoice, defaultObserverOutputChoice);
        end
        
        function testDefaultObserverOutputEnabledChange(testCase)
            outportCount = numel(find_system('adrc_toolbox_library/ADRC controller',...
                'LookUnderMasks','on',...
                'SearchDepth',1,...
                'BlockType','Outport'...
            ));
            blockType = get_param('adrc_toolbox_library/ADRC controller/selectedObserverOutput', 'BlockType');
            testCase.verifyEqual(outportCount, 1);
            testCase.verifyEqual(blockType, 'Terminator');
            
            observerOutputEnabled = testCase.maskObj.getParameter('observerOutputEnabled');
            observerOutputEnabled.set('Value','on');
            eval(testCase.maskObj.Initialization);
            outportCount = numel(find_system('adrc_toolbox_library/ADRC controller',...
                'LookUnderMasks','on',...
                'SearchDepth',1,...
                'BlockType','Outport'...
            ));
            blockType = get_param('adrc_toolbox_library/ADRC controller/selectedObserverOutput', 'BlockType');
            testCase.verifyEqual(outportCount, 2);
            testCase.verifyEqual(blockType, 'Outport');
        end
    end
end