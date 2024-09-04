function c = gammaoptimizeFMC(Y,SPM)

% Optimization of gamma HRF parameters
% by minimizing the MSE between the BOLD curve and its prediction
%
% Part of HOT toolbox
% Nikodem Hryniewicz 2024
% email: nhryniewicz@ibib.waw.pl

P0=[8.6,0.547]; %default model parameters
Pmin=[4.3 0.274]; %lower bounds
Pmax=[12.9 0.821]; %upper bounds

%optimization
c = fmincon(@(P) gammaMSE(Y,SPM,P),P0,[],[],[],[],Pmin,Pmax);
clc

end

