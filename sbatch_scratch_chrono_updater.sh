#!/bin/bash
#SBATCH --job-name=chrono_task_tpoppi
#SBATCH --output=/leonardo/home/userexternal/tpoppi00/.log_scratch_scripting/logs_%A_%a.out
#SBATCH --error=/leonardo/home/userexternal/tpoppi00/.log_scratch_scripting/logs_%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=2GB
#SBATCH --time=4:00:00
#SBATCH -A IscrB_MMFM
#SBATCH --partition=lrd_all_serial
#SBATCH --array=0-2%3

paths=(
"/leonardo_scratch/large/userexternal/fcocchi0/dpo"
"/leonardo_scratch/large/userexternal/fcocchi0/safe-clip"
"/leonardo_scratch/large/userexternal/fcocchi0/sdan"
)

path=${paths[$SLURM_ARRAY_TASK_ID]}

echo "Run metadata changes for user tpoppi00 on partition lrd_all_serial for path $path"

cd /leonardo/home/userexternal/tpoppi00/scripts

./update_metadata.sh "$path"
