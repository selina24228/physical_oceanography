clear all;
% this assumes tau_y = 0, tau_x is positive (wind blowing toward east)

Az    = 1e-2;
f     = 1e-4;
tau_y = 0.0;
tau_x = 0.2;
rho   = 1e3;
Inf   = 10^9;

%(1)
syms u(z) v(z)
Du = diff(u);
Dv = diff(v);
ode1 = -f*v == diff( Az*diff(u) )
ode2 = f*u == diff( Az*diff(v) )
odes = [ode1; ode2]
S=dsolve(odes);

zz = -400:0.2:0;
D  = sqrt(2*Az/f)     % Ekman layer thickness
ue = exp(zz/D) / sqrt(Az * f) .* ( tau_x/rho .* sin(zz/D + (pi/4)) + tau_y/rho * cos(zz/D + (pi/4)) );
ve = exp(zz/D) / sqrt(Az * f) .* (-tau_x/rho .* cos(zz/D + (pi/4)) + tau_y/rho * sin(zz/D + (pi/4)) );


% (3)

figure;
for kk = 1:length(zz)
a1 = [ue(kk) 0]; a2 = [ve(kk) 0]; a3 = [zz(kk) zz(kk)];
plot3(a1,a2,a3);
hold on;
end
grid on
view(2)
axis equal;
axis([-0.2 0.2 -0.2 0.2]);
xlabel('u'); ylabel('v');
title(['Ekman spiral for Az = ',num2str(Az)]);

% (4)

EkmanTransport_x = sum(ue) * diff(zz(1:2))
EkmanTransport_y = sum(ve) * diff(zz(1:2))
EkmanTransport_x_theoy = tau_y/rho/f
EkmanTransport_y_theoy = -tau_x/rho/f


% (5)

Az_in = [1e-3 1e-2 1e-1];
ncase = length(Az_in)

figure

for nn = 1:ncase

Az = Az_in(nn);
D  = sqrt(2*Az/f)     % Ekman layer thickness
ue = exp(zz/D) / sqrt(Az * f) .* ( tau_x/rho .* sin(zz/D + (pi/4)) + tau_y/rho * cos(zz/D + (pi/4)) );
ve = exp(zz/D) / sqrt(Az * f) .* (-tau_x/rho .* cos(zz/D + (pi/4)) + tau_y/rho * sin(zz/D + (pi/4)) );

% (a) ---- Ekman layer thickness increases with sqrt(Az)

subplot(2,ncase,nn)
plot(ue,zz,'k-',ve,zz,'r-','linewidth',2);
hold on; legend('u_e','v_e','location','southeast');
ylabel('depth (m)'); xlabel('u,v');
title(['Az = ',num2str(Az)]);

% (b)  ---- the answer is that the Ekman transport is the same among 3 cases

Me_x_temp = sum(ue) * diff(zz(1:2))
Me_y_temp = sum(ve) * diff(zz(1:2))
EkmanTransport_x_compare(nn) = Me_x_temp
EkmanTransport_y_compare(nn) = Me_y_temp

% (c) ---- Ekman flow (u,v) weakens as the eddy viscosity Az increases

subplot(2,ncase,nn+ncase)
for kk = 1:length(zz)
a1 = [ue(kk) 0]; a2 = [ve(kk) 0]; a3 = [zz(kk) zz(kk)];
plot3(a1,a2,a3);
hold on;
end
grid on
view(2)
axis equal;
axis([-0.1 0.5 -0.5 0.1]); 
xlabel('u'); ylabel('v');

end





