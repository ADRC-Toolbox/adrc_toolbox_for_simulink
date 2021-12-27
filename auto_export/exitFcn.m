% export ADRC Toolbox library
load_system("adrc_toolbox_library");
Simulink.exportToVersion('adrc_toolbox_library','auto_export/adrc_toolbox_library.slx','R2018b');
close_system("adrc_toolbox_library");

% export 'simple_example'
load_system("simple_example");
Simulink.exportToVersion('simple_example','auto_export/simple_example.slx','R2018b');
close_system("simple_example");