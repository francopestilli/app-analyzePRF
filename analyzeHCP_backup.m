%% Example 1: Run analyzePRF on an example dataset

function analyzeHCP(fmri,stim)
%% Download dataset (if necessary) and add analyzePRF to the MATLAB path

%setup;
%addpath(genpath('/N/u/davhunt/Carbonate/analyzePRF'))
%addpath(genpath('/N/u/davhunt/Carbonate/analyzePRF/utilities'))

%% Load in the data


data = {};
a1 = load_untouch_nii(fmri);
data{1} = double(a1.img);
% Just analyze one slice's worth of voxels
%data2 = {};
%data2{1} = data{1}(51:60,61:70,51:60,:);
%data2{1} = data{1}(:,:,:,:);
stimulus = {};
a1 = load_untouch_nii(stim);
stimulus{1} = double(a1.img);

% Load in the data
%load('exampledataset.mat');

% Check the workspace
whos
%%

%% Inspect the data

% Check dimensionality of the data
data
%%

% There are four runs of data; each run consists of 150 time points (TR = 2 s).
% The data have already been pre-processed for slice timing correction, motion
% correction, and spatial undistortion.  For simplicity, we have selected
% 10 example voxels from the left hemisphere.  Let's visualize the time-series
% data for the second voxel.
% temp = cellfun(@(x) x(2,:),data2,'UniformOutput',0);
% figure; hold on;
% set(gcf,'Units','points','Position',[100 100 600 150]);
% plot(cat(2,temp{:}),'r-');
% straightline(150*(1:4)+.5,'v','g-');
% xlabel('TR');
% ylabel('BOLD signal');
% ax = axis;
% axis([.5 600+.5 ax(3:4)]);
% title('Time-series data');
%%

%% Inspect the stimuli

% Check dimensionality of the stimuli
stimulus
%%

% The stimulus images have been prepared at a resolution of 100 pixels x 100 pixels.
% There are 300 images per run because we have prepared the images at a time resolution
% of 1 second.  (Note that this is faster than the data sampling rate.  When analyzing
% the data, we will resample the data to match the stimulus rate.)  Let's inspect a
% few of the stimulus images in the first run.
% figure;
% set(gcf,'Units','points','Position',[100 100 700 300]);
% for p=1:3
%   subplot(1,3,p); hold on;
%   num = 239+2*p;
%   imagesc(stimulus{1}(:,:,num),[0 1]);
%   axis image tight;
%   set(gca,'YDir','reverse');
%   colormap(gray);
%   title(sprintf('Image number %d',num));
% end
%%

% Notice that the range of values is 0 to 1 (0 indicates that the gray background was
% present; 1 indicates that the stimulus was present).  For these stimulus images,
% the stimulus is a bar that moves downward and to the left.

%% Analyze the data

% Start parallel MATLAB to speed up execution.
%if matlabpool('size')==0
%  matlabpool open;
%end
try
    if (matlabpool('size')==0) matlabpool; end
catch
    if isempty(gcp('nocreate')) parpool; end
end
% We need to resample the data to match the temporal rate of the stimulus.  Here we use
% cubic interpolation to increase the rate of the data from 2 seconds to 1 second (note
% that the first time point is preserved and the total data duration stays the same).
%data = tseriesinterp(data,2,1,2);

% Finally, we analyze the data using analyzePRF.  The third argument is the TR, which
% is now 1 second.  The default analysis strategy involves two generic initial seeds
% and an initial seed that is computed by performing a grid search.  This last seed is
% a little costly to compute, so to save time, we set 'seedmode' to [0 1] which means
% to just use the two generic initial seeds.  We suppress command-window output by
% setting 'display' to 'off'.
results = analyzePRF(stimulus,data{1}(:,1:35,:,:),1,struct('seedmode',[-2],'display','off'));

a2.img = make_nii(results.ang,[1.60 1.60 1.60]);
save_nii(a2.img,'polarAngle1.nii.gz');
results.ang = [];

a2.img = make_nii(results.ecc,[1.60 1.60 1.60]);
save_nii(a2.img,'eccentricity1.nii.gz');
results.ecc = [];

a2.img = make_nii(results.expt,[1.60 1.60 1.60]);
save_nii(a2.img,'exponent1.nii.gz');
results.expt = [];

a2.img = make_nii(results.rfsize,[1.60 1.60 1.60]);
save_nii(a2.img,'rfWidth1.nii.gz');
results.rfsize = [];

a2.img = make_nii(results.R2,[1.60 1.60 1.60]);
save_nii(a2.img,'r21.nii.gz');
results.R2 = [];

a2.img = make_nii(results.gain,[1.60 1.60 1.60]);
save_nii(a2.img,'gain1.nii.gz');
results.gain = [];

a2.img = make_nii(results.meanvol,[1.60 1.60 1.60]);
save_nii(a2.img,'meanvol1.nii.gz');
results.meanvol = [];

results = analyzePRF(stimulus,data{1}(:,36:70,:,:),1,struct('seedmode',[-2],'display','off'));

a2.img = make_nii(results.ang,[1.60 1.60 1.60]);
save_nii(a2.img,'polarAngle2.nii.gz');
results.ang = [];

a2.img = make_nii(results.ecc,[1.60 1.60 1.60]);
save_nii(a2.img,'eccentricity2.nii.gz');
results.ecc = [];

a2.img = make_nii(results.expt,[1.60 1.60 1.60]);
save_nii(a2.img,'exponent2.nii.gz');
results.expt = [];

