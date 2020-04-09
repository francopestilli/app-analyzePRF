function [] = avg_images(frameorder, maskimages)

avgd_im = [];
for tr = 1:300
  A = frameorder(2,tr*15-14:tr*15);
  resizedimages = {};
  for i = 1:(size(A,2))
    if A(i) == 0
      resizedimages{i} = zeros(200,200);
    else
      resizedimages{i} = imresize(maskimages(:,:,A(i)), [200 200]);
%      resizedimages{i} = round(imresize(maskimages(:,:,A(i)), [200 200]));
    end
  end
%  avg = round(single(mean(cat(3,resizedimages{:}),3)),0);
  avg = round(single(mean(cat(3,resizedimages{:}),3)));
  
  avgd_im = cat(3,avgd_im,avg);

end

stim = avgd_im;
save('./apertures/RETBARsmall.mat','stim')

end
