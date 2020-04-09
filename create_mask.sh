#!/bin/bash

fslroi ${2} fMRI_slice.nii.gz 0 1 # extract first (t=0) volume from fMRI

flirt -in ${1}/mri/T1.nii.gz -ref fMRI_slice.nii.gz -out fs2func.nii.gz -omat fs2func.mat # register T1 to fMRI

fslmaths ${1}/mri/rh.ribbon.nii.gz -add ${1}/mri/lh.ribbon.nii.gz ${1}/mri/rh+lh.ribbon.nii.gz # combine rh+lh ribbons

flirt -in ${1}/mri/rh+lh.ribbon.nii.gz -ref fs2func.nii.gz -out prob_mask.nii.gz -init fs2func.mat -applyxfm # create probabilistic mask

fslmaths prob_mask.nii.gz -thr 0.3 -bin mask.nii.gz # threshold to create mask
