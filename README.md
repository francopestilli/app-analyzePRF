[![Abcdspec-compliant](https://img.shields.io/badge/ABCD_Spec-v1.1-green.svg)](https://github.com/brain-life/abcd-spec)
[![Run on Brainlife.io](https://img.shields.io/badge/Brainlife-bl.app.1-blue.svg)](https://doi.org/10.25663/bl.app.1)

# app-example-documentation

This app takes the time-series fMRI data of an individual HCP 7T subject (bold.nii.gz), and performs a retinotopic analysis of the subject's visual response to particular stimuli (stim.nii.gz).  Visually responsive voxels (or grayordinates) are analyzed and properties of each grayordinate is extracted from the fMRI data.  Visual response properties include the grayordinate's receptive field angle, eccentricity, and size, as well as the (typically compressive) exponent of the Gaussian used to model the receptive field's visual response contrast, the gain describing the pRF model, the variance explained by the model, and the mean signal intensity.

[![pRF parameters](https://raw.githubusercontent.com/davhunt/pictures/master/Screenshot%20from%202019-04-17%2014-41-11.png)

See here for details (https://www.biorxiv.org/content/10.1101/308247v2)

### Authors
- Kendrick Kay (kendrick@post.harvard.edu)
- David Hunt (davhunt@indiana.edu)

### Project director
- Franco Pestilli (franpest@indiana.edu)

### Funding 
[![NSF-BCS-1734853](https://img.shields.io/badge/NSF_BCS-1734853-blue.svg)](https://nsf.gov/awardsearch/showAward?AWD_ID=1734853)
[![NSF-BCS-1636893](https://img.shields.io/badge/NSF_BCS-1636893-blue.svg)](https://nsf.gov/awardsearch/showAward?AWD_ID=1636893)

## Running the App 

analyzePRF is a MATLAB toolbox for fitting population receptive field (pRF) models
to fMRI data.  It is developed by Kendrick Kay (kendrick@post.harvard.edu).

The toolbox has several dependencies:
- MATLAB Optimization Toolbox
- GLMdenoise (necessary only if you use the GLMdenoise feature; to download
              GLMdenoise, see http://kendrickkay.net/GLMdenoise/)

To use the toolbox, add it to your MATLAB path:
  addpath(genpath('analyzePRF'));

To try the toolbox on an example dataset, change to the analyzePRF directory 
and then type:
  example1;
This script will download the example dataset (if it has not already been
downloaded) and will run the toolbox on the dataset.

For additional information, please visit:
  http://kendrickkay.net/analyzePRF/

Terms of use: This content is licensed under a Creative Commons Attribution 3.0 
Unported License (http://creativecommons.org/licenses/by/3.0/us/). You are free 
to share and adapt the content as you please, under the condition that you cite 
the appropriate manuscript (see below).

If you use analyzePRF in your research, please cite the following paper:
  Kay KN, Winawer J, Mezer A and Wandell BA (2013) 
    Compressive spatial summation in human visual cortex.
    J. Neurophys. doi: 10.1152/jn.00105.2013

History of major code changes:
- 2014/06/17 - Version 1.1.

## CONTENTS

Contents:
- analyzeHCP.m - Matlab script calling analyzePRF.m for HCP data
- analyzePRF.m - Top-level function that you want to call
- analyzePRFcomputeGLMdenoiseregressors.m - Helper function
- analyzePRFcomputesupergridseeds.m - Helper function
- example*.m - Example scripts
- exampledataset.mat - Example dataset
- README - The file you are reading
- setup.m - A simple script that downloads the example dataset
            and adds analyzePRF to the MATLAB path
- utilities - A directory containing various utility functions

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Copyright (c) 2014, Kendrick Kay
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

Redistributions of source code must retain the above copyright notice, this
list of conditions and the following disclaimer.

Redistributions in binary form must reproduce the above copyright notice, this
list of conditions and the following disclaimer in the documentation and/or
other materials provided with the distribution.

The names of its contributors may not be used to endorse or promote products 
derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

### On Brainlife.io

You can submit this App online at [https://doi.org/10.25663/brainlife.app.177](https://doi.org/10.25663/brainlife.app.177) via the "Execute" tab.

### Running Locally (on your machine)

1. git clone this repo.
2. Inside the cloned directory, create `config.json` with something like the following content with paths to your input files.

```json
{
    "fmri": "./input/fmri/bold.nii.gz",
    "stim": "./input/stimulus/stim.nii.gz"
}
```

3. Launch the App by executing `main`

```bash
./main
```

### Sample Datasets

If you don't have your own input file, you can download sample datasets from Brainlife.io, or you can use [Brainlife CLI](https://github.com/brain-life/cli).

```
npm install -g brainlife
bl login
mkdir input
bl dataset download 5a0e604116e499548135de87 && mv 5a0e604116e499548135de87 input/track
bl dataset download 5a0dcb1216e499548135dd27 && mv 5a0dcb1216e499548135dd27 input/dtiinit
```

## Output

All output files will be generated under the current working directory (pwd). The main output of this App is a NifTi file 'results.nii.gz' that contains, as the 4th dimension, the angle, eccentricity, exponent, receptive field size, R2, gain, and mean volume of each grayordinate.

#### Product.json

The secondary output of this app is `product.json`. This file allows web interfaces, DB and API calls on the results of the processing.  It contains the same information as the NifTi (results.ang, results.ecc, results.expt, results.rfsize, results.R2, results.gain, results.meanvol).

### Dependencies

This App only requires [singularity](https://www.sylabs.io/singularity/) to run. If you don't have singularity, you will need to install following dependencies.  

  - Matlab: https://www.mathworks.com/products/matlab.html
  - jsonlab: https://www.mathworks.com/matlabcentral/fileexchange/33381-jsonlab-a-toolbox-to-encode-decode-json-files
  - VISTASOFT: https://github.com/vistalab/vistasoft/
