function out = canonicalMSE(Y,SPM,P) 

% GLM function with canonical HRF 
% modified to output only MSE for optimization
%
% Part of HOT toolbox
% Nikodem Hryniewicz 2024
% email: nhryniewicz@ibib.waw.pl


[~,out,~,~] = opt_canonical(Y,SPM,P); 
end

