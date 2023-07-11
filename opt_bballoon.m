function [betas,MSerror,KWY,KWX] = opt_bballoon(Y,SPM,P)

TR=2.5;
ModelSet.dw=TR;     %scanner repetition time
ModelSet.delT=TR/16;  %simulation time resolution
ModelSet.up=round(TR/ModelSet.delT); %up sampling ratio
%excitation
% ModelSet.lam(1)=30;  %phase of the stimulation box-car function in [s] %
%neuronal model
ModelSet.lam(2)=P(1);   %Inhibitory fedback gain
ModelSet.lam(3)=P(2);   %inhibitory feedback time constant
%hemodynamic model
ModelSet.lam(4)=P(3);   %CBF delay
ModelSet.lam(5)=P(4);   %CMRO2 delay
ModelSet.lam(6)=P(5);   %flow metabolism relation
ModelSet.lam(7)=P(6);   %flow volume relation
ModelSet.lam(8)=P(7);   %ballon transit time
ModelSet.lam(9)=P(8);   %viscoelastic time constant
ModelSet.lam(10)=P(9);  %baseline blood volume
%base line shift
%ModelSet.lam(11)=-0.5; %base line
ModelSet.lammask=(ModelSet.lam==0); %init lam mask - all 0


U=SPM.Sess.U.u;
U=full(U);
U=U(33:end,:);



Upp(:,1)=0:ModelSet.delT:(SPM.nscan*ModelSet.dw-ModelSet.delT);
Upp(:,2)=U;
ModelSet.Upp=Upp;

% set_param('Buxton1','SimulationMode','accelerator')
[t x y]=sim('Buxton1',SPM.nscan*ModelSet.dw,simset('SrcWorkspace','current','OutputVariables','y','Decimation',ModelSet.up));
y=y(1:end-1);
Xr=y/max(y);


W = SPM.xX.W; %Optional whitening/weighting matrix used to give weighted least squares estimates (WLS).

rows=1:SPM.nscan;
K = struct('HParam', 128, 'row', rows, 'RT', 2.5);
K=spm_filter(K); %cell. low frequency confound: high-pass cutoff (secs)
X=SPM.xX.X; %Design matrix (raw, not temporally smoothed)
X(:,1)=Xr;


KWX=spm_filter(K,W*X);  % KWX
xKXs        = spm_sp('Set',KWX);  
xKXs.X      = full(xKXs.X);
pKX         = spm_sp('x-',xKXs);
KWY          = spm_filter(K,W*Y);

betas         = pKX*KWY;
MSerror=mean((KWY - KWX*betas).^2);



end
