function analyzeHCP(fmri,stim)

data = {};
a1 = load_untouch_nii(fmri);
data{1} = double(a1.img);

stimulus = {};
a1 = load_untouch_nii(stim);
stimulus{1} = double(a1.img);

data

%try
%    if (matlabpool('size')==0) matlabpool; end
%catch
%    if isempty(gcp('nocreate')) parpool; end
%end

mkdir('prf');
cd 'prf'

results = analyzePRF(stimulus,data{1}(:,1:35,:,:),1,struct('seedmode',[-2],'display','off'));

a2.img = make_nii(results.ang,[1.60 1.60 1.60]);
save_nii(a2.img,'polarAngle1.nii.gz');
results.ang1 = results.ang;
results.ang = [];

a2.img = make_nii(results.ecc,[1.60 1.60 1.60]);
save_nii(a2.img,'eccentricity1.nii.gz');
results.ecc1 = results.ecc;
results.ecc = [];

a2.img = make_nii(results.expt,[1.60 1.60 1.60]);
save_nii(a2.img,'exponent1.nii.gz');
results.expt1 = results.expt;
results.expt = [];

a2.img = make_nii(results.rfsize,[1.60 1.60 1.60]);
save_nii(a2.img,'rfWidth1.nii.gz');
results.rfsize1 = results.rfsize;
results.rfsize = [];

a2.img = make_nii(results.R2,[1.60 1.60 1.60]);
save_nii(a2.img,'r21.nii.gz');
results.R21 = results.R2;
results.R2 = [];

a2.img = make_nii(results.gain,[1.60 1.60 1.60]);
save_nii(a2.img,'gain1.nii.gz');
results.gain1 = results.gain;
results.gain = [];

a2.img = make_nii(results.meanvol,[1.60 1.60 1.60]);
save_nii(a2.img,'meanvol1.nii.gz');
results.meanvol1 = results.meanvol;
results.meanvol = [];

results = analyzePRF(stimulus,data{1}(:,36:70,:,:),1,struct('seedmode',[-2],'display','off'));

a2.img = make_nii(results.ang,[1.60 1.60 1.60]);
save_nii(a2.img,'polarAngle2.nii.gz');
results.ang2 = results.ang;
results.ang = [];

a2.img = make_nii(results.ecc,[1.60 1.60 1.60]);
save_nii(a2.img,'eccentricity2.nii.gz');
results.ecc2 = results.ecc;
results.ecc = [];

a2.img = make_nii(results.expt,[1.60 1.60 1.60]);
save_nii(a2.img,'exponent2.nii.gz');
results.expt2 = results.expt;
results.expt = [];

a2.img = make_nii(results.rfsize,[1.60 1.60 1.60]);
save_nii(a2.img,'rfWidth2.nii.gz');
results.rfsize2 = results.rfsize;
results.rfsize = [];

a2.img = make_nii(results.R2,[1.60 1.60 1.60]);
save_nii(a2.img,'r22.nii.gz');
results.R22 = results.R2;
results.R2 = [];

a2.img = make_nii(results.gain,[1.60 1.60 1.60]);
save_nii(a2.img,'gain2.nii.gz');
results.gain2 = results.gain;
results.gain = [];

a2.img = make_nii(results.meanvol,[1.60 1.60 1.60]);
save_nii(a2.img,'meanvol2.nii.gz');
results.meanvol2 = results.meanvol;
results.meanvol = [];

results = analyzePRF(stimulus,data{1}(:,71:105,:,:),1,struct('seedmode',[-2],'display','off'));

a2.img = make_nii(results.ang,[1.60 1.60 1.60]);
save_nii(a2.img,'polarAngle3.nii.gz');
results.ang3 = results.ang;
results.ang = [];

a2.img = make_nii(results.ecc,[1.60 1.60 1.60]);
save_nii(a2.img,'eccentricity3.nii.gz');
results.ecc3 = results.ecc;
results.ecc = [];

a2.img = make_nii(results.expt,[1.60 1.60 1.60]);
save_nii(a2.img,'exponent3.nii.gz');
results.expt3 = results.expt;
results.expt = [];

