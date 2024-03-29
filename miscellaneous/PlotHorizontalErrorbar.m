function hh = PlotHorizontalErrorbar...
    (x_Data, y_Data, l_Error, u_Error, symbol)
%GETHORIZONTALERRORBAR Horizontal Error bar plot. 
%   GETHORIZONTALERRORBAR(X,Y,L,R) plots the graph of 
%   vector X vs. vector Y with horizontal error bars specified by 
%   the vectors L and R. L and R contain the left and right error 
%   ranges for each point in X. Each error bar is L(i) + R(i) long 
%   and is drawn a distance of L(i) to the right and R(i) to the right 
%   the points in (X,Y). The vectors X,Y,L and R must all be the 
%   same length. If X,Y,L and R are matrices then each column 
%   produces a separate line. 
%
%   GETHORIZONTALERRORBAR(X,Y,E) or 
%   GETHORIZONTALERRORBAR(Y,E) plots X with error 
%   bars [X-E X+E]. 
%   GETHORIZONTALERRORBAR(...,'LineSpec') uses the 
%   color and linestyle specified by the string 'LineSpec'. See 
%   PLOT for possibilities. 
%
%   H = GETHORIZONTALERRORBAR(...) returns a vector of 
%   line handles.
%
%   Example: 
%      x = 1:10;
%      y = sin(x);
%      e = std(y)*ones(size(x));
%      GetHorizontalErrorbar(x,y,e)
%   draws symmetric horizontal error bars of unit standard 
%   deviation. 
%
%   This code is based on ERRORBAR provided in MATLAB. 
%
%   See also ERRORBAR 

%   Jos van der Geest
%   email: jos@jasen.nl
%
%   File history: 
%   August 2006 (Jos): I have taken back ownership. I like to 
%   thank Greg Aloe from The MathWorks who originally 
%   introduced this piece of code to the Matlab File Exchange. 
%   September 2003 (Greg Aloe): This code was originally 
%   provided by Jos from the newsgroup comp.soft-sys.matlab: 
%   http://newsreader.mathworks.com/...
%   WebX?50@118.fdnxaJz9btF^1@.eea3ff9 
%   After unsuccessfully attempting to contact the orignal author, 
%   I decided to take ownership so that others could benefit from 
%   finding it on the MATLAB Central File Exchange. 

if min(size(x_Data))==1
    npt = length(x_Data);
    x_Data = x_Data(:);
    y_Data = y_Data(:);
    if nargin > 2
        if ~isstr(l_Error)
            l_Error = l_Error(:);
        end
        if nargin > 3
            if ~isstr(u_Error)
                u_Error = u_Error(:);
            end
        end
    end
else
    [npt, ~] = size(x_Data);
end

if nargin == 3
    if ~isstr(l_Error)
        u_Error = l_Error;
        symbol = '-';
    else
        symbol = l_Error;
        l_Error = y_Data;
        u_Error = y_Data;
        y_Data = x_Data;
        [~,n] = size(y_Data);
        x_Data(:) = (1:npt)'*ones(1,n);
    end
end

if nargin == 4
    if isstr(u_Error)
        symbol = u_Error;
        u_Error = l_Error;
    else
        symbol = '-';
    end
end

if nargin == 2
    l_Error = y_Data;
    u_Error = y_Data;
    y_Data = x_Data;
    [~,n] = size(y_Data);
    x_Data(:) = (1:npt)'*ones(1,n);
    symbol = '-';
end

u_Error = abs(u_Error);
l_Error = abs(l_Error);

if isstr(x_Data) || isstr(y_Data) || isstr(u_Error) || isstr(l_Error)
    error('Arguments must be numeric.')
end

if ~isequal(size(x_Data),size(y_Data)) || ...
        ~isequal(size(x_Data),size(l_Error)) || ...
        ~isequal(size(x_Data),size(u_Error))
    error('The sizes of X, Y, L and U must be the same.');
end

tee = (max(y_Data(:))-min(y_Data(:)))/100; % make tee .02 
                                                                       % x-distance for error 
                                                                       % bars
% changed from errorbar.m
xl = x_Data - l_Error;
xr = x_Data + u_Error;
ytop = y_Data + tee;
ybot = y_Data - tee;
n = size(y_Data,2);
% end change

% Plot graph and bars
hold_state = ishold;
cax = newplot;
next = lower(get(cax,'NextPlot'));

% build up nan-separated vector for bars
% changed from errorbar.m
xb = zeros(npt*9,n);
xb(1:9:end,:) = xl;
xb(2:9:end,:) = xl;
xb(3:9:end,:) = NaN;
xb(4:9:end,:) = xl;
xb(5:9:end,:) = xr;
xb(6:9:end,:) = NaN;
xb(7:9:end,:) = xr;
xb(8:9:end,:) = xr;
xb(9:9:end,:) = NaN;

yb = zeros(npt*9,n);
yb(1:9:end,:) = ytop;
yb(2:9:end,:) = ybot;
yb(3:9:end,:) = NaN;
yb(4:9:end,:) = y_Data;
yb(5:9:end,:) = y_Data;
yb(6:9:end,:) = NaN;
yb(7:9:end,:) = ytop;
yb(8:9:end,:) = ybot;
yb(9:9:end,:) = NaN;
% end change

[ls,col,mark,msg] = colstyle(symbol); 
if ~isempty(msg), error(msg); end
symbol = [ls mark col]; % Use marker only on data part
esymbol = ['-' col]; % Make sure bars are solid

h = plot(xb,yb,esymbol); hold on
h = [h;plot(x_Data,y_Data,symbol)];

if ~hold_state, hold off; end

if nargout>0, hh = h; end

end