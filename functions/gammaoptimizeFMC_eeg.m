function c = gammaoptimizeFMC_eeg(Y,SPM,EEGU,fs)

% Optimization of gamma HRF parameters
% by minimizing the MSE between the BOLD curve and its prediction
% (EEG-based)
%
% Part of HOT toolbox
% Nikodem Hryniewicz 2024
% email: nhryniewicz@ibib.waw.pl

P0=[8.6,0.547]; %default model parameters
Pmin=[4.3 0.274]; %lower bounds
Pmax=[12.9 0.821]; %upper bounds

%optimization
c = fmincon(@(P) gammaMSE_eeg(Y,SPM,EEGU,P,fs),P0,[],[],[],[],Pmin,Pmax);
clc

end

