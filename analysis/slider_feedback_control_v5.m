%% State feedback (Kalman)
% Requires at least one stochastic plant input
Bn = [B, [0; 1e-6]]

Pn = ss(A, Bn, C, D);
set(Pn,'inputn', {'force', 'noise'});
set(Pn,'staten', {'pos', 'vel'});
set(Pn, 'outputn', {'ypos'});

Q = 1e-3*eye(3);
Q(3,3) = 5000000;
R = 1e-6*eye(2);
%R(2,2) = 1-24; %noise input
kx = lqi(Pn, Q, R);

kxn = -kx;
Ki = ss(kxn(1,:)); %Do away with the noise feedback gain
set(Ki,'inputn',{'pos_e', 'vel_e', 'epos_i'});
set(Ki,'outputn','force');

%estx = kalman(Pss, 1, 1e-8, 0, 1, 1);
estx = kalman(Pn, 1, 1e-8);
E = ss(estx(2:3,:));

S = ss([0],[0 0],[0],[1 -1]);
set(S,'inputn',{'ref', 'ypos'});
set(S,'outputn','epos');

I = ss([0],[1],[1],[0]);
set(I,'inputn','epos');
set(I,'outputn','epos_i');
set(I,'staten','epos_s');

PE = connect(Pn,E,'force',{'ypos', 'pos_e', 'vel_e'});
KiPE = connect(Ki,PE,'epos_i', 'ypos');
SIKiPE = connect(S,I,KiPE, 'ref', 'ypos');

ref = -0.8;
R = ss(ref);
RSIKiPE = series(R,SIKiPE);

step(RSIKiPE);


%% Output feedback
% Guassian regulator

Pss = ss(A, B, C, D);
set(Pss,'inputn', {'force'});
set(Pss,'staten', {'pos', 'vel'});
set(Pss, 'outputn', {'ypos'});

G = lqg(Pss,2.5e-2*eye(3),1*eye(3),1e3*eye(1));
GP = connect(G,Pss,'r1','ypos');

ref = -0.8;
R = ss(ref);
RGP = series(R,GP);

step(RGP);

Gd = c2d(G,0.005,'tustin');