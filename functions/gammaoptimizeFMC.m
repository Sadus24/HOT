function c = gammaoptimizeFMC(Y,SPM)

P0=[8.6,0.547];

Pmin=[4.3 0.274];
Pmax=[12.9 0.821];

c = fmincon(@(P) gammaMSE(Y,SPM,P),P0,[],[],[],[],Pmin,Pmax);

end

