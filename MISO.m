function [Ut, desired_gain, SINR, SINR_MRC] = MISO(Nt, deltat, phit, phi_intf)
omegat = cos(phit); % directional cosine with tx antenna array

% angular-domain radiation basis
Lt = Nt*deltat;
Ut = zeros(Nt, Nt);
for i=1:Nt
    Ut(:,i) = e((i-1)/Lt, Nt, deltat);
end

% Correlation btw different basis vector
omg_array = -2:0.01:2;
figure,plot(omg_array, abs(f(Nt, deltat, omg_array, Lt)))
title('Correlation between different basis vectors');
xlabel('£[');
ylabel('|f(£[)|');

% gain pattern of ULA
phi = 0:pi/365:2*pi;
cos_phi = cos(phi)-omegat;
figure,polar(phi,f(Nt, deltat, cos_phi, Lt))
title('Gain pattern of the ULA');

% gain of the desired signal for using different radiation beams
it = 0:Nt-1; % index or tx antenna
a = 1;
desired_gain = a*exp(-1i*2*pi.*it*deltat*omegat)*Ut;
abs_desired_gain = abs(desired_gain);
figure,plot(abs_desired_gain);
title('Gain of desired signal (MISO)');
xlabel('Antenna');
ylabel('Gain');

% signal-to-interference power ratio (SINR) for using different beams
omg_intf = cos(phi_intf);
intf_gain = conj(a*exp(-1i*2*pi.*it*deltat*omg_intf))*Ut;
abs_intf_gain = abs(intf_gain);
SINR = 10*log10((abs_desired_gain.^2)./(abs_intf_gain.^2));
figure,plot(SINR);
title('SINR for different beams (MISO)');
xlabel('Antenna');
ylabel('SINR (dB)');

% The SINR of multiple input signals (multiple reception directions) with
% diversity combining (considering fading for the signals and interference)
des_ray_fad = normrnd(0,1/sqrt(2),1,Nt) + 1i*normrnd(0,1/sqrt(2),1,Nt);
intf_ray_fad = normrnd(0,1/sqrt(2),1,Nt) + 1i*normrnd(0,1/sqrt(2),1,Nt);
SINR_MRC = 10*log(abs((desired_gain*(desired_gain.*des_ray_fad)') ./ (desired_gain*(intf_gain.*intf_ray_fad)')));