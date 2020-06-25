# BiobankActivityCSF
This repo contains code to process the accelerometer CWA files from the UK Biobank activity monitoring study in Python, and optionally on high performance computing infrastructure. This code is an adaption of [biobankAccelerometerAnalysis](https://github.com/activityMonitoring/biobankAccelerometerAnalysis) from Aiden Doherty/University of Oxford.

This code allows you to process the raw accelerometer data in Python, sampled at 100 Hz, as apposed to other versions which typically operate on 5 s epochs.

This repo also contains scripts to allow this code to run on the [UoM CSF3](http://ri.itservices.manchester.ac.uk/csf3/). These scripts may also work on other high-performance computers that use SGE (which is used on many high-performance computing systems at multiple universities). However, note that some parts of this code are specific to the architecutre of the CSF and may need to be adapted to your specific system. This code can also be run on the [iCSF/incline](http://ri.itservices.manchester.ac.uk/icsf/) (the interative version of the CSF), but the batch scripts will not work on here, and this is recommended only for testing. 

Parts of this readme that directly relate to processing on the CSF3 will be highlighted and can be ignored by those who only want basic processing in Python rather than batch processing.

The pre-processing in this code is based off the [biobankAccelerometerAnalysis](https://github.com/activityMonitoring/biobankAccelerometerAnalysis) from Aiden Doherty/University of Oxford.

## What does this code do?
This code can be used for two purposes:
 
 - To resample the CWA files to a regular interval and then process them using your own processing in Python
 - To allow batch processing of the CWA files on high-performance computing to allow multiple files to be processed simultaneously, vastly increasing the throughput
 
The CWA files are not sampled at regular intervals nor are they calibrated to local gravity. To achieve this, this code uses the methods developed by the [UK Biobank Accelerometer expert group](https://github.com/activityMonitoring/biobankAccelerometerAnalysis), which are described [here](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0169649). The code here is designed to allow access to the full raw data, sampled at 100 Hz, rather processing on epochs as is down in most analysis (including the analysis by the Oxford group).

In order to acheive this, this code is run by calling a Python script, that in turn calls a complied Java programme that does the actual resampling and calibration of data. This java programme then saves the resampled data to the hard drive in NumPy format, which then when control is returned to the Python script is then reimported from the hard drive. This clearly generates substational overheads, but in testing this does not appear to significantly impact performance, as the actual resampling takes considerably longer than the saving and reloading data from disk. Note that this method produces a large amount of temporary files, and therefore should only be run in the scratch storage on the CSF. 

![Data processing pipeline overview](biobank_processing.png)


## Getting Started
This script is designed to run on Linux using the [Anaconda distribution](https://www.anaconda.com/products/individual) of Python. For those using Windows, [WSL](https://docs.microsoft.com/en-us/windows/wsl/install-win10) is recommended. All commands should be run from the terminal. 
If running this code at the University of Manchester, See Research IT guides on how to SSH to the [CSF3](http://ri.itservices.manchester.ac.uk/csf3/getting-started/connecting/) or [iCSF](http://ri.itservices.manchester.ac.uk/icsf/getting-started-on-icsf/connecting-to-incline/)

Log-on to the CSF or iCSF and enable the proxy to allow access to the internet

```
module load tools/env/proxy
```

Download this repository

```
git clone https://github.com/CASSON-LAB/BiobankActivityCSF.git
```




