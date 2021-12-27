classdef deadTimeVariantTest < matlab.unittest.TestCase
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
        function testDeadTimeOffVariant(testCase)
            import matlab.unittest.constraints.AnyCellOf
            import matlab.unittest.constraints.Matches
            
            set_param('adrc_toolbox_library/ADRC controller/State feedback robust controller/Dead time', 'LabelModeActiveChoice', 'dead_time_off');
            
            expectedSubsystem = 'adrc_toolbox_library/ADRC controller/State feedback robust controller/Dead time/Dead time off';
            subsystems = find_system('adrc_toolbox_library/ADRC controller/State feedback robust controller/Dead time',...
                'SearchDepth', 1,...
                'LookUnderMasks', 'on',...
                'BlockType', 'SubSystem'...
            );
            testCase.verifyThat(AnyCellOf(subsystems), Matches(expectedSubsystem));
        end
        
        function testDeadTimeOnVariant(testCase)
            import matlab.unittest.constraints.AnyCellOf
            import matlab.unittest.constraints.Matches
            
            set_param('adrc_toolbox_library/ADRC controller/State feedback robust controller/Dead time', 'LabelModeActiveChoice', 'dead_time_on');
            
            expectedSubsystem = 'adrc_toolbox_library/ADRC controller/State feedback robust controller/Dead time/Dead time on';
            subsystems = find_system('adrc_toolbox_library/ADRC controller/State feedback robust controller/Dead time',...
                'SearchDepth', 1,...
                'LookUnderMasks', 'on',...
                'BlockType', 'SubSystem'...
            );
            testCase.verifyThat(AnyCellOf(subsystems), Matches(expectedSubsystem));
        end
    end
end