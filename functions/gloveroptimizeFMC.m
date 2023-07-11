function c = gloveroptimizeFMC(Y,SPM)

% P0=[6 12 0.9 0.9 0.35 8 9];
% 
% Pmin=[3 6 0.45 0.45 0.1750 4 4.5];
% Pmax=[9 18 1.35 1.35 0.525 12 13.5];

P0=[6 12 0.9 0.9 0.35];

Pmin=[3 6 0.45 0.45 0.175];
Pmax=[9 18 1.35 1.35 0.525];

c = fmincon(@(P) gloverMSE(Y,SPM,P),P0,[],[],[],[],Pmin,Pmax);

end

