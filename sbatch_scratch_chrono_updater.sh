#!/bin/bash
#SBATCH --job-name=chrono_task_tpoppi
#SBATCH --output=/leonardo_scratch/large/userexternal/lbarald1/log_backup/logs_%A_%a.out
#SBATCH --error=/leonardo_scratch/large/userexternal/lbarald1/log_backup/logs_%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=2GB
#SBATCH --time=4:00:00
#SBATCH -A IscrB_MMFM
#SBATCH --partition=lrd_all_serial
#SBATCH --array=0-3%4
#SBATCH --mail-type=BEGIN      # Optional: Notify by email when the job start
#SBATCH --mail-user=lorenzo.baraldi01@unimore.it  # Your email address for notifications

paths=(
    "/leonardo_scratch/large/userexternal/lbarald1/dire"
    "/leonardo_scratch/large/userexternal/lbarald1/Dit-3"
    "/leonardo_scratch/large/userexternal/lbarald1/Head"
    "/leonardo_scratch/large/userexternal/lbarald1/mapet"
)

path=${paths[$SLURM_ARRAY_TASK_ID]}

echo "Run metadata changes for user lbarald1 on partition lrd_all_serial for path $path"

# cd /leonardo/home/userexternal/tpoppi00/scripts
./update_metadata.sh "$path"

# Reschedule the job to run in 7 days
echo "Rescheduling next job for 14 days later..."
if $SLURM_ARRAY_TASK_ID == 0
then
    sbatch --begin=now+1days sbatch_scratch_chrono_updater.sh
fi

