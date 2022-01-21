clc, close all, clear all
gains = [2,3,10,20];
opt = optimoptions('fsolve', 'OptimalityTolerance', 1e-20, 'MaxFunctionEvaluations', 1e4, 'MaxIterations', 1e4);
[x, tol] = fsolve(@(x) tosolve(x,gains), [10 10 1 2], opt);
e12 = [1 1.2 1.5 1.8 2.2 2.7 3.3 3.9 4.7 5.6 6.8 8.2];

x_mag = 10.^floor(log10(x));
[c, closest_e12_i] = min(abs(e12'-x./x_mag));
x_e12 = e12(closest_e12_i) .* x_mag;

tosolve(x_e12, gains) + gains(1:3)
1+x_e12(3)/x_e12(4)

function F = tosolve(x, gains)
    F(1) = 1+x(1)/x(2) - gains(1);
    F(2) = 1+x(1)/x(4) - gains(2);
    F(3) = 1+x(3)/x(2) - gains(3);
    %F(4) = 1+x(3)/x(4) - gains(4);
end