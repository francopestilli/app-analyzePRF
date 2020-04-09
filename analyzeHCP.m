function analyzeHCP(fmri,stim,mask)

% Load fMRI data
data = [];
nii = load_untouch_nii(fmri);
data = double(nii.img);

% Load stimulation files
stimulus = {};
a1 = load_untouch_nii(stim);
stimulus{1} = double(a1.img);

pxtodeg = 16.0/200;

% Generate a directory to save the data.
mkdir('prf');

maskBool = {};
maskedData = [];
a1 = load_untouch_nii(mask);
maskBool{1} = double(a1.img);

for i = 1:size(data,1)
  for j = 1:size(data,2)
    for k = 1:size(data,3)
      if maskBool{1}(i,j,k) >= 1.0
         maskBool{1}(i,j,k) = 1.0;	% create binary mask
      end
    end
  end
end

[r,c,v] = ind2sub(size(maskBool{1}),find(maskBool{1}));

maskedData = [];
for i = 1:size(r,1)
  maskedData = [maskedData; data(r(i),c(i),v(i),:)];
end

maskBool{1} = logical(maskBool{1});
maskedData = squeeze(maskedData);

% Save out results into local directory
save('maskedData.mat','maskedData','maskBool','stimulus');
results = analyzePRF(stimulus,maskedData,1,struct('seedmode',[-2],'display','off'));

% one final modification to the outputs:
% whenever eccentricity is exactly 0, we set polar angle to NaN since it is ill-defined.
results.ang(results.ecc(:)==0) = NaN;

[polarAngle, eccentricity, expt, rfWidth, r2, gain, meanvol] = deal(zeros(size(data,1), size(data,2), size(data,3)));

m = 1;
for k = 1:size(maskBool{1},3)
  for j = 1:size(maskBool{1},2)
    for i = 1:size(maskBool{1},1)
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

nii.hdr.dime.dim(1) = 3;
nii.hdr.dime.dim(5) = 1;
nii.hdr.dime.datatype = 64; %FLOAT64 img
nii.hdr.dime.bitpix = 64;


nii.img = polarAngle;
save_untouch_nii(nii,['prf/polarAngle.nii.gz']);

nii.img = eccentricity;
save_untouch_nii(nii,['prf/eccentricity.nii.gz']);

nii.img = expt;
save_untouch_nii(nii,['prf/exponent.nii.gz']);

nii.img = rfWidth;
save_untouch_nii(nii,['prf/rfWidth.nii.gz']);

nii.img = r2;
save_untouch_nii(nii,['prf/r2.nii.gz']);

nii.img = gain;
save_untouch_nii(nii,['prf/gain.nii.gz']);

nii.img = meanvol;
save_untouch_nii(nii,['prf/meanvol.nii.gz']);

clearvars results;

end

% The stimulus is 100 pixels (in both height and weight), and this corresponds to
% 10 degrees of visual angle.  To convert from pixels to degreees, we multiply
% by 10/100.
% cfactor = 10/100;
