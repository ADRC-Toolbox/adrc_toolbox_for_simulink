function wyjscie = kinematyka_odwr(wejscie)

L1 = 0.25;
L2 = 0.18;

xd = wejscie(1);
yd = wejscie(2);
XD = [xd ; yd];

xd_prim = wejscie(3);
yd_prim = wejscie(4);
XD_prim = [xd_prim ; yd_prim];

q1 = wejscie(5);
q2 = wejscie(6);

alfa = 5;

X = [L1*sin(q1)+L2*sin(q1+q2) ; -L1*cos(q1)-L2*cos(q1+q2)];

Ja = [L1*cos(q1)+L2*cos(q1+q2) L2*cos(q1+q2) ; L1*sin(q1)+L2*sin(q1+q2) L2*sin(q1+q2)];

detJa = Ja(1,1)*Ja(2,2) - Ja(1,2)*Ja(2,1);

if (abs(detJa) < 0.01)
    wyjscie = [10 ; 10];
else
    iJa = [Ja(2,2) -Ja(1,2) ; -Ja(2,1) Ja(1,1)]*1/detJa;
    wyjscie = iJa*(XD_prim + alfa*(XD - X));
end