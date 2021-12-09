function blkStruct = slblocks
% This function specifies that the library 'adrc_toolbox_library'
% should appear in the Library Browser with the 
% name 'ADRC Toolbox'

    Browser.Library = 'adrc_toolbox_library';
    % 'adrc_toolbox_library' is the name of the library

    Browser.Name = 'ADRC Toolbox';
    % 'ADRC Toolbox' is the library name that appears
    % in the Library Browser

    blkStruct.Browser = Browser;