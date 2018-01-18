% Input parameters %
Nr = 4; % number of received antennas
Nt = 7; % number of transmit antennas
deltar = 1/4; % normalized rx antenna separation
deltat = 1/2; % normalized tx antenna separation
phir = pi/6; % angle of LOS onto rx antenna
phir_intf = pi/2; % reception direction of interference signal
phit = pi/3; % angle of LOS onto tx antenna
phit_intf = pi/2; % radiation direction of interference signal

[U_SIMO, cor_SIMO, desired_gain_SIMO, SINR_SIMO, SINR_MRC_SIMO] = SIMO(Nr, deltar, phir, phir_intf);
omegar = cos(phir); % directional cosine with rx antenna array
omegat = cos(phit); % directional cosine with tx antenna array

d = 1000; % distance btw 1st tx antenna and 1st rx antenna
%L = 995; % distance btw tx array abd rx array
%dis = sqrt(d^2-L^2); % horizontal distance btw 1st tx and rx antenna
fc = 1*10^9; % carrier frequency
lambdac = (3*10^8)/fc; % carrier wavelength

ir = 0:Nr-1; % index or rx antenna
it = 0:Nt-1; % index or tx antenna
er = transpose(1/sqrt(Nr).*exp(-1i*2*pi.*ir*deltar*omegar)); % reception basis
et = transpose(1/sqrt(Nt).*exp(-1i*2*pi.*it*deltat*omegat)); % radiation basis

a = 1; % attenuation of the path

H = a*sqrt(Nt*Nr)*exp(-1i*2*pi*d/lambdac).*er*(et'); % Channel matrix

% angular-domain reception basis
Lr = Nr*deltar; 
Ur = zeros(Nr, Nr);
for i=1:Nr
    Ur(:,i) = e((i-1)/Lr, Nr, deltar);
end

% angular-domain radiation basis
Lt = Nt*deltat;
Ut = zeros(Nt, Nt);
for i=1:Nt
    Ut(:,i) = e((i-1)/Lt, Nt, deltat);
end

% Correlation btw different basis vector
corr = zeros(Nr, Nr);
for i = 1:Nr
    for j = 1:Nr
        corr(i,j) = Ur(:,i)' * Ur(:,j);
    end
end

cort = zeros(Nt, Nt);
for i = 1:Nt
    for j = 1:Nt
        cort(i,j) = Ut(:,i)' * Ut(:,j);
    end
end

% gain pattern of ULA
phi = 0:pi/365:2*pi;
cos_phi = cos(phi)-omegar;
figure,polar(phi,f(Nr, deltar, cos_phi, Lr))

% gain of the desired signal for using different radiation/reception beams
% SIMO
g_r = a*exp(-1i*2*pi*d/lambdac).*transpose(exp(-1i*2*pi.*ir*deltar*omegar));
% MISO
g_t = a*exp(-1i*2*pi*d/lambdac).*transpose(exp(-1i*2*pi.*it*deltat*omegat));

% signal-to-interference power ratio (SINR) for using different beams
intf_phi = pi/2;  % angle of interference
omg_intf = cos(intf_phi);
% SIMO
g_intf = a*exp(-1i*2*pi*d/lambdac).*transpose(exp(-1i*2*pi.*ir*deltar*omg_intf));
%SINR_SIMO = 10*log(abs((Ur' * g_r) ./ (Ur' * g_intf)));
%SINR_SIMO = 10*log((Ur' * g_r) ./ (Ur' * g_intf));

% MISO
g_intf_MISO = a*exp(-1i*2*pi*d/lambdac).*transpose(exp(-1i*2*pi.*it*deltat*omg_intf));
SINR_MISO = 10*log(abs((transpose(g_t)*Ut) ./ (transpose(g_intf_MISO)*Ut)));

% The SINR of multiple input signals (multiple reception directions) with
% diversity combining (considering fading for the signals and interference)
sample_num = 1000;  % number of data point

% generate BPSK data (1 bit)
desired = rand(1,sample_num); % desired symbol
desired = 2*(desired > 0.5)-1; % map to -1, 1

interference = rand(1,sample_num); % interference symbol
interference = 2*(interference > 0.5)-1; % map to -1, 1

desired = repmat(desired, Nr, 1);
interference = repmat(interference, Nr, 1);

des_ray_fad = normrnd(0,1/sqrt(2),Nr,sample_num) + 1i*normrnd(0,1/sqrt(2),Nr,sample_num);
intf_ray_fad = normrnd(0,1/sqrt(2),Nr,sample_num) + 1i*normrnd(0,1/sqrt(2),Nr,sample_num);

n = normrnd(0,0.1,Nr,sample_num) + 1i*normrnd(0,0.1,Nr,sample_num);
%%

des_ray_plus_gain = conj(des_ray_fad).*repmat(g_r,1,sample_num); 
intf_ray_plus_gain = conj(intf_ray_fad).*repmat(g_intf,1,sample_num);

des_rx = des_ray_plus_gain.*desired;
intf_rx = intf_ray_plus_gain.*interference;

des_MRC = sum(des_ray_fad.*(Ur'*des_rx));
intf_MRC = sum(des_ray_fad.*(Ur'*intf_rx));
%des_MRC = sum(des_ray_plus_gain.*des_rx);
%intf_MRC = sum(intf_ray_plus_gain.*intf_rx);
%des_MRC = sum(des_ray_plus_gain.*des_ray_plus_gain);
%intf_MRC = sum(intf_ray_plus_gain.*intf_ray_plus_gain);

%SINR_MRC = 10*log(sum(abs(des_MRC.^2))/sum(abs(intf_MRC.^2)));
%SINR_MRC = sum(abs(des_MRC.^2))/sum(abs(intf_MRC.^2))

%%
dir_fad_1 = rand(1,Nr) * pi;  % Direction of multiple input siganls(diversity)
dir_fad_2 = rand(1,Nr) * pi;
gain_diver_1 = zeros(Nr,1);     % Gain of multiple input siganls(diversity)
gain_diver_2 = zeros(Nr,1);

for m = 0:1:Nr-1
    gain_diver_1(m+1,1) = exp(-j * 2 * pi * m * delta * cos(dir_fad_1(1)));   % Calculate gain of multiple direction signals 
    gain_diver_2(m+1,1) = exp(-j * 2 * pi * m * delta * cos(dir_fad_2(1)));
end
%SINR_MRC_SIMO = 10 * log(abs((conj(g_r.') * g_r ) ./ (conj(g_r.') * conj(Ur') * gain_diver_2)))