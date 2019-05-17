#!/bin/bash

for i in 'polarAngle' 'eccentricity' 'exponent' 'rfWidth' 'r2' 'gain' 'meanvol';
do gunzip -k ./"$i".nii.gz && nifti_tool -mod_hdr -prefix ./"$i"_aligned.nii -mod_field srow_x '-1.6 0 0 90' -mod_field srow_y '0 1.6 0 -126' -mod_field srow_z '0 0 1.60 -72' -infiles ./"$i".nii
done

#gunzip -k ./results.nii.gz && nifti_tool -mod_hdr -prefix ./results_aligned.nii -mod_field srow_x '-1.6 0 0 90' -mod_field srow_y '0 1.6 0 -126' -mod_field srow_z '0 0 1.60 -72' -infiles ./results.nii
