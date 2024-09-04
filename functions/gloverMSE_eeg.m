function out = gloverMSE_eeg(Y,SPM,EEGU,P,fs) 

% GLM function with glover HRF and EEG as stimuli function 
% modified to output only MSE for optimization
%
% Part of HOT toolbox
% Nikodem Hryniewicz 2024
% email: nhryniewicz@ibib.waw.pl

[~,out,~,~] = opt_glover_eeg(Y,SPM,EEGU,P,fs); 
end

