function out = gammaMSE_eeg(Y,SPM,EEGU,P,fs) 

% GLM function with gamma HRF and EEG as stimuli 
% modified to output only MSE for optimization
%
% Part of HOT toolbox
% Nikodem Hryniewicz 2024
% email: nhryniewicz@ibib.waw.pl

[~,out,~,~] = opt_gamma_eeg(Y,SPM,EEGU,P,fs); 
end