a2.img = make_nii(results.rfsize,[1.60 1.60 1.60]);
save_nii(a2.img,'rfWidth2.nii.gz');
results.rfsize = [];

a2.img = make_nii(results.R2,[1.60 1.60 1.60]);
save_nii(a2.img,'r22.nii.gz');
results.R2 = [];

a2.img = make_nii(results.gain,[1.60 1.60 1.60]);
save_nii(a2.img,'gain2.nii.gz');
results.gain = [];

a2.img = make_nii(results.meanvol,[1.60 1.60 1.60]);
save_nii(a2.img,'meanvol2.nii.gz');
results.meanvol = [];

results = analyzePRF(stimulus,data{1}(:,71:105,:,:),1,struct('seedmode',[-2],'display','off'));

a2.img = make_nii(results.ang,[1.60 1.60 1.60]);
save_nii(a2.img,'polarAngle3.nii.gz');
results.ang = [];

a2.img = make_nii(results.ecc,[1.60 1.60 1.60]);
save_nii(a2.img,'eccentricity3.nii.gz');
results.ecc = [];

a2.img = make_nii(results.expt,[1.60 1.60 1.60]);
save_nii(a2.img,'exponent3.nii.gz');
results.expt = [];

a2.img = make_nii(results.rfsize,[1.60 1.60 1.60]);
save_nii(a2.img,'rfWidth3.nii.gz');
results.rfsize = [];

a2.img = make_nii(results.R2,[1.60 1.60 1.60]);
save_nii(a2.img,'r23.nii.gz');
results.R2 = [];

a2.img = make_nii(results.gain,[1.60 1.60 1.60]);
save_nii(a2.img,'gain3.nii.gz');
results.gain = [];

a2.img = make_nii(results.meanvol,[1.60 1.60 1.60]);
save_nii(a2.img,'meanvol3.nii.gz');
results.meanvol = [];

results = analyzePRF(stimulus,data{1}(:,106:136,:,:),1,struct('seedmode',[-2],'display','off'));

a2.img = make_nii(results.ang,[1.60 1.60 1.60]);
save_nii(a2.img,'polarAngle4.nii.gz');
results.ang = [];

a2.img = make_nii(results.ecc,[1.60 1.60 1.60]);
save_nii(a2.img,'eccentricity4.nii.gz');
results.ecc = [];

a2.img = make_nii(results.expt,[1.60 1.60 1.60]);
save_nii(a2.img,'exponent4.nii.gz');
results.expt = [];

a2.img = make_nii(results.rfsize,[1.60 1.60 1.60]);
save_nii(a2.img,'rfWidth4.nii.gz');
results.rfsize = [];

a2.img = make_nii(results.R2,[1.60 1.60 1.60]);
save_nii(a2.img,'r24.nii.gz');
results.R2 = [];

a2.img = make_nii(results.gain,[1.60 1.60 1.60]);
save_nii(a2.img,'gain4.nii.gz');
results.gain = [];

a2.img = make_nii(results.meanvol,[1.60 1.60 1.60]);
save_nii(a2.img,'meanvol4.nii.gz');
results.meanvol = [];

%text = jsonencode(results);
%fid = fopen('product.json','w');
%fprintf(fid,'%s',text);
%fclose(fid);
%%
mkdir('prf');
cd 'prf'
a1 = load_untouch_nii('polarAngle1.nii.gz');
a2 = load_untouch_nii('polarAngle2.nii.gz');
a3 = load_untouch_nii('polarAngle3.nii.gz');
a4 = load_untouch_nii('polarAngle4.nii.gz');
data3 = cat(4,double(a1.img),double(a2.img),double(a3.img),double(a4.img))

a2.img = make_nii(data3,[1.60 1.60 1.60])
save_nii(a2.img,'polarAngle.nii.gz')
delete 'polarAngle1.nii.gz' 'polarAngle2.nii.gz' 'polarAngle3.nii.gz' 'polarAngle4.nii.gz'

cd ..
% Note that because of the use of parfor, the command-window output for different
% voxels will come in at different times (and so the text above is not really
% readable).

%% Inspect the results

% The stimulus is 100 pixels (in both height and weight), and this corresponds to
% 10 degrees of visual angle.  To convert from pixels to degreees, we multiply
% by 10/100.
% cfactor = 10/100;
%
% % Visualize the location of each voxel's pRF
% figure; hold on;
% set(gcf,'Units','points','Position',[100 100 400 400]);
% cmap = jet(size(results.ang,1))
% for p=1:size(results.ang,1)
%   xpos = results.ecc(p) * cos(results.ang(p)/180*pi) * cfactor;
%   ypos = results.ecc(p) * sin(results.ang(p)/180*pi) * cfactor;
%   ang = results.ang(p)/180*pi;
%   sd = results.rfsize(p) * cfactor;
%   h = drawellipse(xpos,ypos,ang,2*sd,2*sd);  % circle at +/- 2 pRF sizes
%   set(h,'Color',cmap(p,:),'LineWidth',2);
%   set(scatter(xpos,ypos,'r.'),'CData',cmap(p,:));
% end
% drawrectangle(0,0,10,10,'k-');  % square indicating stimulus extent
% axis([-10 10 -10 10]);
% straightline(0,'h','k-');       % line indicating horizontal meridian
% straightline(0,'v','k-');       % line indicating vertical meridian
% axis square;
% set(gca,'XTick',-10:2:10,'YTick',-10:2:10);
% xlabel('X-position (deg)');
% ylabel('Y-position (deg)');
% %%

% Please see the example2.m script for an example of how to inspect the model fit
% and compare it to the data.
