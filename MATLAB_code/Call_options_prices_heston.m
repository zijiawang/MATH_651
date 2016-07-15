function call = callHestoncf (S,X,tau ,r,q,v0 ,theta ,rho ,kappa, sigma )
% callHestoncf Pricing function for European calls
% callprice = callHestoncf (S,X ,tau ,r,q,v0 ,theta ,rho ,kappa, sigma )

% Example: CLJ16 options pricing

S = 37.9; %S_0
tau = 0.03571; %maturity
r = 0.0065; %riskfree rate
q = 0; %dividend yield
v0 = 0.1; %initial variance
rho =-0.7813498;%correlation 
kappa =0.6516818; %speed of mean reversion ( kappa in heston model )
sigma =0.1506341; %volatility of volatility (sigma_V in heston model)
theta =0.1790808; %theta

for i=25:54
    X(i)=i+0.5; %iF the srike price is integer, then let X(i)=i
vP1 = 0.5 + 1/ pi * quadl(@P1 ,0 ,200 ,[] ,[] ,S,X(i),tau ,r,q,v0 ,theta ,rho ,kappa, sigma );
vP2 = 0.5 + 1/ pi * quadl(@P2 ,0 ,200 ,[] ,[] ,S,X(i),tau ,r,q,v0 ,theta ,rho ,kappa, sigma );
call(i) = exp (-q * tau ) * S * vP1 - exp (-r * tau ) * X(i) * vP2 ;
end
end
%
function p = P1(om ,S,X,tau ,r,q,v0 ,theta ,rho ,kappa, sigma )
i=1i;
p = real ( exp (-i* log (X)*om) .* cfHeston (om -i,S,tau ,r,q,v0 ,theta ,rho ,kappa, sigma ) ./ (i *om * S * exp ((r-q) * tau )));
end
%
function p = P2(om ,S,X,tau ,r,q,v0 ,theta ,rho ,kappa, sigma )
i=1i;
p = real ( exp (-i* log (X)*om) .* cfHeston (om ,S,tau ,r,q,v0 ,theta ,rho ,kappa, sigma ) ./ (i *om));
end
%
function cf = cfHeston (om ,S,tau ,r,q,v0 ,theta ,rho ,kappa, sigma )
d = sqrt (( rho * sigma * 1i*om - kappa) .^2 + sigma ^2 * (1i*om + om .^ 2));
g2 = (kappa - rho * sigma *1i*om - d) ./ (kappa - rho * sigma *1i*om + d);
cf1 = 1i*om .* ( log (S) + (r - q) * tau );
cf2 = theta * kappa / ( sigma ^2) * ((kappa - rho * sigma *1i*om - d) * tau - 2 * log ((1 - g2 .*exp (-d * tau )) ./ (1 - g2)));
cf3 = v0 / sigma ^2 * (kappa - rho * sigma *1i*om - d) .* (1 - exp (-d * tau )) ./ (1 - g2.* exp (-d * tau ));
cf = exp ( cf1 + cf2 + cf3 );
end

