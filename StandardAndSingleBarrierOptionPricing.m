clc; clear

% OpTion Choice
% 1 - European Call, 2 - European PuT
% 3 - Down and OuT Call, 4 - Down and In Call
% 5 - Up and OuT Call, 6 - Up and In Call
% 7 - Down and OuT PuT, 8 - Down and In PuT
% 9 - Up and OuT PuT, 10 - Up and In PuT 
OPTION = 5;

S = 100;     % STock Price aT T = 0
K = 105;     % STrike Price
r = 0.025; %InTeresT RaTe
b = 0
U = 120 %Upper Barrier
L = 80 %Lower Barrier
N1= 0
N2= 0 
T = 1;    % OpTion Expiry Time 
V = 0.25;    % VolaTiliTy of STock
H = 115;     % Barrier
Q = 0;   % Dividend RaTe

d1 = (log(S / K) + (r - Q + (V^2) / 2) * T) / (V * sqrt(T));
d2 = d1 - V * sqrt(T);

%European Call
C = S * normcdf(d1) - K * exp(-r * T) * normcdf(d2);
%European PuT
P = K * exp(-r * T) * normcdf(-d2) - S * exp(-Q * T) * normcdf(-d1);

%Lambda
G = (r - Q + (V^2) / 2) / (V^2);
%Y
y = log(H^2 / (S * K)) / (V * sqrt(T)) + G * V * sqrt(T);
%X1
X1 = (log(S / H) / (V * sqrt(T))) + G * V * sqrt(T);
%Y1
Y1 = (log(H / S) / (V * sqrt(T))) + G * V * sqrt(T);

if H < K
%Down and In Call
Cdi = S * exp(-Q * T) * (H / S)^(2 * G) * normcdf(y) - K * exp(-r * T) * (H / S)^(2 * G - 2) * normcdf(y - V * sqrt(T));
%Down and OuT Call
Cdo = C - Cdi;
%Up and OuT Call
Cuo = 0;
%Up and In Call
Cui = C;
%Up and OuT PuT 
Puo = 0;
%Up and In PuT
Pui = P - Puo;
%Down and In PuT 
Pdi = -S * normcdf(-X1) * exp(-Q * T) + K * exp(-r * T) * normcdf(-X1 + V * sqrt(T)) + S * exp(-Q * T) * ((H/S)^(2 * G)) * (normcdf(y) - normcdf(Y1)) - K * exp(-r * T) * ((H/S)^(2 * G - 2)) * (normcdf(y - V * sqrt(T)) - normcdf(Y1 - V * sqrt(T)));
%Down and OuT PuT 
Pdo = P - Pdi;
else 
%Down and OuT Call
Cdo = 0;
%Down and In Call
Cdi = C - Cdo;
%Up and In Call
Cui = S * normcdf(X1) * exp(-Q * T) - K * exp(-r * T) * normcdf(X1 - V * sqrt(T)) - S * exp(-Q * T) * (H/S)^(2 * G) * (normcdf(-y) - normcdf(-Y1)) + K * exp(-r * T) * ((H/S)^(2 * G - 2)) * (normcdf(-y + V * sqrt(T)) - normcdf(-Y1 + V * sqrt(T)));
%Up and OuT Call
Cuo = C - Cui;
%Up and In PuT 
Pui = -S*exp(-Q*T)*(H/S)^(2*G)*normcdf(-y) + K*exp(-r*T)*(H/S)^(2*G-2)*normcdf(-y + V * sqrt(T));
%Up and OuT PuT
Puo = P - Pui;
%Down and OuT PuT
Pdo = 0;
%Down and In PuT 
Pdi = P;
end

if OPTION == 1
C
elseif OPTION == 2
P
elseif OPTION == 3
Cdo
elseif OPTION == 4
Cdi
elseif OPTION == 5
Cuo
elseif OPTION == 6
Cui
elseif OPTION == 7
Pdo
elseif OPTION == 8
Pdi
elseif OPTION == 9
Pui
elseif OPTION == 10
Puo
else
disp('Invalid Option Choice');
end
