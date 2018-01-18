function [Ur, correlation, desired_gain, SINR, SINR_MRC] = SIMO(Nr, deltar, phir, phi_intf)
omegar = cos(phir); % directional cosine with rx antenna array

% angular-domain reception basis
Lr = Nr*deltar; 
Ur = zeros(Nr, Nr);
for i=1:Nr
    Ur(:,i) = e((i-1)/Lr, Nr, deltar);
end

% Correlation btw different basis vector
correlation = zeros(Nr, Nr);
for i = 1:Nr
    for j = 1:Nr
        correlation(i,j) = Ur(:,i)' * Ur(:,j);
    end
end

% gain pattern of ULA
phi = 0:pi/365:2*pi;
cos_phi = cos(phi)-omegar;
figure, polar(phi,f(Nr, deltar, cos_phi, Lr))

% gain of the desired signal for using different reception beams
ir = 0:Nr-1; % index or rx antenna
a = 1;
desired_gain = conj(Ur)*a*transpose(exp(-1i*2*pi.*ir*deltar*omegar));
abs_desired_gain = abs(desired_gain);

% signal-to-interference power ratio (SINR) for using different beams
omg_intf = cos(phi_intf);
intf_gain = conj(Ur)*a*transpose(exp(-1i*2*pi.*ir*deltar*omg_intf));
abs_intf_gain = abs(intf_gain);
SINR = 10*log10(abs_desired_gain./abs_intf_gain);

% The SINR of multiple input signals (multiple reception directions) with
% diversity combining (considering fading for the signals and interference)
SINR_MRC = 10*log(abs((desired_gain' * desired_gain ) ./ (desired_gain'*intf_gain)));