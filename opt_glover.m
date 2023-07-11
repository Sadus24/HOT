function [betas,MSerror,KWY,KWX] = opt_glover(Y,SPM,P)

a1 = P(1);
a2 = P(2); 
b1 = P(3);
b2 = P(4); 
c = P(5);

t=linspace(0,32,205)';
% a1 = 6;
% a2 = 12; 
% b1 = 0.9;
% b2 = 0.9; 
% c = 0.35;
% d1=8; a1*b1
% d2=9; a2*b2
d1=a1*b1;
d2=a2*b2;
hrf_glover=((t/d1).^a1).*(exp(1).^-((t-d1)/b1)) - c.*((t/d2).^a2).*(exp(1).^-((t-d2)/b2));

U=SPM.Sess.U.u;
U=full(U);
U=U(33:end,:);
Xr=filter(hrf_glover,1,U);
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
