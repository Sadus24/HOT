function [betas,MSerror,KWY,KWX] = opt_glover(Y,SPM,P)

% GLM-based function calculating beta values, signal prediction 
% and MSE between signal and prediction based on the selected BOLD curve, 
% glover HRF and defined events (stimuli)
%
% Part of HOT toolbox
% Nikodem Hryniewicz 2024
% email: nhryniewicz@ibib.waw.pl

a1 = P(1);
a2 = P(2); 
b1 = P(3);
b2 = P(4); 
c = P(5);
t=linspace(0,32,205)';
d1=a1*b1;
d2=a2*b2;
hrf_glover=((t/d1).^a1).*(exp(1).^-((t-d1)/b1)) - c.*((t/d2).^a2).*(exp(1).^-((t-d2)/b2)); %glover HRF

%Stuff for GLM computation
U=SPM.Sess.U.u;
U=full(U);
U=U(33:end,:);
Xr=filter(hrf_glover,1,U);
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
