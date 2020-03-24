#!/bin/bash

for i in 'polarAngle' 'eccentricity' 'exponent' 'rfWidth' 'r2' 'gain' 'meanvol';
do gunzip -k ./prf/"$i".nii.gz && nifti_tool -mod_hdr -prefix ./prf/"$i"_aligned.nii -mod_field srow_x '-1.6 0 0 90' -mod_field srow_y '0 1.6 0 -126' -mod_field srow_z '0 0 1.60 -72' -infiles ./prf/"$i".nii
gzip ./prf/"$i"_aligned.nii && mv ./prf/"$i"_aligned.nii.gz ./prf/"$i".nii.gz
done



#gunzip -k ./results.nii.gz && nifti_tool -mod_hdr -prefix ./results_aligned.nii -mod_field srow_x '-1.6 0 0 90' -mod_field srow_y '0 1.6 0 -126' -mod_field srow_z '0 0 1.60 -72' -infiles ./results.nii
