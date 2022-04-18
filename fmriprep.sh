#!/bin/sh
set -o exiterr

bidsdir=/bidsdir
subjinfo=/
fslicense=$FREESURFER_HOME/license.txt
workingdir=$bidsdir/$(mkdir -p $bidsdir/fmriprep_wd; echo 'fmriprep_wd')
subjs=$(cat $subjinfo | wc -l)
nthreads=40

echo "======================================"
echo "You have $subjs subjects to processing!"
echo "======================================"

for subj in $(cat $subjinfo); do
    echo "-------------------------------"
    echo "----Loadinging subject $subj---"
    echo "-------------------------------"
    fmriprep-docker $bidsdir $bidsdir/derivatives participant \
    --participant-label $subj \
    --skip-bids-validation \
    --fs-license-file $fslicense
    --fs-no-reconall \
    --bids-filter-file bids.json \
    --skull-strip-template MNI152NLin2009cAsym \
    --output-spaces MNI152NLin2009cAsym: res-native \
    --nthreads $nthreads \
    -w $workingdir
    done

echo "Thank God! you went without errors in fMRIPrep!"