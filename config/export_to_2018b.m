function export_to_2018b(path)
    [filepath,filename,extension] = fileparts(path);
    
    for i=1:numel(path)
        temp_path = filepath{i} + "/" + filename{i} + "_TEMP" + extension{i};
        load_system(filename{i});
        Simulink.exportToVersion(filename{i}, temp_path,'R2018b'); % creates a temp file (because direct override in forbidden)
        close_system(filename{i});

        delete(path{i});
        movefile(temp_path, path{i})
    end
end

