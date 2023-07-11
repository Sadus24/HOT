function c = bballoonoptimizeFMC(Y,SPM)

% P0=[3 5 6 6 2.5 0.38 2 10 5];
% Pmin=[1.5 2.5 3 3 1.25 0.19 1 5 2.5];
% Pmax=[4.5 7.5 9 9 3.75 0.57 3 15 7.5];

P0=  [2 3   5 4   2.5  0.38 3   20 0.03];
Pmin=[1 1.5 2.5 2 1.25 0.19 1.5 10 0.015];
Pmax=[3 4.5 7.5 6 3.75 0.57 4.5 30 0.045];
c = fmincon(@(P) bballoonMSE(Y,SPM,P),P0,[],[],[],[],Pmin,Pmax);

end
