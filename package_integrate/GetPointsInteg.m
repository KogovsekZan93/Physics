function [limit_points, zone_points] = GetPointsInteg(x,n)
% GetPointsInteg vrne tocke limit_points, za katere velja, da je za poljuben i 
% poljubni vrednosti m med vrednostma limit_points(i) in limit_points(i+1) 
% najblizjih istih n tock x(j). Njihovi indeksi j so dani v zone_points(1:n,i).
% Vrednosti x(j) morajo biti urejene po vrsti.
% 
% Za vrednosti, ki se nahajajo pod limit_points(1) (== min(x)), velja, da so 
% indeksi najblizjih n tock v zone_points(1:n,1) oz. gre za indekse prvih n tock 
% x(j) (zone_points(1:n,1) = [1, 2, ... , n-1, n]).
% Za vrednosti, ki se nahajajo nad limit_points(len-n+1) (< max(x)), velja, 
% da so indeksi najblizjih n tock v zone_points(n-len+1,1:n) oz. gre za indekse
% zadnjih n tock x(j) (zone_points(n-len+1,1:n) = [len-n+1, len-n+2, ..., len-1, len]).
len=length(x);
limit_points=zeros(len-n+1,1);
limit_points(1,1)=x(1);
limit_points(2:len-n+1,1)=(x(1:len-n)+x(n+1:len))/2;
zone_points=zeros(len-n+1,n);
for i=1:len-n+1
    zone_points(i,1:n)=(1:n)+i-1;
end


end

