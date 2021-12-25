classdef saturationVariantTest < matlab.unittest.TestCase
    properties
        maskObj
    end
    
    methods(TestMethodSetup)   
        function initializeMaskObject(testCase)
            load_system('adrc_toolbox_library');
            set_param('adrc_toolbox_library', 'Lock', 'off');
        end
    end
    
    methods(TestMethodTeardown)
        function closeModel(testCase)
            close_system('adrc_toolbox_library', 0);
        end
    end
    
    methods (Test)
        function testSaturationOffVariant(testCase)
            import matlab.unittest.constraints.AnyCellOf
            import matlab.unittest.constraints.Matches
            
            set_param('adrc_toolbox_library/ADRC controller/State feedback robust controller/Saturation', 'LabelModeActiveChoice', 'saturation_off');
            
            expectedSubsystem = 'adrc_toolbox_library/ADRC controller/State feedback robust controller/Saturation/Saturation off';
            subsystems = find_system('adrc_toolbox_library/ADRC controller/State feedback robust controller/Saturation',...
                'SearchDepth', 1,...
                'LookUnderMasks', 'on',...
                'BlockType', 'SubSystem'...
            );
            testCase.verifyThat(AnyCellOf(subsystems), Matches(expectedSubsystem));
        end
        
        function testSaturationOnVariant(testCase)
            import matlab.unittest.constraints.AnyCellOf
            import matlab.unittest.constraints.Matches
            
            set_param('adrc_toolbox_library/ADRC controller/State feedback robust controller/Saturation', 'LabelModeActiveChoice', 'saturation_on');
            
            expectedSubsystem = 'adrc_toolbox_library/ADRC controller/State feedback robust controller/Saturation/Saturation on';
            subsystems = find_system('adrc_toolbox_library/ADRC controller/State feedback robust controller/Saturation',...
                'SearchDepth', 1,...
                'LookUnderMasks', 'on',...
                'BlockType', 'SubSystem'...
            );
            testCase.verifyThat(AnyCellOf(subsystems), Matches(expectedSubsystem));
        end
    end
end