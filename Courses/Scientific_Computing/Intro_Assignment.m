% Exercise 1.1
0.8 * (7/13 + 5/7)
(2-3i)/(1+(1-4i)/(3-2i))
1/sqrt(1-(5*10^7/(8*10^8))^2)

% Exercise 1.2
A = magic(3)
d = diag(A)
B = [0 d'; d A]
size(B)

% Exercise 1.3
[-10:10]
[7:-1/3:2]
[2:0.05:3]*i

% Exercise 1.4
d'*d
d*d'
A'*d
B*[ones(1, 3); A]
C = A + i*inv(A)
C'
conj(C)
pinv(C)
det(A)
eig(A)

% Exercise 1.5
M = magic(5)
m = M(:)
m2 = flip(m)
M2 = reshape(m2,[5,5])
sort(M2) % sort(M2, 2)
max(M2) % max(M2, 'all')
prod(size(M2))
numel(M2)

% Exercise 1.6
format long
t = linspace(0,1,10);
integrand = 2 / sqrt(pi) * exp(-t.^2);
(t(2) - t(1)) * sum(integrand);

results = zeros(5,2);
for i = 1:5
    t = linspace(0,1,10^i);
    integrand = 2 / sqrt(pi) * exp(-t.^2);
    results(i,:) = [10^i, (t(2) - t(1)) * sum(integrand)];
end
results

loglog(results(:,1), abs(results(:,2) - erf(1)))

f = @(t) 2 / sqrt(pi) * exp(-t.^2);
quad(f, 0, 1)

% Exercise 1.7
x = linspace(0,1,10^5);
trapz(x, exp(x.^3))

x = linspace(0,10,10^5);
trapz(x, (1 + x.^4).^(-1.0 / 2))

x = linspace(0,5,10^5);
trapz(x, sin(exp(x / 2)))