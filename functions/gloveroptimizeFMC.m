function c = gloveroptimizeFMC(Y,SPM)

% Optimization of glover HRF parameters
% by minimizing the MSE between the BOLD curve and its prediction
%
% Part of HOT toolbox
% Nikodem Hryniewicz 2024
% email: nhryniewicz@ibib.waw.pl


P0=[6 12 0.9 0.9 0.35]; %default model parameters
Pmin=[3 6 0.45 0.45 0.175]; %lower bounds
Pmax=[9 18 1.35 1.35 0.525]; %upper bounds

%optimization
c = fmincon(@(P) gloverMSE(Y,SPM,P),P0,[],[],[],[],Pmin,Pmax);
clc

end

