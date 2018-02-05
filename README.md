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
The following picture shows SIMO model: </br>
![SIMO](https://github.com/ChenBlue/Angular-domain-Uniform-linear-array-radiation-reception/blob/master/FIG/SIMO.JPG) </br>

Channel gain: </br>
$$ h_i = 𝑎∙𝑒𝑥𝑝(−\frac{𝑗2\pi 𝑓_𝑐 𝑑_𝑖}{c}) = 𝑎∙𝑒𝑥𝑝 (−\frac{𝑗2\pi 𝑑_𝑖}{\lambda_𝑐}) $$
> a: attenuation of the path, which we assume to be the same for all antenna pairs </br>

Because antenna space is much smaller than distance between transmitter and receiver, we can write distance between each antenna pair as:
$$ di\approx 𝑑+(𝑖 − 1)\Delta _𝑟 \lambda _𝑐 \cos \phi , i = 1, ... , n_r $$
Define directional cosine: $ \Omega = cos\phi $. Channel gain will be: </br>
![rx_channel_gain](https://github.com/ChenBlue/Angular-domain-Uniform-linear-array-radiation-reception/blob/master/FIG/rx_channel.JPG)

### LOS of MISO model
The following picture shows MISO model: </br>
![MISO](https://github.com/ChenBlue/Angular-domain-Uniform-linear-array-radiation-reception/blob/master/FIG/MISO.JPG) </br>
Similar to SIMO model, the channel gain is: </br>
![tx_channel_gain](https://github.com/ChenBlue/Angular-domain-Uniform-linear-array-radiation-reception/blob/master/FIG/tx_channel.JPG)

### Angular domain representation of signals
Every linear transformation can be represented as a composition of three operations: a rotation operation, a scaling operation, and another rotation operation. H has a **singular value decomposition (SVD)**:
$$ H=U\Lambda V^* $$
> U & V: (rotation) unitary matrices ; $ \Lambda $: a rectangular matrix

$$ y=U\Lambda V^* x+w⇒U^* y=\Lambda V^* x+U^* w $$

Define: </br>
$$ \tilde{x}=V^* x ; \tilde{y}=U^* y; \tilde{w}=U^* w $$

We can rewrite the channel to angular domain as: </br>
$$ \tilde{y}=\Lambda \tilde{x}+\tilde{w} $$

Orthonormal basis for received signal space will be:
$$ U_r=[e_r (0),e_r (\frac{1}{L_r} ),… e_r (\frac{N_r -1}{L_r }]=U $$

Orthonormal basis for transmitted signal space will be:
$$ U_t=[e_t (0),e_t (\frac{1}{L_t }),… e_t (\frac{N_t -1}{L_t })]=V $$

We now represent the MIMO fading channel $ y=Hx+w $ in the angular domain. $ U_t $ and $ U_r $ are respectively the $ n_t \times n_t $ and $ n_r \times n_r $ unitary matrices. Transformations: 
$$ x^a = U_t^* x,  y^a = U_r ^* y $$
are the changes of coordinates of the transmitted and received signals into angular domain. Substitute this into y=Hx+w, we have channel in angular domain:
$$ y^a =U_r ^* HU_t x^a +U_r^* w=H^a x^a +w^a $$
where
$$ H^a = U_r ^* HU_t $$

### Correlation between two Geographically separated transmit antennas
Two transmit antenna are placed very far apart, so the two channel are independent. Channel matrix $ H=[h_1,h_2] $ </br>
Angle $ \theta $ between the two spatial signatures is 
$$ |cosθ|=|e_r (\Omega _{r1} )^* e_r (\Omega _{r2})| $$ </br>
It only dependes on difference $ \Omega _r =\Omega _{r2} -\Omega _{r1} $ . Define </br>
$$ f_r (\Omega _{r2}- \Omega _{r1} ) = e_r (\Omega _{r1} )^* e_r (\Omega _{r2} ) =\frac{1}{n_r }\sum _{i=1} ^{n_r } e^{-j2\pi (i-1) \Delta _r \Omega _r } =\frac{1}{n_r } \frac{1-e^{-j2\pi \Delta _r n_r \Omega _r }}{1-e^{-j2\pi \Delta _r \Omega _r }}$$

Since $ |1-e^{-j2\theta } |=|2sin\theta | $ </br>
**Normalized length of the receive antenna array**: $ L_r =n_r \Delta_r $
$$ |cos\theta |=\frac{1}{n_r }\frac{|1-e^{-j2π∆_r n_r Ω_r } |}{|1-e^{-j2π∆_r Ω_r } |} =|\frac{sin⁡(πn_r ∆_r Ω_r)}{n_r sin⁡(π∆_r Ω_r)}|=|\frac{sin⁡(πL_r Ω_r)}{n_r sin⁡(\frac{πL_r Ω_r }{n_r } )}| $$

**Beamforming pattern** : If the signal arrives from a single direction $ \phi _0 $, then the optimal receiver projects the received signal onto the vector $ e_r (cos \phi _0) $. A signal from any other direction φ is attenuated by a factor of
$ |e_r (cosφ_0 )^* e_r (cosφ)|=|f_r (cosφ-cosφ_0 )| $ </br>
Polar plot: $(φ,|f_r (cosφ-cosφ_0 )|) $

