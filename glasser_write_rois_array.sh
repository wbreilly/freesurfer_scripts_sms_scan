#!/bin/bash -l 
#
#SBATCH --job-name=glasser_rois_10_22_18
#SBATCH --output=/home/wbreilly/sms_scan_crick/freesurfer_data_10_20_18/logs/glasser_rois_10_22_18.%j.%N.out
#SBATCH --error=/home/wbreilly/sms_scan_crick/freesurfer_data_10_20_18/logs/glasser_rois_10_22_18.%j.%N.err
#SBATCH --nodes=1
#SBATCH -c 1
#SBATCH --time=5-00:00:00
#SBATCH -p high
#SBATCH --mem-per-cpu=2000 
#SBATCH --mail-type=ALL
#SBATCH --mail-user=wbreilly@ucdavis.edu
#SBATCH --array=1-34


date 
hostname
module load freesurfer/6.0.0
source $FREESURFER_HOME/SetUpFreeSurfer.sh

SEEDFILE=/home/wbreilly/sms_scan_crick/freesurfer_data_10_20_18/freesurfer_scripts_sms_scan/sub_array.txt # this is a file with the subjects to run one line for each subject i.e. sub01 sub02 etc.
SEED=$(cat $SEEDFILE | head -n $SLURM_ARRAY_TASK_ID | tail -n 1) 

# SUBJECTS_DIR=/home/wbreilly/halle_data_ants_crick/$SEED/002_mprage_sag_NS_g3

# cd $SUBJECTS_DIR
# echo $SUBJECTS_DIR

# t1_image="$(ls s*.nii)"
# echo $t1_image

srun rsfc_cluster_create_subj_volume_parcellation.sh -L $SEEDFILE -a HCP-MMP1 -d MMP1_native -f $SLURM_ARRAY_TASK_ID -l $SLURM_ARRAY_TASK_ID

