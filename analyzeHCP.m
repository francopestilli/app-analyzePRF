function analyzeHCP(fmri,stim)

data = {};
a1 = load_untouch_nii(fmri);
data{1} = double(a1.img);

stimulus = {};
a1 = load_untouch_nii(stim);
stimulus{1} = double(a1.img);

size(data{1})

%try
%    if (matlabpool('size')==0) matlabpool; end
%catch
%    if isempty(gcp('nocreate')) parpool; end
%end

mkdir('prf');
cd 'prf'

batchResults = struct;

% batch time-series into 10 / 11 parts to save v memory
k = floor(size(data{1},1)/10);
rmndr = mod(size(data{1},1),k);
split = ones(1,k)*10;
if rmndr ~= 0
  split = [split, rmndr];
else
  split = [split];
end

batched_len = size(split, 2);

batched = mat2cell(data{1},split,[size(data{1},2)],[size(data{1},3)],[size(data{1},4)]);

clearvars data;

for i = 1:batched_len
results = analyzePRF(stimulus,batched{i}(:,:,:,:),1,struct('seedmode',[-2],'display','off'));
% etc
a2.img = make_nii(results.ang,[1.60 1.60 1.60]);
save_nii(a2.img,['polarAngle_' num2str(i) '.nii.gz']);
batchResults.(['ang_' num2str(i)]) = results.ang;

a2.img = make_nii(results.ecc,[1.60 1.60 1.60]);
save_nii(a2.img,['eccentricity_' num2str(i) '.nii.gz']);
batchResults.(['ecc_' num2str(i)]) = results.ecc;

a2.img = make_nii(results.expt,[1.60 1.60 1.60]);
save_nii(a2.img,['exponent_' num2str(i) '.nii.gz']);
batchResults.(['expt_' num2str(i)]) = results.expt;

a2.img = make_nii(results.rfsize,[1.60 1.60 1.60]);
save_nii(a2.img,['rfWidth_' num2str(i) '.nii.gz']);
batchResults.(['rfWidth_' num2str(i)]) = results.rfsize;

a2.img = make_nii(results.R2,[1.60 1.60 1.60]);
save_nii(a2.img,['r2_' num2str(i) '.nii.gz']);
batchResults.(['r2_' num2str(i)]) = results.R2;

a2.img = make_nii(results.gain,[1.60 1.60 1.60]);
save_nii(a2.img,['gain_' num2str(i) '.nii.gz']);
batchResults.(['gain_' num2str(i)]) = results.gain;

a2.img = make_nii(results.meanvol,[1.60 1.60 1.60]);
save_nii(a2.img,['meanvol_' num2str(i) '.nii.gz']);
batchResults.(['meanvol_' num2str(i)]) = results.meanvol;

end


for str = {'polarAngle','eccentricity','exponent','rfWidth','r2','gain','meanvol'}
  img = struct;
  data2 = [];
  for i = 1:batched_len
    img.(['a' num2str(i)]) = load_untouch_nii(strcat(str{1},'_',num2str(i),'.nii.gz'));
    data2 = cat(1,data2,double(img.(['a' num2str(i)]).img));
  nii.img = make_nii(data2,[1.60 1.60 1.60]);
  save_nii(nii.img,strcat(str{1},'.nii.gz'));
  end
  for i = 1:batched_len
    delete(strcat(str{1},'_',num2str(i),'.nii.gz'));
  end
end

cd ..

results.ang = [];
results.ecc = [];
results.expt = [];
results.rfWidth = [];
results.r2 = [];
results.gain = [];
results.meanvol = [];



for i = 1:batched_len
results.ang = cat(1,results.ang,batchResults.(['ang_' num2str(i)]));
results.ecc = cat(1,results.ecc,batchResults.(['ecc_' num2str(i)]));
results.expt = cat(1,results.expt,batchResults.(['expt_' num2str(i)]));
results.rfWidth = cat(1,results.rfWidth,batchResults.(['rfWidth_' num2str(i)]));
results.r2 = cat(1,results.r2,batchResults.(['r2_' num2str(i)]));
results.gain = cat(1,results.gain,batchResults.(['gain_' num2str(i)]));
results.meanvol = cat(1,results.meanvol,batchResults.(['meanvol_' num2str(i)]));
end
    
json = jsonencode(struct('polarAngle',results.ang,'eccentricity',results.ecc,'exponent',results.expt, ...
'rfWidth',results.rfWidth,'r2',results.r2,'gain',results.gain,'meanvol',results.meanvol));
fileID = fopen('product.json','w')
fprintf(fileID,json)
fclose(fileID)

% The stimulus is 100 pixels (in both height and weight), and this corresponds to
% 10 degrees of visual angle.  To convert from pixels to degreees, we multiply
% by 10/100.
% cfactor = 10/100;
