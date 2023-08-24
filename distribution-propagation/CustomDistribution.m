function DitributionWeighedValues = CustomDistribution...
(handle_DitributionFunction, IntervalLimits, ...
N_ValuesInInterval, N_MaxRep)
%CUSTOMDISTRIBUTION vrne vektor vrednosti D = [x1;...;x1;x2;...;xnn;...;xnn],
%kjer je stevilo ponovitev vsake vrednosti xi sorazmerno z gostoto verjetnostne 
%porazdelitve f za vzorcenje vrednosti xi.


%f je gostota verjetnoste porazdelitve za vrednosti x in je handle funkcije, ki 
%sprejme vrednost x (skalar) in vrne skalar, katerega vrednost je sorazmerna 
%gostoti verjetnostne porazdelitve za vzorèenje vrednosti x. 

%nn je stevilo tock, v katerih bo izracunana gosta verjetnostne porazdelitve f.

%Nmax je stevilo ponovitev vrednosti xi v D z najvecjo verjetnostno gostoto. Iz 
%tega torej sledi length(D)<=N_values * Nmax.

%interval je dvokomponentni vektor interval=[a;b] z zgornjo b in spodnjo a mejo,
%v kateri bo gostota verjetnostne porazdelitve f izracunana. f mora biti v tem 
%intervalu povsod koncna in nenegativna. 


%Vektor D je lahko vstavljen direktno v spremenljivko VARIABLES kot na primer
%VARIABLES = {{[avgx;delx],ux}, {[avgy;dely],uy}, D, {[avgh;delh],uh}, ...}, kar
%pomeni, da se bo pri uporabi funckije ComposedVariable spremenljivka x 
%vzorcila po verjetnostni gostoti f.


x = (linspace...
    (IntervalLimits(1), IntervalLimits(2), N_ValuesInInterval))';

y = zeros(N_values, 1);
for i=1 : N_values
    y(i) = handle_DitributionFunction(x(i));
end
y = y * N_MaxRep / max(y);
y = round(y);

length_DitributionWeighedValues = sum(y);
DitributionWeighedValues = ...
    zeros(length_DitributionWeighedValues, 1);

RunningIndex = 1;
for i=1 : N_ValuesInInterval
    DitributionWeighedValues...
        (RunningIndex : RunningIndex + y(i) - 1) = x(i);
    RunningIndex = RunningIndex + y(i);
end

end