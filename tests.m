s = tf('s'); 

sys1 = (1-s)/(s^2 + 2*s + 2);
sys2 = (1 - s/40) /(s^2 + 2*s + 2);

t = 0:0.05:8;
[y1, t] = step(sys1, t);

y2 = step(sys2, t);
min(y2)
figure(1)
% answer to question 5.6
plot(t, y1);

figure(2)
plot(t, y2);