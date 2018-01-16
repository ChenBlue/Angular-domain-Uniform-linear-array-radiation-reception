Nt = 5; % number of transmit antennas
Nr = 5; % number of received antennas
sample_num = 30000;  % number of data point

d = 1000; % distance btw 1st tx antenna and 1st rx antenna
L = 995; % distance btw tx array abd rx array
dis = sqrt(d^2-L^2); % horizontal distance btw 1st tx and rx antenna
fc = 1*10^9; % carrier frequency
lambdac = (3*10^8)/fc; % carrier wavelength
deltat = 1/2; % normalized tx antenna separation
deltar = 1/2; % normalized rx antenna separation

%phir = atan(L/dis); % angle of LOS onto rx antenna
phir = 1.3; % angle of LOS onto rx antenna
omegar = cos(phir); % directional cosine with rx antenna array
%phit = atan(L/(dis-it*deltat*lambdac)); % angle of LOS onto tx antenna
phit = 1.1; % angle of LOS onto tx antenna
omegat = cos(phit); % directional cosine with tx antenna array

ir = 0:Nr-1; % index or rx antenna
it = 0:Nt-1; % index or tx antenna
nr = 1;
er = transpose(1/sqrt(nr).*exp(-1i*2*pi.*ir*deltar*omegar)); % unit rx spatial signature
nt = 1;
et = transpose(1/sqrt(nt).*exp(-1i*2*pi.*it*deltat*omegat)); % unit tx spatial signature

a = 0.5; % attenuation of the path
H = a*sqrt(nt*nr)*exp(-1i*2*pi*d/lambdac).*er*(et'); % Channel matrix