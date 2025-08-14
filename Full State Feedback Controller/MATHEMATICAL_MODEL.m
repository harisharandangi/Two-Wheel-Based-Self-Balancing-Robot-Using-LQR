Mw = 1;
Iw = 0.0313;
r = 0.25;
m = 70;
g = 9.8;
l = 1;
d = 0.5;
M = 5;
IM = 0.0385;
IP = 1.8569;

a21 = -(((m*l*g)*(M-m+2*((Iw/r^2)+Mw))) / ((m^2*l^2) + ((M-m+2*((Iw/r^2)+Mw))*((m*l^2)+IM))));
a31 = -((m^2*l^2*g) / ((m^2*l^2) + ((M-m+2*((Iw/r^2)+Mw))*(m*l^2+IM))));

b21 = -((m*l) / (r * ((m^2*l^2) + ((M-m+(2*((Iw/r^2)+Mw))) * ((m*l^2)+IM)))));
b22 = b21;

b31 = ((m*l^2)+IM) / (r * ((m^2*l^2) + ((M-m+(2*((Iw/r^2)+Mw))) * ((m*l^2)+IM))));
b32 = b31;

b51 = d / (r * (IP + d^2 * (Mw + (Iw/r^2))));
b52 = -b51;

Q = diag([10, 1, 1, 10, 1]);
R = eye(2);

K = [
    -153.4625, -16.8037, 0.7071, 2.2361, 1.7307;
    -153.4625, -16.8037, 0.7071, -2.2361, -1.7307
];

A = [0 1 0 0 0;
     a21 0 0 0 0;
     a31 0 0 0 0;
     0 0 0 0 1;
     0 0 0 0 0];

B = [0 0;
     b21 b22;
     b31 b32;
     0 0;
     b51 b52];

C = [1 0 0 0 0;
     0 0 0 0 0;
     0 0 0 0 0;
     0 0 1 0 0;
     0 0 0 0 0];

D = zeros(5, 2);
F = A-B*K;
cl_sys = ss(F, B, C, D);

t = 0:0.1:100;  % smaller step for smoother plot
x0 = [-1; 0; 0; 0; 0];
step_input=step(cl_sys, t);
[y, t_out, x] = initial(cl_sys, x0, t);


figure;
plot(t_out, y(:,1), 'LineWidth', 2); % first output
hold on;
plot(t_out, y(:,4), 'LineWidth', 2); % fourth output
hold off;

xlabel('Time (s)');
ylabel('tilt_angle,heading_angle');
title('Closed-Loop Response of Selected Outputs');
grid on;
legend('tilt_angle', 'heading_angle');

