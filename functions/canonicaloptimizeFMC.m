function c = canonicaloptimizeFMC(Y,SPM)

P0=[6 16 1 1 6 0 32];

Pmin=[3 8 0.5 0.5 3 0 32];
Pmax=[9 24 1.5 1.5 9 0 32];

c = fmincon(@(P) canonicalMSE(Y,SPM,P),P0,[],[],[],[],Pmin,Pmax);

end

