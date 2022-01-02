function create_toolbox_zipfile(version)
    export_selected_files_to_2018b;
    zipfilename = "adrc_toolbox_for_simulink_v." + version;
    zip(zipfilename, {...
       'libraries',...
       'examples/simple_example',...
       'examples/simple_example_extended',...
       'examples/dc_dc_converter',...
       'examples/dc_motor',...
       'examples/tanks',...
       'examples/tclab_temp_control'...
    });
end