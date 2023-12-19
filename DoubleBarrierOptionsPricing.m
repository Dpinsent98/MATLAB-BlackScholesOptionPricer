U = 80
L = 120
S = 100
T = 1
V = 0.25
K = 105
b = 0
r = 0.025
delta1 = 0 
delta2 = 0

A = zeros(13,1)
B = zeros(13,1)

for n = -6:6

F = U*exp(delta1*T);
d1 = ((log(S*U^(2*n)/K*L^(2*n)) + (b + (V^2)/2)*T))/(V * sqrt(T));
d2 = ((log(S*U^(2*n)/F*L^(2*n)) + (b + (V^2)/2)*T))/(V * sqrt(T));
d3 = ((log(L^(2*n+2)/K*S*U^(2*n)) + (b + (V^2)/2)*T))/(V * sqrt(T));
d4 = ((log(L^(2*n+2)/F*S*U^(2*n)) + (b + (V^2)/2)*T))/(V * sqrt(T));
mu1 = 2 * (b - delta2 - n * (delta1 - delta2)) / (V^2) + 1;
mu2 = 2 * n * (delta1 - delta2) / (V^2);
mu3 = 2 * (b - delta2 - n * (delta1 - delta2)) / (V^2) + 1;
    
A(n+7,1) = (U^n/L^n)^(mu1)*(L/S)^(mu2)*(normcdf(d1)-normcdf(d2)) - ((L^(n+1))/(U^(n)*S))^(mu3)*(normcdf(d3)-normcdf(d4))
B(n+7,1) = (U^n/L^n)^(mu1-2)*(L/S)^(mu2)*(normcdf(d1 - V*sqrt(T))-normcdf(d2 - V*sqrt(T))) - ((L^(n+1))/(U^(n)*S))^(mu3-2)*(normcdf(d3-V*sqrt(T))-normcdf(d4-V*sqrt(T)))

end

A1 = sum(A,"all")
B1 = sum(B,"all")
C = S*exp((b-r)*T)*A1 - K*exp(-r*T)*B1

