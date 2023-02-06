s = tf('s');

% tf for x=0ft
tf0 = tf((0.421*s^4 - 1.84* s^3 - 22.15 *s^2 + 0.077 *s + 0.001231) / (s^5 + 21.73*s^4 + 33*s^3 + 41.48 *s^2 + 0.5546 *s + 0.293))
% tf for x=5 ft
tf5 = tf((0.06419*s^4 - 2.066* s^3 - 22.15 *s^2 + 0.077 *s + 0.001231) / (s^5 + 21.73*s^4 + 33*s^3 + 41.48 *s^2 + 0.5546 *s + 0.293))
% tf for x=5.9 ft
tf59 = tf((-3.201e-05*s^4 - 2.107*s^3 - 22.15*s^2 + 0.077*s + 0.001231) / (s^5 + 21.73*s^4 + 33*s^3 + 41.48*s^2 + 0.5546 *s + 0.293))
% tf for x=6ft

% tf for x=7ft

% tf for x=15ft
opt = stepDataOptions("StepAmplitude", -1);

t = 0:0.001:0.05;
[y0, t] = step(tf0, t, opt);
[y5, t] = step(tf5, t, opt);
[y59, t] = step(tf59, t, opt);
% [y0, t] = step(tf0, t, opt);
% [y0, t] = step(tf0, t, opt);
% [y0, t] = step(tf0, t, opt);

% plot(t, y0)

xlabel('Time (s)');
ylabel('Normal acceleration (g)');

hold on;
% plot(t, y5);
plot(t, y59);
hold off;