function frepresent = ComposedVariable(VARIABLES,f,n)
%VARIABLES je cell data v obliki VARIABLES={{[avgx;delx],ux}, 
%{[avgy;dely],uy}, [z1;z2;z3;...], {[avgh;delh],uh}, ...}
%Ce je element VARIABLES vektor, se po njem nakljucno vzorci.
%Ce je element VARIABLES celica, je ta oblike {[avgx,delx],ux} in se 
%vzorci bodisi:

%z enakomerno porazdelitvijo, ce ux=1, na intervalu 
%[avgx-delx,avgx+delx]

%z normalno porazdelitvijo, ce ux=2, s povprecjem avgx in 
% standardno deviacijo delx

%z enakomerno porazdelitvijo, ce ux=3 in standardno deviacijo delx


%f je handle funkcije, ki sprejme vektor [x;y;z;h;...] in vrne 
%vektor fvec=[f1;f2;f3;...;repf1;repf2;repf3;...;validity].
%f1, f2, f3, ... so vrnjene vrednosti funkcije.
%Ce repfi=1, bodo vrednosti funkcije fi prikazane na histogramu.
%Parameter validity pove, ali je vrednost celotnega nabora 
%funkcijskih spremenljivk validen (v tem primeru je njegova 
%vrednost enaka validity=1), denimo, ce logaritmiramo negativno 
%stevilo, lahko rezultat oznacimo za invaliden in ga s tem 
%odstranimo iz vzorca.

%frepresnet je sestavljen kot
%[  avgf1,    stdf1;
%   avgf2,    stdf2;
%   avgf3,    stdf3;
%   ...       ...
%                   ]

values=GetRndValues(VARIABLES,n);

l=(length(f([values(:,1)]))-1)/2;

F=zeros(n,l);

h=1;
r=n;
while n>=h

    for i=1:r
        ff=f(values(:,i));
        if ff(end)~=0
            F(h,:)=(ff(1:l))';
            h=h+1;
        end
    end
    
    r=n-h+1;
    if r~=0
        values=GetRndValues(VARIABLES,r);
    end
    
end
    

frepresent=[l,2];

for j=1:l
    frepresent(j,:)=[mean(F(:,j)),std(F(:,j))];
end


for j=1:l
    if ff(l+j)==1
        figure(j);
        clf;
        histogram(F(:,j),'Normalization','pdf');
        hold on;
        
        mu = frepresent(j,1);
        sigma = frepresent(j,2);
        N=power(10,3);
        x=linspace(mu-3*sigma,mu+3*sigma,N);
        plot(x,normpdf(x,mu,sigma),'r');
        hold off;
        grid on;
        xlim([mu-3*sigma mu+3*sigma]);
    end
end

end

