clc, close all, clear all

%in sallen key low pass circuit from wikipedia
% r1 = mR
% r2 = R/m
% c1 = nC
% c2 = C/n
% this means that R/m and Rm has to be e12. Thus to resistors r1=m^2r2
% should be found in e12, (same for c) c1=n^2c2
% gives similar cutoff to red pitaya however this is second order :D


f = 1/(2*pi*100*8.2e-9);
Q = 1/sqrt(2);
gain = 8;
Q_importance = 10;

e12 = [1 1.2 1.5 1.8 2.2 2.7 3.3 3.9 4.7 5.6 6.8 8.2];
e12_rations = e12./e12';
gains = 1 + (e12_rations);
best_error_sum = inf;

c0 = 10e-12;
r0 = 10e3;
for r3_t = e12*r0
    for r4_t = e12*r0
        k_t = 1+r4_t/r3_t;
        for c1_t = e12*c0
            for c2_t = e12*c0
                for r1_t = e12*r0
                    for r2_t = e12*r0
                        w0_got = 1/sqrt(r1_t*r2_t*c1_t*c2_t);
                        f0_got = w0_got/2/pi;
                        Q_got = sqrt(r1_t*r2_t*c1_t*c2_t)/(c2_t*(r1_t+r2_t)+r1_t*c1_t*(1-k_t));
                        error_sum = (Q_importance*(Q_got - Q)/Q)^2 + ((f0_got - f)/f)^2 + (k_t-gain)^2;
                        if error_sum < best_error_sum
                            best_error_sum = error_sum;
                            r1 = r1_t;
                            r2 = r2_t;
                            c1 = c1_t;
                            c2 = c2_t;
                            r3 = r3_t;
                            r4 = r4_t;
                            k = k_t;
                        end
                    end
                end
            end
        end
    end
end

w0 = 1/sqrt(r1*r2*c1*c2);
f_calc = w0/2/pi;
Q_calc = sqrt(r1*r2*c1*c2)/(c2*(r1+r2)+r1*c1*(1-k));
gain_calc = 1+r4/r3;

