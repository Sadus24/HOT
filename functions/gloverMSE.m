function out = gloverMSE(Y,SPM,P) 

% GLM function with glover HRF 
% modified to output only MSE for optimization
%
% Part of HOT toolbox
% Nikodem Hryniewicz 2024
% email: nhryniewicz@ibib.waw.pl

[~,out,~,~] = opt_glover(Y,SPM,P); 
end

