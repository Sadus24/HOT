function c = gloveroptimizeFMC_eeg(Y,SPM,EEGU,fs)

% Optimization of glover HRF parameters
% by minimizing the MSE between the BOLD curve and its prediction
% (EEG-based)
%
% Part of HOT toolbox
% Nikodem Hryniewicz 2024
% email: nhryniewicz@ibib.waw.pl


P0=[6 12 0.9 0.9 0.35]; %default model parameters
Pmin=[3 6 0.45 0.45 0.175]; %lower bounds
Pmax=[9 18 1.35 1.35 0.525]; %upper bounds

%optimization
c = fmincon(@(P) gloverMSE_eeg(Y,SPM,EEGU,P,fs),P0,[],[],[],[],Pmin,Pmax);
clc

end

