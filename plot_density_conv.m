
df = [3, 6];
N = 2^15;
x_min = -10;
x_max = 10;
dx = (x_max - x_min) / N;

grid = linspace(x_min, x_max, N);

t_pdf = zeros(length(grid), length(df));

for j = 1:length(df)
    t_pdf(:,j) = tpdf(grid, df(j));
    plot(grid, t_pdf(:,j))
    xlabel('x'), ylabel('density')
    hold on
end
legend("df = 3", "df = 6")


% Test if Density is fine:
% sum(t_pdf * dx)

%% Now we try to do a convolution
% it works, but figure out something more elegant
sum_pdf =  conv(t_pdf(:,1), t_pdf(:, 2)) * dx;
new_grid = linspace(2 * x_min, 2 * x_max, length(sum_pdf));
plot(new_grid, sum_pdf)

%% characteristic function

% first cf:
%cf_t1 = @(t) (besselk(v1 / 2, sqrt(v1) .* abs(t)) * (sqrt(v1) * abs(t)) .^ (v1 / 2)) / (gamma(v1 / 2) * 2 ^ (v1 / 2 - 1));
%
%cf_t2 = @(t) (besselk(v2 / 2, sqrt(v2) .* abs(t)) * (sqrt(v2) * abs(t)) .^ (v2 / 2)) / (gamma(v2 / 2) * 2 ^ (v2 / 2 - 1));


%fplot(cf_t1)
%hold on
%fplot(cf_t2)
%hold off
%z_pdf = 1/2 * t_pdf(:,1);
%plot(2 * grid, z_pdf)


% set up characteristic function
%t = linspace(-10, 10, N);
v1 = df(: , 1);
v2 = df(:, 2 );

% FUNCTION AS A VECTOR
% cf_t1 = (besselk(v1 / 2, sqrt(v1) .* abs(t)) .* (sqrt(v1) * abs(t)) .^ (v1 / 2)) / (gamma(v1 / 2) * 2 ^ (v1 / 2 - 1));
% cf_t2 = (besselk(v2 / 2, sqrt(v2) .* abs(t)) .* (sqrt(v2) * abs(t)) .^ (v2 / 2)) / (gamma(v2 / 2) * 2 ^ (v2 / 2 - 1));
% cf_sum = cf_t1 .* cf_t2;

cf_t1 = @(t) (besselk(v1 / 2, sqrt(v1) .* abs(t)) .* (sqrt(v1) * abs(t)) .^ (v1 / 2)) / (gamma(v1 / 2) * 2 ^ (v1 / 2 - 1));
cf_t2 = @(t) (besselk(v2 / 2, sqrt(v2) .* abs(t)) .* (sqrt(v2) * abs(t)) .^ (v2 / 2)) / (gamma(v2 / 2) * 2 ^ (v2 / 2 - 1));

cf_sum =  @(t) cf_t1(t) .* cf_t2(t);

% plot(t, cf_t1)
% hold on
% plot(t, cf_t2)
% plot(t, cf_t1 .* cf_t2)
% hold off




% from a paper:
k = 0:(N-1); % k indices 0 : N-1
j = 0:(N-1); % j indices 0 : N-1

cf_normal = @(t) exp(-t.^2/2); 
cf_triangular = @(t) min(1, (2 - 2* cos(t)) ./t.^2);
%%
% get NaN for u = 0.

dy = (x_max - x_min) / N; % delta_y
y = x_min + k * dy; % y_k
u = (j - N/2)/(x_max - x_min); % u_j
phi = (-1).^(-(2*x_min/(x_max-x_min))*j) .* cf_sum(2*pi*u);

find(isnan(phi));
phi = fillmissing(phi, 'constant', 1);
C = ((-1).^((x_min/(x_max-x_min) + k/N)*N))/(x_max-x_min);
pdf = real(C .* fft(phi)); % FFT

plot(grid, pdf)       % it does work. careful with grid dimension!