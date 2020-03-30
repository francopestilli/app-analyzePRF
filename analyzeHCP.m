function analyzeHCP(fmri,stim,mask)

data = {};
a1 = load_untouch_nii(fmri);
data{1} = double(a1.img);

stimulus = {};
a1 = load_untouch_nii(stim);
stimulus{1} = double(a1.img);

pxtodeg = 16.0/200;

%size(data{1})

%try
%    if (matlabpool('size')==0) matlabpool; end
%catch
%    if isempty(gcp('nocreate')) parpool; end
%end

mkdir('prf');
%cd 'prf'

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

%batched = mat2cell(data{1},split,[size(data{1},2)],[size(data{1},3)],[size(data{1},4)]);

%clearvars data;



maskBool = {};
maskedData = [];
a1 = load_untouch_nii(mask);
maskBool{1} = double(a1.img);

%for i = 1:size(maskBool{1},1)
%  for j = 1:size(maskBool{1},2)
%    for k = 1:size(maskBool{1},3)
%      if maskBool{1}(i,j,k) >= 1.0
%        maskedData = [maskedData; data{1}(i,j,k,:)];
%      end
%    end
%  end
%end

for i = 1:size(data{1},1)
  for j = 1:size(data{1},2)
    for k = 1:size(data{1},3)
%      if data{1}(i,j,k) == 0.0
%        data{1}(i,j,k) = 0.001;		% make sure no zeros in data so we can remove them
      if maskBool{1}(i,j,k) >= 1.0
        maskBool{1}(i,j,k) = 1.0;	% create binary mask
      end
    end
  end
end

[r,c,v] = ind2sub(size(maskBool{1}),find(maskBool{1}));

maskedData = [];
for i = 1:size(r,1)
  maskedData = [maskedData; data{1}(r(i),c(i),v(i),:)];
end

maskBool{1} = logical(maskBool{1});

%maskedData = maskBool{1}.*data{1}; % combine mask and data
%maskedData = maskedData(maskedData>0);
%numVoxels = size(maskedData)/size(data{1},4);

%maskedData = reshape(maskedData,[],numVoxels,size(data{1},4));





maskedData = squeeze(maskedData);



%for i = 1:batched_len
%results = analyzePRF(stimulus,batched{i}(:,:,:,:),1,struct('seedmode',[-2],'display','off'));
results = analyzePRF(stimulus,maskedData(:,:),1,struct('seedmode',[-2],'display','off'));
% etc


% one final modification to the outputs:
% whenever eccentricity is exactly 0, we set polar angle to NaN since it is ill-defined.
%allresults = squish(permute(allresults,[1 3 4 2]),3);  % 91282*184*3 x 6
%allresults = squish(permute(allresults,[1 3 4 2]),1);
results.ang(results.ecc(:)==0) = NaN;
%allresults = permute(reshape(allresults,[91282 184 3 6]),[1 4 2 3]);
%allresults = permute(reshape(allresults,[59412 1 1 6]),[1 4 2 3]);
%allresults = permute(reshape(allresults,[totalVertices 1 1 6]),[1 4 2 3]);



[polarAngle, eccentricity, expt, rfWidth, r2, gain, meanvol] = deal(zeros(size(data{1},1), size(data{1},2), size(data{1},3)));

m = 1;
for i = 1:size(maskBool{1},1)
  for j = 1:size(maskBool{1},2)
    for k = 1:size(maskBool{1},3)
      if maskBool{1}(i,j,k) >= 1.0
        polarAngle(i,j,k) = results.ang(m);
        eccentricity(i,j,k) = results.ecc(m)*pxtodeg;
        expt(i,j,k) = results.expt(m);
        rfWidth(i,j,k) = results.rfsize(m)*pxtodeg;
        r2(i,j,k) = results.R2(m);
        gain(i,j,k) = results.gain(m);
        meanvol(i,j,k) = results.meanvol(m);
        m = m+1; % increment to total voxels in mask
      else
        [polarAngle(i,j,k), eccentricity(i,j,k), expt(i,j,k), rfWidth(i,j,k), r2(i,j,k), gain(i,j,k), meanvol(i,j,k)] = deal(NaN);
      end
    end
  end
end




res = 2.0;




%a2.img = make_nii(results.ang,[res res res]);
a2.img = make_nii(polarAngle,[res res res]);
save_nii(a2.img,['prf/polarAngle.nii.gz']);
%save_nii(a2.img,['polarAngle_' num2str(i) '.nii.gz']);
%batchResults.(['ang_' num2str(i)]) = results.ang;

