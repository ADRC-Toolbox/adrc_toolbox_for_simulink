function wyjscie = kinematyka(wejscie)

L1 = 0.25;
L2 = 0.18;

q1 = wejscie(1);
q2 = wejscie(2);

wyjscie = [L1*sin(q1)+L2*sin(q1+q2) ; -L1*cos(q1)-L2*cos(q1+q2)];