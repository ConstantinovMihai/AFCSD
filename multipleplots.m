% plots the initial responses of the an to a negative step input for
% several accelerometer positions on the Xb axis

s = tf('s');

% tf for x=0ft
tf0 = tf((0.421*s^4 - 1.84* s^3 - 22.15 *s^2 + 0.077 *s + 0.001231) / (s^5 + 21.73*s^4 + 33*s^3 + 41.48 *s^2 + 0.5546 *s + 0.293));
% tf for x=5 ft
tf5 = tf((0.06419*s^4 - 2.066* s^3 - 22.15 *s^2 + 0.077 *s + 0.001231) / (s^5 + 21.73*s^4 + 33*s^3 + 41.48 *s^2 + 0.5546 *s + 0.293));
% tf for x=5.9 ft
tf59 = tf((-3.201e-05*s^4 - 2.107*s^3 - 22.15*s^2 + 0.077*s + 0.001231) / (s^5 + 21.73*s^4 + 33*s^3 + 41.48*s^2 + 0.5546 *s + 0.293));
% tf for x=6ft
tf6 = tf((-0.007168*s^4 - 2.112 *s^3 - 22.15* s^2 + 0.077* s + 0.001231) / (s^5 + 21.73 *s^4 + 33* s^3 + 41.48 *s^2 + 0.5546 *s + 0.293));
% tf for x=7ft
tf7 = tf(( -0.07853 *s^4 - 2.157* s^3 - 22.15 *s^2 + 0.077 *s + 0.001231) / (s^5 + 21.73* s^4 + 33* s^3 + 41.48 *s^2 + 0.5546 *s + 0.293));
% tf for x=15ft
tf15 = tf(( -0.6494 *s^4 - 2.519 *s^3 - 22.16* s^2 + 0.077 *s + 0.001231) / (s^5 + 21.73 *s^4 + 33* s^3 + 41.48* s^2 + 0.5546 *s + 0.293));

opt = stepDataOptions("StepAmplitude", -1);

t = 0:0.005:0.25;
[y0, t] = step(tf0, t, opt);
[y5, t] = step(tf5, t, opt);
[y59, t] = step(tf59, t, opt);
[y6, t] = step(tf6, t, opt);
[y7, t] = step(tf7, t, opt);
[y15, t] = step(tf15, t, opt);
% [y59, t] = step(tf59, t, opt);[y0, t] = step(tf0, t, opt);
% [y0, t] = step(tf0, t, opt);
% [y0, t] = step(tf0, t, opt);

% plot(t, y0)

xlabel('Time (s)');
ylabel('Normal acceleration (g)');

hold on;
% h(1) = plot(t, y0);
% h(2) = plot(t, y5);
h(3) = plot(t, y59);
% h(4) = plot(t, y6);
% h(5) = plot(t, y7);
% h(6) = plot(t, y15);
grid on
hold off;

legend('x_a = 0 ft','x_a = 5 ft', 'x_a = 5.9 ft','x_a = 6 ft','x_a = 7 ft','x_a = 15 ft', 'Location','best')