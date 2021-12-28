% export ADRC Toolbox library
load_system("adrc_toolbox_library");
Simulink.exportToVersion('adrc_toolbox_library','libraries/adrc_toolbox_library_TEMP.slx','R2018b'); % creates a temp file (because direct override in forbidden)
close_system("adrc_toolbox_library");
delete("libraries/adrc_toolbox_library.slx");
movefile libraries/adrc_toolbox_library_TEMP.slx libraries/adrc_toolbox_library.slx % change file name

% export 'simple_example'
load_system("simple_example");
Simulink.exportToVersion('simple_example','examples/simple_example/simple_example_TEMP.slx','R2018b'); % creates a temp file (because direct override in forbidden)
close_system("simple_example");
delete("examples/simple_example/simple_example.slx");
movefile examples/simple_example/simple_example_TEMP.slx examples/simple_example/simple_example.slx % change file name