# Angular-domain-Uniform-linear-array-radiation-reception
Implement angular-domain model of MIMO channel, and evaluate the Radiation and Reception patterns of Uniform Linear Arrays (ULA). This project is divided to 2 parts, which are SIMO(Single input multiple output) and MISO(Multiple input single output). Besides, we have to set some input parameters as following.
### Input parameters:
* The number of antennas N
* The normalized antenna separation $ \delta $ (normalized to the wavelength $\lambda _c $)
* The radiation or reception directions of the desired signal
* The radiation or reception direction of the interference signal

### Ouput results
* The angular-domain radiation/reception basis
* The correlation between different basis vectors
* The gain pattern of the ULA
* The gain of the desired signal for using different radiation/reception beams
* The signal-to-interference power ratio (SINR) for using different beams
* The SINR of multiple input signals (multiple reception directions) with diversity combining (considering fading for the signals and interference)

## Algorithm
The time-invariant channel is described by
$ 𝐲 = 𝐇𝐱 + w $
x: transmitted signal; y: received signal; w: white Gaussian noise; </br>
The following two figure shows the LOS(Line-of-sight) channel with SIMO and MISO.

