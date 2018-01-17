Nr = 5; % number of received antennas
Nt = 7; % number of transmit antennas
deltar = 1/2; % normalized rx antenna separation
deltat = 1/2; % normalized tx antenna separation
phir = 1.3; % angle of LOS onto rx antenna
phit = 1.1; % angle of LOS onto tx antenna
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

a = 0.5; % attenuation of the path

% SIMO
g_r = a*exp(-1i*2*pi*d/lambdac).*transpose(exp(-1i*2*pi.*ir*deltar*omegar));
% MISO
g_t = a*exp(-1i*2*pi*d/lambdac).*transpose(exp(-1i*2*pi.*it*deltat*omegat));

H = a*sqrt(Nt*Nr)*exp(-1i*2*pi*d/lambdac).*er*(et'); % Channel matrix

sample_num = 30000;  % number of data point

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
