% plotting simulink signals

out = sim('interpolated.slx');

t = out.tout;
pitch_angle = out.pitch_angle.Data;
pitch_rate = out.pitch_rate.Data;
stepr = out.square_signal.Data;

hold on;
grid on;

plot(t, pitch_angle, 'LineWidth', 1.5);
plot(t, pitch_rate,  'LineWidth', 1.5);
plot(t, stepr,  'LineWidth', 1.5)

xlabel('Time (s)') 
ylabel('Response magnitude')
hold off;

legend('Pitch angle','Pitch rate', 'Input', 'Location','best')