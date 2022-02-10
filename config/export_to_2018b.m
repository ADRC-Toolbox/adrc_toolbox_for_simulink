function export_to_2018b(path)
    [filepath,filename,extension] = fileparts(path);
    
    for i=1:numel(path)
        temp_path = filepath{i} + "/" + filename{i} + "_TEMP" + extension{i};
        movefile(path{i}, temp_path)
        temp_filename = filename{i} + "_TEMP";
        load_system(temp_filename);
        Simulink.exportToVersion(temp_filename, path{i},'R2018b'); % creates a temp file (because direct override in forbidden)
        close_system(temp_filename);

        delete(temp_path);
    end
end
