m = 250;
n = 150;
r = 100;
l = 5;

A = rand(m, n);

Omega = rand(n, r + l);
[Q R] = qr(A * Omega);
[U S V] = svd(Q' * A);

U = Q * U;
U = U(:,1:r);
S = S(1:r,1:r);
V = V(:,1:r);

Arand = U * S * V';

[Ur Sr Vr] = svd(A);

Ur = U(:,1:r);
Sr = S(1:r,1:r);
Vr = V(:,1:r);

Ar = Ur * Sr * Vr';

norm(A - Arand) / norm(A - Ar)

