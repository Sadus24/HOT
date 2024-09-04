function [betas,MSerror,KWY,KWX] = opt_gamma(Y,SPM,P)

% GLM-based function calculating beta values, signal prediction 
% and MSE between signal and prediction based on the selected BOLD curve, 
% gamma HRF and defined events (stimuli)
%
% Part of HOT toolbox
% Nikodem Hryniewicz 2024
% email: nhryniewicz@ibib.waw.pl

b=P(1);
c=P(2);
t=linspace(0,32,205)';
hrf_gamma=((t/b*c).^b) .* (exp(1).^((b-t/c))); %gamma HRF

% stuff for GLM computation
U=SPM.Sess.U.u;
U=full(U);
U=U(33:end,:);
Xr=filter(hrf_gamma,1,U);
Xr=downsample(Xr,16);
Xr=Xr/max(Xr);
W = SPM.xX.W; %Whitening/weighting matrix used to give weighted least squares estimates (WLS).
rows=1:SPM.nscan;
K = struct('HParam', 128, 'row', rows, 'RT', SPM.xY.RT);
K=spm_filter(K); %cell. low frequency confound: high-pass cutoff (secs)
X=SPM.xX.X; %Design matrix (raw, not temporally smoothed);
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
