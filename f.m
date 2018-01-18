function beam = f(n, delta, omega_array, L)
N = length(omega_array);
beam = zeros(1,N);
for i = 1:N
    beam(i) = 1/n*exp(1i*pi*delta*omega_array(i)*(n-1))*sin(pi*L*omega_array(i))/sin(pi*L*omega_array(i)/n);
end