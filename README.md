# HOT
HemodynamicResponseFunction Optimization Toolbox

Highly recommended to download sample EEG-fMRI data:
https://drive.google.com/file/d/1mFTs1COvP2MuTMCKsjzLvS9_Z4FGC9PN/

## **Requirements**

1. **MATLAB**  
   The application runs in the MATLAB environment. MATLAB version 2016 or newer is required.

2. **SPM12 Toolbox**  
   The application uses the SPM12 toolbox. Before using HOT, ensure that SPM12 is installed and added to the MATLAB path.

3. **FieldTrip Toolbox**  
   HOT toolbox handles EEG signals using the FieldTrip toolbox. It is necessary to create an SPM file based on the EEG signal and prepare regressors for the GLM model from the EEG data.

4. **MATLAB Optimization Toolbox (Optional)**  
   To optimize HRF parameters, you will need the MATLAB Optimization Toolbox.

---

## **Installation**

1. If you don't have them installed already, download [FieldTrip](https://www.fieldtriptoolbox.org/download/) and [SPM12](https://www.fil.ion.ucl.ac.uk/spm/software/spm12/), then add their directories to your MATLAB path.
   
2. After downloading the HOT toolbox, add the entire HOT folder (including subfolders) to your MATLAB path.
   
3. You can start the HOT application by typing `HOT` in the MATLAB command window.

---

## **User Guide**

### **EEG2SPM**

EEG2SPM is a universal tool for EEG-based fMRI analysis. It supports EEG signals in .cnt format with marked events and fMRI triggers in the form of event codes.

- To start, either type `EEG2SPM` in the MATLAB command line or type `HOT` and click on the EEG2SPM button.  
- First, define the number of EEG-fMRI sessions and specify code numbers from your EEG signal, such as the fMRI trigger, start, and end of an event.  
- Click the **Load EEG** button. You will be notified if the EEG is loaded correctly.  
- The right side of the app allows you to define the parameters for fMRI analysis. The **Dynamic Analysis** option is an additional tool that uses a dynamic analysis with moving analysis window (from -5 to +5 seconds around the start of an event).  
- Click **Run** to select fMRI data and the corresponding rp_ movement regressor files.
- **Important:** In order to use the HOT toolbox, you need to have a specific `SPM.mat` file. If you don't have one, you can create it using the EEG2SPM tool. To prepare the `SPM.mat` file for the HOT toolbox, make sure that you're using single-session data, that the **Serial Corr** checkbox is **unchecked** and that the **Export: nifti masks** checkbox is **checked**.

---

### **HOT**

The HOT toolbox allows you to extract fMRI data and prepare regressors using various HRFs and stimuli functions.

1. First, load the proper `SPM.mat` file.  
2. After loading, you can either extract the signal from an activation cluster (ROI-level) — for this, the `*cluster.nii` file from the SPM folder is required — or manually input voxel coordinates (Voxel-level).  
3. After pressing **Apply**, you will see three different signal predictions (made using the canonical, gamma, and Glover HRFs), BOLD signal, MSE between them and corresponding beta values from GLM analysis.  
4. You can manually adjust the parameters of each HRF and press **Apply** again to update the predictions.  
5. To change the stimuli function from the default SPMReg (event information from `SPM.mat`), you first need to load a .cnt EEG file. You can then choose an EEG-based stimuli function, created using either Global Mean Field or four different types of EEG signal envelopes.

Each change must be confirmed by pressing the **Apply** button.

- You can optimize HRF parameters to make better fit between prediction and the BOLD signal by clicking **Optimize**. The application will find HRF parameters within a range of 0.5 to 1.5 (relative to default parameters) that minimize the mean squared error between the signal and the prediction.
- To revert to default parameters, press **Default**.

---

## **Sample Data**

Sample EEG-fMRI data can be downloaded from the following link:  
[Sample Data](https://drive.google.com/file/d/1mFTs1COvP2MuTMCKsjzLvS9_Z4FGC9PN/)

This data comes from a right hand finger-tapping experiment in a block design. You can directly load the SPM.mat file from spmreg folder into the HOT application (the first time you load the SPM, the application will ask you to update the paths to the fMRI data), or you can prepare the `SPM.mat` file manually using EEG2SPM — just leave the default options (specifically: 1 session, checked export: nifti masks and unchecked serial correlations).

---

## **Other info**

This tool is designed for research purposes only and should not be used for making any medical decisions

The application operates based on the functionalities of FieldTrip and SPM12:
**Penny, W., Friston, K., Ashburner, J., Kiebel, S., Nichols, T.: Statistical Parametric Mapping: The Analysis of Functional Brain Images. 1st edn., Elsevier (2007).**
**Oostenveld, R., Fries, P., Maris, E., Schoffelen, J.M:  FieldTrip: Open Source Software for Advanced Analysis of MEG, EEG, and Invasive Electrophysiological Data. Computational Intelligence and Neuroscience, Volume 2011 (2011).**

---

## **Contact**

If you have any questions, feel free to contact me at: nhryniewicz@ibib.waw.pl

