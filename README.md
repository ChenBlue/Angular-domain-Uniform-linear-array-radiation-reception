# Angular-domain-Uniform-linear-array-radiation-reception
Implement angular-domain model of MIMO channel, and evaluate the Radiation and Reception patterns of Uniform Linear Arrays (ULA). This project is divided to 2 parts, which are SIMO(Single input multiple output) and MISO(Multiple input single output). Besides, we have to set some input parameters as following.
### Input parameters:
* The number of antennas N
* The normalized antenna separation $ \delta $ (normalized to the wavelength $\lambda_c $)
* The radiation or reception directions of the desired signal
* The radiation or reception direction of the interference signal

### Ouput results
* The correlation between two signal with different radiation or reception direction
* Polar beamforming pattern of the ULA
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

### Correlation between two Geographically separated transmitted antennas
Two transmit antenna are placed very far apart, so the two channel are independent. Channel matrix $ H=[h_1,h_2] $ </br>
Angle $ \theta $ between the two spatial signatures is 
$$ |cosθ|=|e_r (\Omega _{r1} )^* e_r (\Omega _{r2})| $$ </br>
It only dependes on difference $ \Omega _r =\Omega _{r2} -\Omega _{r1} $ . Define </br>
$$ f_r (\Omega _{r2}- \Omega _{r1} ) = e_r (\Omega _{r1} )^* e_r (\Omega _{r2} ) =\frac{1}{n_r }\sum _{i=1} ^{n_r } e^{-j2\pi (i-1) \Delta _r \Omega _r } =\frac{1}{n_r } \frac{1-e^{-j2\pi \Delta _r n_r \Omega _r }}{1-e^{-j2\pi \Delta _r \Omega _r }}$$

Since $ |1-e^{-j2\theta } |=|2sin\theta | $ </br>
**Normalized length of the receive antenna array**: $ L_r =n_r \Delta_r $
$$ |cos\theta |=\frac{1}{n_r }\frac{|1-e^{-j2π∆_r n_r Ω_r } |}{|1-e^{-j2π∆_r Ω_r } |} =|\frac{sin⁡(πn_r ∆_r Ω_r)}{n_r sin⁡(π∆_r Ω_r)}|=|\frac{sin⁡(πL_r Ω_r)}{n_r sin⁡(\frac{πL_r Ω_r }{n_r } )}| $$

**Beamforming pattern** : If the signal arrives from a single direction $ \phi _0 $, then the optimal receiver projects the received signal onto the vector $ e_r (cos \phi _0) $. A signal from any other direction φ is attenuated by a factor of
$$ |e_r (cosφ_0 )^* e_r (cosφ)|=|f_r (cosφ-cosφ_0 )| $$
Polar plot: $(φ,|f_r (cosφ-cosφ_0 )|) $

For geographically separated **received** antennas, the concepts is similar to separated transmitted antennas.

## Result
### SIMO
**Input parameters**:
*	Number of received antenna: $ N_r $=5
*	The normalized antenna separation: 1/2
*	The reception directions of the desired signal: π/4
*	The reception direction of the interference signal: π/2

1. Correlation between two signal with different radiation or reception direction $ \theta $ </br>
We use $ |f_r (Ω_r )|=|f_r (Ω_{r2}-Ω_{r1} )|=|cos\theta | $ to represent the correlation between two different signal, which is shown as following image. </br>
![corr](https://github.com/ChenBlue/Angular-domain-Uniform-linear-array-radiation-reception/blob/master/FIG/corr_SIMO.jpg) </br>
Besides, here will show some correlation comparison with different $ n_r $ and $ ∆_r $ </br>
![corr](https://github.com/ChenBlue/Angular-domain-Uniform-linear-array-radiation-reception/blob/master/FIG/corr_dif.JPG) </br>
For the last figure $ (∆_r =1/1000) $, we can see that, as $ n_r \rightarrow \infty $ and $ ∆_r \rightarrow 0 $.
$$ f_r (Ω)\rightarrow e^{jπL_r Ω_r } sinc(L_r Ω_r) $$

2. Polar beamforming pattern of ULA </br>
Polar plot of $ |f_r (Ω_{r2}-Ω_{r1} )|=|f_r (cosφ-cosφ_0 )| $. **Main lobe** is around reception direction of signal $ \phi _0 $ and also any $ \phi $ for: $ cos\phi =cos\phi _0 $ mod $ 1/∆_r $. Moreover, **Beamwidth** is determined by $ 2/L_r $. The following figure is our received gain pattern with $ \phi _0=π/4 $, and $ ∆_r=1/2 $, $ L_r=5/2 $. We can see that main lobe is around +45° and-45°. </br>
![beam](https://github.com/ChenBlue/Angular-domain-Uniform-linear-array-radiation-reception/blob/master/FIG/beam_SIMO.jpg) </br>

Here, I will show other beamforming patterns with different $ phi_0 $, $ L_r $, $ ∆_r $ </br>
* Different $ \phi _0 $ </br>
![beamphi](https://github.com/ChenBlue/Angular-domain-Uniform-linear-array-radiation-reception/blob/master/FIG/beam_phi.JPG) </br>
*	Different $ L_r $ </br>
![beamL](https://github.com/ChenBlue/Angular-domain-Uniform-linear-array-radiation-reception/blob/master/FIG/beam_L.JPG) </br>
* Different $ ∆_r $ </br>
![beamDelta](https://github.com/ChenBlue/Angular-domain-Uniform-linear-array-radiation-reception/blob/master/FIG/beam_delta.JPG) </br>

3. The SINR of multiple input signals (multiple reception directions) with **diversity combining** </br>
I implemented this part by **MRC (Maximal ratio combining)**, and the **SINR = 16.9243 dB**

### MISO
**Input parameters**:
* Number of received antenna: $ N_t =7 $
* The normalized antenna separation: 1/2
*	The reception directions of the desired signal: π/6
*	The reception direction of the interference signal: π/3
 </br>
Basically, the result of MISO is similar to SIMO.
1. Correlation between two signal with different radiation or reception direction $ \theta $ </br>
![corr_MISO](https://github.com/ChenBlue/Angular-domain-Uniform-linear-array-radiation-reception/blob/master/FIG/corr_MISO.jpg) </br>

2. Polar beamforming pattern of ULA </br>
![beam_MISO](https://github.com/ChenBlue/Angular-domain-Uniform-linear-array-radiation-reception/blob/master/FIG/beam_MISO.jpg) </br>

3. The SINR of multiple input signals (multiple reception directions) with **diversity combining** </br>
I view different transmitted signals as different received signals and combined them together. I use MRC strategy and get the **SINR = 35.75 dB**