%a2.img = make_nii(results.ecc,[res res res]);
a2.img = make_nii(eccentricity,[res res res]);
save_nii(a2.img,['prf/eccentricity.nii.gz']);
%save_nii(a2.img,['eccentricity_' num2str(i) '.nii.gz']);
%batchResults.(['ecc_' num2str(i)]) = results.ecc;

%a2.img = make_nii(results.expt,[res res res]);
a2.img = make_nii(expt,[res res res]);
save_nii(a2.img,['prf/exponent.nii.gz']);
%save_nii(a2.img,['exponent_' num2str(i) '.nii.gz']);
%batchResults.(['expt_' num2str(i)]) = results.expt;

%a2.img = make_nii(results.rfsize,[res res res]);
a2.img = make_nii(rfWidth,[res res res]);
save_nii(a2.img,['prf/rfWidth.nii.gz']);
%save_nii(a2.img,['rfWidth_' num2str(i) '.nii.gz']);
%batchResults.(['rfWidth_' num2str(i)]) = results.rfsize;

%a2.img = make_nii(results.R2,[res res res]);
a2.img = make_nii(r2,[res res res]);
save_nii(a2.img,['prf/r2.nii.gz']);
%save_nii(a2.img,['r2_' num2str(i) '.nii.gz']);
%batchResults.(['r2_' num2str(i)]) = results.R2;

%a2.img = make_nii(results.gain,[res res res]);
a2.img = make_nii(gain,[res res res]);
save_nii(a2.img,['prf/gain.nii.gz']);
%save_nii(a2.img,['gain_' num2str(i) '.nii.gz']);
%batchResults.(['gain_' num2str(i)]) = results.gain;

%a2.img = make_nii(results.meanvol,[res res res]);
a2.img = make_nii(meanvol,[res res res]);
save_nii(a2.img,['prf/meanvol.nii.gz']);
%save_nii(a2.img,['meanvol_' num2str(i) '.nii.gz']);
%batchResults.(['meanvol_' num2str(i)]) = results.meanvol;

clearvars results;

end


%for str = {'polarAngle','eccentricity','exponent','rfWidth','r2','gain','meanvol'}
%  img = struct;
%  data2 = [];
%  for i = 1:batched_len
%    img.(['a' num2str(i)]) = load_untouch_nii(strcat(str{1},'_',num2str(i),'.nii.gz'));
%    data2 = cat(1,data2,double(img.(['a' num2str(i)]).img));
%  nii.img = make_nii(data2,[1.60 1.60 1.60]);
%  save_nii(nii.img,strcat(str{1},'.nii.gz'));
%  end
%  for i = 1:batched_len
%    delete(strcat(str{1},'_',num2str(i),'.nii.gz'));
%  end
%end

%cd ..

%results.ang = [];
%results.ecc = [];
%results.expt = [];
%results.rfWidth = [];
%results.r2 = [];
%results.gain = [];
%results.meanvol = [];
%
%
%
%for i = 1:batched_len
%results.ang = cat(1,results.ang,batchResults.(['ang_' num2str(i)]));
%results.ecc = cat(1,results.ecc,batchResults.(['ecc_' num2str(i)]));
%results.expt = cat(1,results.expt,batchResults.(['expt_' num2str(i)]));
%results.rfWidth = cat(1,results.rfWidth,batchResults.(['rfWidth_' num2str(i)]));
%results.r2 = cat(1,results.r2,batchResults.(['r2_' num2str(i)]));
%results.gain = cat(1,results.gain,batchResults.(['gain_' num2str(i)]));
%results.meanvol = cat(1,results.meanvol,batchResults.(['meanvol_' num2str(i)]));
%end
%    
%json = jsonencode(struct('polarAngle',results.ang,'eccentricity',results.ecc,'exponent',results.expt, ...
%'rfWidth',results.rfWidth,'r2',results.r2,'gain',results.gain,'meanvol',results.meanvol));
%fileID = fopen('product.json','w')
%fprintf(fileID,json)
%fclose(fileID)

% The stimulus is 100 pixels (in both height and weight), and this corresponds to
% 10 degrees of visual angle.  To convert from pixels to degreees, we multiply
% by 10/100.
% cfactor = 10/100;
