addpath('/home/user/chebfun');

%% Q1
f = chebfun('x^5 - exp(-x^2)');
r = roots(f);
disp(r);

%% Q2
f = chebfun('exp(-x^2 / 10) * (sin(x) + sin(11 * x) + sin(111 * x))', [-inf inf]);
disp(max(f));

%% Q3
f = chebfun('exp(-x^2) * sin(x)', [0 inf]);
disp(sum(f));

%% Q4
f = chebfun('besselj(1, x)', [1000 1100]);
r = roots(f);
disp(r(1));

%% Q5
f = chebfun('exp(-x^2) + exp(-x^4) * sin(10 * x)', [-inf inf]);
r = min(f, 'local');
disp(length(r));

%% Q6
f = chebfun('sin(100 * x) / (1 + x^2)');
disp(norm(diff(f), 1));

%% Q7
f = chebfun('x * sin(x) - (1 + x + x^2) * 0.5 * cos(x)', [0 1]);
disp(roots(f));

%% Q8
f = @(p) chebfun(@(x) cos(x)^p);
g = chebfun(@(a) sum(f(a)), [0 1000]);
disp(roots(g-0.1));

%% Q9
f = chebfun('exp(x - x^4)', [0 10]);
disp(roots(cumsum(f) - 1));

%% Q10
f = chebfun('sin(x) + sin(pi * x)', [0 100]);
g = f > 1;
disp(sum(g));

%% Q11
f = chebfun('atan(x)');
c = chebcoeffs(f);
disp(c(6));

%% Q12
disp(norm(chebfun('exp(x)') - minimax('exp(x)', 6), inf));

%% Q13



%% Q14



%% Q15 TO DO
A = [-1 2; 3 -2];
B = [1 2; 3 4];
u = [1; 1];

f1 = chebfun(@(x) [1 0] * (B * expm(x * A) * u), [0 inf]);
f2 = chebfun(@(x) [0 1] * (B * expm(x * A) * u), [0 inf]);
disp(sum(norm(f1(x))));
disp(sum(norm(f1(x))));

%% Q16
f = chebfun('sqrt(abs(gamma(x)))', [-3 3], 'splitting', 'on');
disp(sum(f));


%% Afternoon

rng(5050);

k = 5;
rmax = 30;

L1 = chebop(0.1, rmax);
L1.op = @(t, x) diff(x, 2) + 2 / t * diff(x) + x^k;
L1.lbc = [1; 0];
x1 = L1\0;

tic
L2 = chebop(0.1, rmax);
L2.op = @(t, x) diff(x, 2) + 2 / t * diff(x) + x^k + randnfun(0.01, [0.1 rmax], 'big');
L2.lbc = [1; 0];
x2 = L2\0;
toc

plot(x1);
hold on;
plot(x2);








