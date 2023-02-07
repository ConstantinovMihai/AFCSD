H = tf(SS_long_lo_GS_red);
Hel_theta = H(4,2);
H_servo = tf(20.2,[1,20.2]);
H_p = H_servo*Hel_theta;
s = tf([1,1],1);



Hcl = -436*H_p/(1+-436*H_p);
Hcl2 = Hcl/(1+Hcl*s);

sisotool(Hcl)

