function signature = e(omega, n, delta)
i = 0:n-1;
signature = 1/sqrt(n).*transpose(exp(-1i*2*pi*delta*omega.*i)); 