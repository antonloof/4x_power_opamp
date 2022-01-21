clc, close all, clear all

%in sallen key low pass circuit from wikipedia
% r1 = mR
% r2 = R/m
% c1 = nC
% c2 = C/n
% this means that R/m and Rm has to be e12. Thus to resistors r1=m^2r2
% should be found in e12, (same for c)

r = 5600;
c = 100e-9;
Q = 1/sqrt(2);
n_min = sqrt(1.5);

e12 = [1 1.2 1.5 1.8 2.2 2.7 3.3 3.9 4.7 5.6 6.8 8.2];
ratios = sqrt(e12./(e12'));
ratios = ratios(:);
n_ratios = ratios(ratios >= n_min);

top_best_n = inf;
top_best_m = inf;
r1 = 0;
r2 = 0;
c1 = 0;
c2 = 0;

for n=[1.5]
    [m, tol] = fsolve(@(x) x*n/(x.^2+1)-Q, 10);
    [~, best_m_e12_i] = min(abs(ratios-m^2));
    best_m = ratios(best_m_e12_i);
    top_i = mod(best_m_e12_i, length(e12));
    bottom_i = (best_m_e12_i - top_i) / length(e12);
    r1 = e12(bottom_i + 1) / e12(top_i);
    
    if (best_m - m) < top_best_m 
       top_best_m = best_m;
       top_best_n = n;
       r1 = 
    end
end
