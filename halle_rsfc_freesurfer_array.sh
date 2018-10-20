#!/bin/bash -l 
#
#SBATCH --job-name=sms_scan_surf_10_20_18
#SBATCH --output=/home/wbreilly/sms_scan_crick/freesurfer_data_10_20_18/logs/sms_scan_surf_10_20_18.%j.%N.out
#SBATCH --error=/home/wbreilly/sms_scan_crick/freesurfer_data_10_20_18/logs/sms_scan_surf_10_20_18.%j.%N.err
#SBATCH --nodes=1
#SBATCH -c 2
#SBATCH -p high
#SBATCH --time=5-00:00:00
#SBATCH --mem-per-cpu=2000 # 2gb
#SBATCH --mail-type=ALL
#SBATCH --mail-user=wbreilly@ucdavis.edu
#SBATCH --array=1-34


date 
hostname
module load freesurfer/6.0.0

source $FREESURFER_HOME/SetUpFreeSurfer.sh

SEEDFILE=/home/wbreilly/sms_scan_crick/freesurfer_data_10_20_18/freesurfer_scripts_sms_scan/sub_array.txt # this is a file with the subjects to run one line for each subject i.e. sub01 sub02 etc.
SEED=$(cat $SEEDFILE | head -n $SLURM_ARRAY_TASK_ID | tail -n 1) 

SUBJECTS_DIR=/home/wbreilly/sms_scan_crick/freesurfer_data_10_20_18/$SEED/mprage_sag_NS_g3/

cd $SUBJECTS_DIR
echo $SUBJECTS_DIR

OUTPUT="$(ls s*.nii)"
echo $OUTPUT

srun recon-all -s $SEED -i $OUTPUT -all

