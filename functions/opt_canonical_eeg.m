function [betas,MSerror,KWY,KWX] = opt_canonical_eeg(Y,SPM,EEGU,P,fs)

% GLM-based function calculating beta values, signal prediction 
% and MSE between signal and prediction based on the selected BOLD curve, 
% canonical HRF and EEG-based signal as stimuli
%
% Part of HOT toolbox
% Nikodem Hryniewicz 2024
% email: nhryniewicz@ibib.waw.pl

hrf_canon      = spm_hrf(100/fs,P);  %canonical HRF

%stuff for GLM computation
EEGU=downsample(EEGU,100);
Xr=filter(hrf_canon,1,EEGU);
Xr=downsample(Xr,SPM.xY.RT*fs/100);
Xr=Xr/max(Xr);
W = SPM.xX.W; %Whitening/weighting matrix used to give weighted least squares estimates (WLS).
rows=1:SPM.nscan;
K = struct('HParam', 128, 'row', rows, 'RT', SPM.xY.RT);
K=spm_filter(K); %cell. low frequency confound: high-pass cutoff (secs)
X=SPM.xX.X; %Design matrix (raw, not temporally smoothed)
X(:,1)=Xr;

%GLM
KWX=spm_filter(K,W*X);  % KWX
xKXs        = spm_sp('Set',KWX);  
xKXs.X      = full(xKXs.X);
pKX         = spm_sp('x-',xKXs);
KWY          = spm_filter(K,W*Y);
betas         = pKX*KWY;
MSerror=mean((KWY - KWX*betas).^2);


end
