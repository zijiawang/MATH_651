function call = calljumpscf (S,X,tau ,r,q,v0 ,vT ,rho ,k,sigma , lambda ,muJ ,vJ)
% calljumpscf Pricing function for European calls
% callprice = calljumpscf (S,X,tau ,r,q,v0 ,vT ,rho ,k, sigma , lambda ,muJ ,vJ)
% output are option prices under different strikes, start from nonzero one
% 
%Example: CLJ16 options pricing
%for CLM16 options, just change the initial values
% ---
S = 37.9; %S_0
tau = 0.03571; %maturity
r = 0.0065; %riskfree rate
q = 0; %dividend yield
v0 = 0.1; %initial variance
vT =0.1790808; %long run variance ( theta in jumps model )
rho =-0.7813498;%correlation 
k =0.6516818; %speed of mean reversion ( kappa in jumps model )
sigma =0.1506341; %volatility of volatility (sigma_V in jumps model)
lambda =0.05702518; %intensity of jumps (lambda in jumps model);
muJ =-0.0000884363; %mean of jumps ;
vJ =0.118745; %variance of jumps ;

%strike prices are 25.5,26.5, 27.5...54.5
for i=25:54
    X(i)=i+0.5; %iF the srike price is integer, then let X(i)=i
vP1 = 0.5 + 1/ pi * quadl (@P1 ,0 ,200 ,[] ,[] ,S,X(i),tau ,r,q,v0 ,vT ,rho ,k,sigma , lambda ,muJ,vJ);
vP2 = 0.5 + 1/ pi * quadl (@P2 ,0 ,200 ,[] ,[] ,S,X(i),tau ,r,q,v0 ,vT ,rho ,k,sigma , lambda ,muJ,vJ);
call(i) = exp (-q * tau ) * S * vP1 - exp (-r * tau ) * X(i) * vP2 ;
end
end


%
function p = P1(om ,S,X,tau ,r,q,v0 ,vT ,rho ,k,sigma , lambda ,muJ ,vJ)
i=1i;
p = real ( exp (-i* log (X)*om) .* cfBates (om -i,S,tau ,r,q,v0 ,vT ,rho ,k,sigma , lambda ,muJ,vJ) ./ (i * om * S * exp ((r-q) * tau )));
end
%
function p = P2(om ,S,X,tau ,r,q,v0 ,vT ,rho ,k,sigma , lambda ,muJ ,vJ)
i=1i;
p = real ( exp (-i* log (X)*om) .* cfBates (om ,S,tau ,r,q,v0 ,vT ,rho ,k,sigma , lambda ,muJ,vJ) ./ (i * om));
end
%
function cf = cfBates (om ,S,tau ,r,q,v0 ,vT ,rho ,k,sigma , lambda ,muJ ,vJ)
d = sqrt (( rho * sigma * 1i*om - k) .^2 + sigma ^2 * (1i*om + om .^ 2));
%
g2 = (k - rho * sigma *1i*om - d) ./ (k - rho * sigma *1i*om + d);
%
cf1 = 1i*om .* ( log (S) + (r - q) * tau );
cf2 = vT * k / ( sigma ^2) * ((k - rho * sigma *1i*om - d) * tau - 2 * log ((1 - g2 .*exp (-d * tau )) ./ (1 - g2)));
cf3 = v0 / sigma ^2 * (k - rho * sigma *1i*om - d) .* (1 - exp (-d * tau )) ./ (1 - g2.* exp (-d * tau ));
% jump
cf4 = -lambda * muJ *1i* tau *om + lambda * tau *( (1+ muJ ) .^(1i*om) .* exp ( vJ *(1i*om /2).* (1i*om -1) ) -1 );
cf = exp ( cf1 + cf2 + cf3 + cf4 );
end


