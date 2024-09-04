function c = canonicaloptimizeFMC(Y,SPM)

% Optimization of canonical HRF parameters
% by minimizing the MSE between the BOLD curve and its prediction
%
% Part of HOT toolbox
% Nikodem Hryniewicz 2024
% email: nhryniewicz@ibib.waw.pl

P0=[6 16 1 1 6 0 32]; %default model parameters
Pmin=[3 8 0.5 0.5 3 0 32]; %lower bounds
Pmax=[9 24 1.5 1.5 9 0 32]; %upper bounds

%optimization
c = fmincon(@(P) canonicalMSE(Y,SPM,P),P0,[],[],[],[],Pmin,Pmax);
clc

end

