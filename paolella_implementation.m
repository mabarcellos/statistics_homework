% Paolella's application

T = 2^10;
dx = 0.002;
ell = -3;

t = - (T/2) : (T/2) - 1;      % -1 makes sure you have length T.
s = 2 * pi * t/T;             % ranges from - pi to pi.
s = s / dx;

phi = exp(-(s.^2)/2);

g = phi .* exp(-i * s * ell);
P = ifft(g);
pdf = P/dx;

f = abs(pdf); % taking absolute values
f = f(end:-1:1) % reversing the vector

x = linspace(ell, -ell, length(f))

true = normpdf(x); 
plot(x,f)