function [betas,MSerror,KWY,KWX] = opt_gamma(Y,SPM,P)
b=P(1);
c=P(2);

t=linspace(0,32,205)';
% b= 8.6; 
% c=0.547;
hrf_gamma=((t/b*c).^b) .* (exp(1).^((b-t/c))); %gamma

U=SPM.Sess.U.u;
U=full(U);
U=U(33:end,:);
Xr=filter(hrf_gamma,1,U);
Xr=downsample(Xr,16);
Xr=Xr/max(Xr);

W = SPM.xX.W; %Optional whitening/weighting matrix used to give weighted least squares estimates (WLS).

rows=1:SPM.nscan;
K = struct('HParam', 128, 'row', rows, 'RT', 2.5);
K=spm_filter(K); %cell. low frequency confound: high-pass cutoff (secs)
X=SPM.xX.X; %Design matrix (raw, not temporally smoothed);
X(:,1)=Xr;


KWX=spm_filter(K,W*X);  % KWX
xKXs        = spm_sp('Set',KWX);  
xKXs.X      = full(xKXs.X);
pKX         = spm_sp('x-',xKXs);
KWY          = spm_filter(K,W*Y);

betas         = pKX*KWY;
MSerror=mean((KWY - KWX*betas).^2); 

% KWX_B=KWX(:,1)*betas(1)+betas(8);

% figure
% subplot(2,2,1)
% 
% z=KWY(Up==1);                            
% t = 0:numel(KWY)-1; % Independent Variable Vector
% plot(t,KWY);hold on;
% scatter(t(Up==1),z,'filled')
% 
% subplot(2,2,2)
% estim=KWX*betas
% z1=estim(Up==1);                            
% t1 = 0:numel(estim)-1; % Independent Variable Vector
% plot(t1,estim);hold on;
% scatter(t1(Up==1),z1,'filled')
% 
% 
% subplot(2,2,3)
% roznica=(KWY-KWX*betas);
% z2=roznica(Up==1);                            
% t2 = 0:numel(roznica)-1; % Independent Variable Vector
% plot(t,roznica);hold on;
% scatter(t2(Up==1),z2,'filled')



end
