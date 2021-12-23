classdef adrcControllerMaskTest < matlab.unittest.TestCase
    methods (Test)
        function testParameterNumber(testCase)
            maskObj = Simulink.Mask.get('adrc_toolbox_library/ADRC controller');
            parameterCount = 14;
            
            testCase.verifyEqual(numel(maskObj.Parameters), parameterCount)
        end
        
        function testParameterOrder(testCase)
            maskObj = Simulink.Mask.get('adrc_toolbox_library/ADRC controller');
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
            
            parameterNames = cell(1, numel(maskObj.Parameters));
            [parameterNames{:}] = maskObj.Parameters.Name;
            
            testCase.verifyEqual(parameterNames, expectedParameterNames)
        end
    end
end