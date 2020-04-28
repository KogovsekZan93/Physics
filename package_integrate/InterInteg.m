function Integ= InterInteg(x,y,xmin,xmax,n,figr)
% InterInteg vrne integral funkcije med y(i) = y(x(i)) med mejama xmin 
% in xmax, pri psevdoredu natancnosti n. n mora biti naravno stevilo. 
% figr je indeks slike figure(figr), na kateri je vizualna prezentacija 
% integriranja.
% 
% X obmocje se razdeli na intervale, znotraj katerih je vsem vrednostim 
% najblizjih istih n tock x(j). Znotraj teh intervalov se formulira 
% interpolacijski polinom skozi ustreznih n tock. V vsakem intervalu se 
% nato integrira ustrezni del polinoma (denimo na celotnem intervalu, 
% ce se nahaja med xmin in xmax ), vsota integralov pa da Integ.

[x,I]=sort(x);
y=y(I);

[limit_points, zone_points]=GetPointsInteg(x,n);

len_points=length(limit_points);
zonemin=len_points;
zonemax=len_points;

for i=1:len_points
    if limit_points(i)>xmin
        zonemin=max(i-1,1);
        break;
    end
end

for i=1:len_points
    if limit_points(i)>xmax
        zonemax=max(i-1,1);
        break;
    end
end
% Ce se zakomentira naslednjo vrstico, se ne bo narisal graf.
DrawInteg(x,y,limit_points, zone_points,xmin,xmax,zonemin,zonemax,figr);

if zonemin==zonemax
    Integ=SmallInteg(x(zone_points(zonemin,:)),y(zone_points(zonemin,:)),xmin,xmax);
else
    Integ=SmallInteg(x(zone_points(zonemin,:)),y(zone_points(zonemin,:)),xmin,limit_points(zonemin+1))+SmallInteg(x(zone_points(zonemax,:)),y(zone_points(zonemax,:)),limit_points(zonemax),xmax);
    if zonemax-1~=zonemin
        for i=1:zonemax-zonemin-1
            Integ=Integ+SmallInteg(x(zone_points(zonemax-i,:)),y(zone_points(zonemax-i,:)),limit_points(zonemax-i),limit_points(zonemax-i+1));
        end
    end
end
    
end



