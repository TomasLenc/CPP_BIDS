% (C) Copyright 2020 CPP_BIDS developers

function createDataDictionary(cfg, logFile)
    % createDataDictionary(cfg, logFile)
    %
    % creates the data dictionary to be associated with a _events.tsv file
    % will create empty field that you can then fill in manually in the JSON
    % file

    opts.Indent = '    ';

    fileName = strrep(logFile(1).filename, '.tsv', '.json');

    fileName = fullfile( ...
                        cfg.dir.outputSubject, ...
                        cfg.fileName.modality, ...
                        fileName);

    % add extra columns to basic columns
    namesExtraColumns = returnNamesExtraColumns(logFile);

    for iExtraColumn = 1:numel(namesExtraColumns)

        nbCol = returnNbColumns(logFile, namesExtraColumns{iExtraColumn});

        for iCol = 1:nbCol

            headerName = returnHeaderName(namesExtraColumns{iExtraColumn}, nbCol, iCol);

            logFile.columns.(headerName) = ...
                logFile(1).extraColumns.(namesExtraColumns{iExtraColumn}).bids;

        end

    end

    bids.util.jsonencode(fileName, logFile.columns, opts);

end
