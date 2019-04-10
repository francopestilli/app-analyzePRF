function [] = main()

if ~isdeployed
	disp('loading paths for IUHPC')
	addpath(genpath('/N/u/brlife/git/jsonlab'))
	addpath(genpath('/N/u/brlife/git/mrTools'))
	addpath(genpath('/N/u/brlife/git/vistasoft'))
end

% load my own config.json
config = loadjson('config.json');

% compute pRF
analyzeHCP(config.fmri, config.stim);

end
