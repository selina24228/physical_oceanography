clear all;

Az    = 1e-2;
f     = 1e-4;
tau_y = 0.0;
tau_x = 0.2;
rho   = 1e3;
Inf   = 400;

%(1)
syms u(z) v(z)
Du = diff(u);
Dv = diff(v);
ode1 = -f*v == diff( Az*diff(u) )
ode2 = f*u == diff( Az*diff(v) )
odes = [ode1, ode2]

cond1 = u(-Inf) == 0
cond2 = v(-Inf) == 0
cond3 = Du(0) == tau_x/rho/Az
cond4 = Dv(0) == 0
conds = [cond1, cond2, cond3, cond4]

S=dsolve(odes,conds)
uSol(z) = simplify(S.u)
vSol(z) = simplify(S.v)

% (2)
trans_x = int(uSol,z,-Inf,0)
trans_y = int(vSol,z,-Inf,0)

% (3)
z = -400:1:0;

figure;
for kk = 1:length(z)
a1 = [uSol(kk) 0]; a2 = [vSol(kk) 0]; a3 = [z(kk) z(kk)];
plot3(a1,a2,a3);
hold on;
end
grid on
view(2)
%axis equal;
%axis([-0.2 0.2 -0.2 0.2]);
xlabel('u'); ylabel('v');
title(['Ekman spiral for Az = ',num2str(Az)]);

% (4)

EkmanTransport_x = sum(uSol) * diff(z(1:2))
EkmanTransport_y = sum(vSol) * diff(z(1:2))
EkmanTransport_x_theoy = tau_y/rho/f
EkmanTransport_y_theoy = -tau_x/rho/f


% (5)

Az_in = [1e-3 1e-2 1e-1];
ncase = length(Az_in)

figure

for nn = 1:ncase

Az = Az_in(nn);
D  = sqrt(2*Az/f)     % Ekman layer thickness

% (a) ---- Ekman layer thickness increases with sqrt(Az)

subplot(2,ncase,nn)
plot(uSol(z),z,'k-',vSol(z),z,'r-','linewidth',2);
hold on; legend('u_Sol','v_Sol','location','southeast');
ylabel('depth (m)'); xlabel('u,v');
title(['Az = ',num2str(Az)]);

% (b)  ---- the answer is that the Ekman transport is the same among 3 cases

Me_x_temp = sum(uSol) * diff(z(1:2))
Me_y_temp = sum(vSol) * diff(z(1:2))
EkmanTransport_x_compare(nn) = Me_x_temp
EkmanTransport_y_compare(nn) = Me_y_temp

% (c) ---- Ekman flow (u,v) weakens as the eddy viscosity Az increases

subplot(2,ncase,nn+ncase)
for kk = 1:length(z)
a1 = [uSol(kk) 0]; a2 = [vSol(kk) 0]; a3 = [z(kk) z(kk)];
plot3(a1,a2,a3);
hold on;
end
grid on
view(2)
axis equal;
axis([-0.1 0.5 -0.5 0.1]); 
xlabel('u'); ylabel('v');

end