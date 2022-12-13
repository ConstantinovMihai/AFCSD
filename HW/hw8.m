mdl = "springslx";
% 
% open_system("springslx");
a = [0, 1; -0.02, 0];

lynsis = linearize(mdl);

[V, D] = eigs(a);
V = V
v1 = V(:,1)
v2 = V(:,2)
in = v1 + v2
Tf = 100;
initial(lynsis, in, Tf)