% Input parameters %
Nr = 5; % number of received antennas
Nt = 7; % number of transmit antennas
deltar = 1/2; % normalized rx antenna separation
deltat = 1/2; % normalized tx antenna separation
phir = pi/4; % angle of LOS onto rx antenna
phir_intf = pi/2; % reception direction of interference signal
phit = pi/6; % angle of LOS onto tx antenna
phit_intf = pi/3; % radiation direction of interference signal

%%% SIMO model
[U_SIMO, desired_gain_SIMO, SINR_SIMO, SINR_MRC_SIMO] = SIMO(Nr, deltar, phir, phir_intf);

%%% MISO model 
[U_MISO, desired_gain_MISO, SINR_MISO, SINR_MRC_MISO] = MISO(Nt, deltat, phit, phit_intf);
