function f = plot_density(df)

%df = [3, 6];
N = 2^10;
x_min = -10;
x_max = 10;
dx = (x_max - x_min) / N;

grid = [x_min : dx : x_max];

t_pdf = zeros(length(grid), length(df));

for j = 1:length(df)
    t_pdf(:,j) = tpdf(grid, df(j));
    plot(grid, t_pdf(:,j))
    xlabel('x'), ylabel('density')
    hold on
end
legend("df = 3", "df = 6")
hold off

f = t_pdf;