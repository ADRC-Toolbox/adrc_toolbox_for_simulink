classdef observerOutputVariantTest < matlab.unittest.TestCase
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
        function testObserverOutputTotalDisturbanceVariant(testCase)
            import matlab.unittest.constraints.AnyCellOf
            import matlab.unittest.constraints.Matches
            
            set_param('adrc_toolbox_library/ADRC controller/Observer output', 'LabelModeActiveChoice', 'estimated_total_disturbance');
            
            expectedSubsystem = 'adrc_toolbox_library/ADRC controller/Observer output/Only estimated total disturbance';
            subsystems = find_system('adrc_toolbox_library/ADRC controller/Observer output',...
                'SearchDepth', 1,...
                'LookUnderMasks', 'on',...
                'BlockType', 'SubSystem'...
            );
            testCase.verifyThat(AnyCellOf(subsystems), Matches(expectedSubsystem));
        end
        
        function testObserverOutputWholeStateVariant(testCase)
            import matlab.unittest.constraints.AnyCellOf
            import matlab.unittest.constraints.Matches
            
            set_param('adrc_toolbox_library/ADRC controller/Observer output', 'LabelModeActiveChoice', 'estimated_extended_state');
            
            expectedSubsystem = 'adrc_toolbox_library/ADRC controller/Observer output/Whole estimated extended state';
            subsystems = find_system('adrc_toolbox_library/ADRC controller/Observer output',...
                'SearchDepth', 1,...
                'LookUnderMasks', 'on',...
                'BlockType', 'SubSystem'...
            );
            testCase.verifyThat(AnyCellOf(subsystems), Matches(expectedSubsystem));
        end
        
        function testObserverOutputControlErrorVariant(testCase)
            import matlab.unittest.constraints.AnyCellOf
            import matlab.unittest.constraints.Matches
            
            set_param('adrc_toolbox_library/ADRC controller/Observer output', 'LabelModeActiveChoice', 'estimated_control_error');
            
            expectedSubsystem = 'adrc_toolbox_library/ADRC controller/Observer output/Only estimated control error';
            subsystems = find_system('adrc_toolbox_library/ADRC controller/Observer output',...
                'SearchDepth', 1,...
                'LookUnderMasks', 'on',...
                'BlockType', 'SubSystem'...
            );
            testCase.verifyThat(AnyCellOf(subsystems), Matches(expectedSubsystem));
        end
    end
end