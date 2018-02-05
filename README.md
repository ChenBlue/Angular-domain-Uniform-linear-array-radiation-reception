# Angular-domain-Uniform-linear-array-radiation-reception
Implement angular-domain model of MIMO channel, and evaluate the Radiation and Reception patterns of Uniform Linear Arrays (ULA). This project is divided to 2 parts, which are SIMO(Single input multiple output) and MISO(Multiple input single output). Besides, we have to set some input parameters as following.
### Input parameters:
* The number of antennas N
* The normalized antenna separation $ \delta $ (normalized to the wavelength $\lambda_c $)
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
$$ y = Hx + w $$
x: transmitted signal; y: received signal; w: white Gaussian noise; </br>
The following two figure shows the **LOS(Line-of-sight)** channel with SIMO and MISO.

**Uniform linear antenna arrays**: the antenna are evenly spaced on a straight line.

### LOS of SIMO model
Channel gain:
$$ h_i = 𝑎∙𝑒𝑥𝑝(−\frac{𝑗2\pi 𝑓_𝑐 𝑑_𝑖}{c}) = 𝑎∙𝑒𝑥𝑝 (−\frac{𝑗2\pi 𝑑_𝑖}{\lambda_𝑐}) $$
> a: attenuation of the path, which we assume to be the same for all antenna pairs </br>

Because antenna space is much smaller than distance between transmitter and receiver, we can write distance between each antenna pair as:
$$ di\approx 𝑑+(𝑖 − 1)\Delta _𝑟 \lambda _𝑐 \cos \phi , i = 1, ... , n_r $$
Define directional cosine: $ \Omega = cos\phi $. Channel gain will be: </br>
![rx_channel_gain](https://github.com/ChenBlue/Angular-domain-Uniform-linear-array-radiation-reception/blob/master/FIG/rx_channel.JPG)

### LOS of MISO model
Similar to SIMO model, the channel gain is: </br>
![tx_channel_gain](https://github.com/ChenBlue/Angular-domain-Uniform-linear-array-radiation-reception/blob/master/FIG/tx_channel.JPG)

### Angular domain representation of signals
Every linear transformation can be represented as a composition of three operations: a rotation operation, a scaling operation, and another rotation operation. H has a **singular value decomposition (SVD)**:
$$ H=U\Lambda V^* $$
> U & V: (rotation) unitary matrices ; $ \Lambda $: a rectangular matrix

$$ y=U\Lambda V^* x+w⇒U^* y=\Lambda V^* x+U^* w $$

Define: </br>
$$ \tild{x}=V^* x ; \tild{y}=U^* y; \tild{w}=U^* w $$

We can rewrite the channel to angular domain as: </br>
$$ \tild{y}=\Lambda \tild{x}+\tild{w} $$
