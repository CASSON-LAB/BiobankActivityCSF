#!/bin/bash --login
#$ -cwd
#$ -l mem256

# Set the largest number in the range on line 3 to match the number seperate jobs you want to create
# This sets the maximum number of jobs that will run simutaneously
# The optimum value for this depends on demand on the CSF at that point in time
# For example, if this is set to 100 and FILES is set to 700, then 70,000 files will be processed

module load apps/binapps/anaconda3/2019.03
module load tools/java/1.8.0

export HDF5_USE_FILE_LOCKING=FALSE
export OMP_NUM_THREADS="1"
export _JAVA_OPTIONS="-XX:ParallelGCThreads=1 -XX:ParallelCMSThreads=1 -Xmx16G"

INFILE=1461090_90001_0_0.cwa
cp /mnt/data-sets/ukbiobank/activity-data/bulk/$INFILE .
python accProcess.py $INFILE
rm $INFILE

