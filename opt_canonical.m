function [betas,MSerror,KWY,KWX] = opt_canonical(Y,SPM,P)

hrf_canon      = spm_hrf(2.5/16,P); 
X_r = spm_Volterra(SPM.Sess.U,hrf_canon,1);
X_rs = X_r((0:(SPM.nscan - 1))*SPM.xBF.T + SPM.xBF.T0 + 32,:);
X_rs=X_rs/max(X_rs);

W = SPM.xX.W; %Optional whitening/weighting matrix used to give weighted least squares estimates (WLS).

rows=1:SPM.nscan;
K = struct('HParam', 128, 'row', rows, 'RT', 2.5);
K=spm_filter(K); %cell. low frequency confound: high-pass cutoff (secs)
X=SPM.xX.X; %Design matrix (raw, not temporally smoothed)
X(:,1)=X_rs;


KWX=spm_filter(K,W*X);  % KWX
xKXs        = spm_sp('Set',KWX);  
xKXs.X      = full(xKXs.X);
pKX         = spm_sp('x-',xKXs);
KWY          = spm_filter(K,W*Y);

betas         = pKX*KWY;
MSerror=mean((KWY - KWX*betas).^2);

end