a2.img = make_nii(results.rfsize,[1.60 1.60 1.60]);
save_nii(a2.img,'rfWidth3.nii.gz');
results.rfsize3 = results.rfsize;
results.rfsize = [];

a2.img = make_nii(results.R2,[1.60 1.60 1.60]);
save_nii(a2.img,'r23.nii.gz');
results.R23 = results.R2;
results.R2 = [];

a2.img = make_nii(results.gain,[1.60 1.60 1.60]);
save_nii(a2.img,'gain3.nii.gz');
results.gain3 = results.gain;
results.gain = [];

a2.img = make_nii(results.meanvol,[1.60 1.60 1.60]);
save_nii(a2.img,'meanvol3.nii.gz');
results.meanvol3 = results.meanvol;
results.meanvol = [];

results = analyzePRF(stimulus,data{1}(:,106:136,:,:),1,struct('seedmode',[-2],'display','off'));

a2.img = make_nii(results.ang,[1.60 1.60 1.60]);
save_nii(a2.img,'polarAngle4.nii.gz');
results.ang4 = results.ang;
results.ang = [];

a2.img = make_nii(results.ecc,[1.60 1.60 1.60]);
save_nii(a2.img,'eccentricity4.nii.gz');
results.ecc4 = results.ecc;
results.ecc = [];

a2.img = make_nii(results.expt,[1.60 1.60 1.60]);
save_nii(a2.img,'exponent4.nii.gz');
results.expt4 = results.expt;
results.expt = [];

a2.img = make_nii(results.rfsize,[1.60 1.60 1.60]);
save_nii(a2.img,'rfWidth4.nii.gz');
results.rfsize4 = results.rfsize;
results.rfsize = [];

a2.img = make_nii(results.R2,[1.60 1.60 1.60]);
save_nii(a2.img,'r24.nii.gz');
results.R24 = results.R2;
results.R2 = [];

a2.img = make_nii(results.gain,[1.60 1.60 1.60]);
save_nii(a2.img,'gain4.nii.gz');
results.gain4 = results.gain;
results.gain = [];

a2.img = make_nii(results.meanvol,[1.60 1.60 1.60]);
save_nii(a2.img,'meanvol4.nii.gz');
results.meanvol4 = results.meanvol;
results.meanvol = [];

for str = {'polarAngle','eccentricity','exponent','rfWidth','r2','gain','meanvol'}
  a1 = load_untouch_nii(strcat(str{1},'1.nii.gz'));
  a2 = load_untouch_nii(strcat(str{1},'2.nii.gz'));
  a3 = load_untouch_nii(strcat(str{1},'3.nii.gz'));
  a4 = load_untouch_nii(strcat(str{1},'4.nii.gz'));
  data3 = cat(2,double(a1.img),double(a2.img),double(a3.img),double(a4.img))

  a2.img = make_nii(data3,[1.60 1.60 1.60]);
  save_nii(a2.img,strcat(str{1},'.nii.gz'))
  delete(strcat(str{1},'1.nii.gz'));
  delete(strcat(str{1},'2.nii.gz'));
  delete(strcat(str{1},'3.nii.gz'));
  delete(strcat(str{1},'4.nii.gz'));
end

cd ..

results.ang = cat(2,results.ang1,results.ang2,results.ang3,results.ang4);
results.ecc = cat(2,results.ecc1,results.ecc2,results.ecc3,results.ecc4);
results.rfsize = cat(2,results.rfsize1,results.rfsize2,results.rfsize3,results.rfsize4);
results.R2 = cat(2,results.R21,results.R22,results.R23,results.R24);
results.gain = cat(2,results.gain1,results.gain2,results.gain3,results.gain4);
results.meanvol = cat(2,results.meanvol1,results.meanvol2,results.meanvol3,results.meanvol4);
    
json = jsonencode(struct('polarAngle',results.ang,'eccentricity',results.ecc,'rfWidth',results.rfsize,'r2',results.R2,'gain',results.gain,'meanvol',results.meanvol));
fileID = fopen('product.json','w')
fprintf(fileID,json)
fclose(fileID)

% The stimulus is 100 pixels (in both height and weight), and this corresponds to
% 10 degrees of visual angle.  To convert from pixels to degreees, we multiply
% by 10/100.
% cfactor = 10/100;
