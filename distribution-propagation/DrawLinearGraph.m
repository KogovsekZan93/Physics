function DrawLinearGraph(i,N,x,y,k,n,delx,dely,delk,deln)
%i je indeks figure(i), N je stevilo tock premici, k*x+n je 
%modelska funkcija za set podatkov y(x), dely in delx sta tako kot 
%y in x vektorja oblike [x1;x2;...]


figure(i);
hold on;
xcon=(linspace(min(x),max(x),N))';
ycon=xcon*k+n;
ytop=xcon*(k+delk)+n+deln;
ybot=xcon*(k-delk)+n-deln;
graphi=fill([xcon',fliplr(xcon')],[ybot',fliplr(ytop')],'b');
set(graphi,'facealpha',.5);
errorbar(x,y,dely,'ro');
herrorbar(x,y,delx,delx,'ro');
plot(xcon,ycon,'k-','LineWidth',1.5)

grid on;
set(gca,'fontsize',14)
hold off;

end

