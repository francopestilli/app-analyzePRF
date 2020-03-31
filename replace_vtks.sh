#!/bin/bash

for i in pial white inflated sphere
do
for hemi in lh rh
do
rm prf/surfaces/${hemi}.${i}.vtk
cp /N/u/davhunt/Carbonate/Downloads/Bradley_prf/surfaces/${hemi}.${i}.gii prf/surfaces/${hemi}.${i}.gii
mris_convert prf/surfaces/${hemi}.${i}.gii prf/surfaces/${hemi}.${i}.vtk
done
done
