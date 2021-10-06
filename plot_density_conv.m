
df = [3, 6];
N = 2^10;
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

sum_pdf =  conv(t_pdf(:,1) * dx, t_pdf(:, 2) * dx) / dx;

new_grid = linspace(x_min, x_max, length(sum_pdf));

plot(new_grid, sum_pdf)

%% My own convolution

for s = 2 * min_x : 2 * max_x
    for 
    prob(s) = t_pdf(, 1) * t_pdf(:, 2) * dx^2