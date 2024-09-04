function out = gammaMSE(Y,SPM,P) 

% GLM function with gamma HRF 
% modified to output only MSE for optimization
%
% Part of HOT toolbox
% Nikodem Hryniewicz 2024
% email: nhryniewicz@ibib.waw.pl

[~,out,~,~] = opt_gamma(Y,SPM,P); 
end

