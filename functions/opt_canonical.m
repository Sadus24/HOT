function [betas,MSerror,KWY,KWX] = opt_canonical(Y,SPM,P)

% GLM-based function calculating beta values, signal prediction 
% and MSE between signal and prediction based on the selected BOLD curve, 
% canonical HRF and defined events (stimuli)
%
% Part of HOT toolbox
% Nikodem Hryniewicz 2024
% email: nhryniewicz@ibib.waw.pl

hrf_canon      = spm_hrf(SPM.xY.RT/16,P); %canonical HRF

%stuff for GLM computation
X_r = spm_Volterra(SPM.Sess.U,hrf_canon,1);
X_rs = X_r((0:(SPM.nscan - 1))*SPM.xBF.T + SPM.xBF.T0 + 32,:);
X_rs=X_rs/max(X_rs);
W = SPM.xX.W; %Whitening/weighting matrix used to give weighted least squares estimates (WLS).
rows=1:SPM.nscan;
K = struct('HParam', 128, 'row', rows, 'RT', SPM.xY.RT);
K=spm_filter(K); %cell. low frequency confound: high-pass cutoff (secs)
X=SPM.xX.X; %Design matrix (raw, not temporally smoothed)
X(:,1)=X_rs;

% GLM
KWX=spm_filter(K,W*X);  % KWX
xKXs        = spm_sp('Set',KWX);  
xKXs.X      = full(xKXs.X);
pKX         = spm_sp('x-',xKXs);
KWY          = spm_filter(K,W*Y);
betas         = pKX*KWY;
MSerror=mean((KWY - KWX*betas).^2);

end
