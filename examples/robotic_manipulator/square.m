function out = square(in)

L1 = 0.25;
L2 = 0.18;

Ox = 0.2;  %Wspolrzedna x srodka elipsy w m
Oy = -0.2;  %Wspolrzedna y srodka elipsy w m

Rx = 0.1;  %promien x ruchu w m
Ry = 0.1;  %promien y ruchu w m

To = 8;          %okres obiegu figury w s
tx = 0;          %dodatkowy parametr do powtarzania okrazen

if (in > To && in <= 2*To)
    tx = To;
end

t = in - tx;

vx = 2*Rx/(0.25*To);
vy = 2*Ry/(0.25*To);

if (t <= To/4)
    xd = Ox - Rx + vx*t;
    yd = Oy - Ry;
    xdprim = vx;
    ydprim = 0;
elseif (t > To/4 && t <= To/2)
    xd = Ox + Rx;
    yd = Oy - Ry + vy*(t-To/4);
    xdprim = 0;
    ydprim = vy;
elseif (t > To/2 && t <= 3*To/4)
    xd = Ox + Rx - vx*(t-To/2);
    yd = Oy + Ry;
    xdprim = -vx;
    ydprim = 0;
elseif (t > 3*To/4 && t <= To)
    xd = Ox - Rx;
    yd = Oy + Ry - vy*(t-3*To/4);
    xdprim = 0;
    ydprim = -vy;
else 
    xd = 0;
    yd = -L1-L2;
    xdprim = 0;
    ydprim = 0;
end

out = [xd yd xdprim ydprim]';