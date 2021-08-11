function [acme] = findpeaks(y, thresh, mode)
%trim vortex core data
% first find the peak in height direction
% loc is in wind frame, first valley starting from zmax to zmin
% zmin is an update of zmin (last valley), should decrease monotonically
acme = findacme(y);
thresh = min(thresh, autothresh(acme));
while 1
    [flag, acme] = trimacme(acme, thresh);
    if flag==0
        break;
    end
end
if nargin>=3 && mode>0
    figure;
    plot(y);
    hold on
    plot(acme(:,1), acme(:,2),'or');
end
end

function acme = findacme(h)
nsize = length(h);
flag = 0;
acme(1,1)=1;
acme(1,2)=h(1);
acount = 2;
for ii=2:1:nsize-1
    if h(ii) <= h(ii-1) && h(ii)<=h(ii+1) && (h(ii)<h(ii-1) || h(ii)<h(ii+1));
        if flag==-1;
            acme(acount-1, 1) = round((acme(acount-1, 1) + ii)/2);
        else
            acme(acount, 1) = ii;
            acme(acount, 2) = h(ii);
            acount = acount + 1;
        end
        flag = -1.;
    end
     if h(ii) >= h(ii-1) && h(ii)>=h(ii+1) && (h(ii)>h(ii-1) || h(ii)>h(ii+1));
        if flag==1;
            acme(acount-1, 1) = round((acme(acount-1, 1) + ii)/2);
        else
            acme(acount, 1) = ii;
            acme(acount, 2) = h(ii);
            acount = acount + 1;
        end
        flag = 1.;
    end
end
if nsize>1;
    acme(acount, 1) = nsize;
    acme(acount, 2) = h(nsize);
end
end

function thresh = autothresh(acme)
len = length(acme(:,2));
thresh = 0.8*( max( abs( acme(2:len,2)-acme(1:len-1,2) ) ) );
end

function [flag, acme2] = trimacme(acme, thresh)
nsize = length(acme);
flag = 0;
for ii=1:1:nsize-1
    if abs(acme(ii+1,2) - acme(ii,2)) >= thresh;
        sign = 1;
        if acme(ii+1,2) < acme(ii, 2);
            sign = -1;
        end
        if ii<=nsize-3 && abs(acme(ii+1,2)-acme(ii+2,2))<thresh;
            if sign*acme(ii+3,2)>sign*acme(ii+1,2);
                acme(ii+1,1) = -1;
                acme(ii+2,1 ) =-1;
            else
                acme(ii+2,1) = -1;
                acme(ii+3,1 ) =-1;
            end
            flag = 1;
            break;
        end
        if ii >=3 && abs(acme(ii,2)-acme(ii-1,2))<thresh;
            if sign*acme(ii-2,2)<sign*acme(ii,2);
                acme(ii,1) = -1;
                acme(ii-1,1 ) =-1;
            else
                acme(ii-1,1) = -1;
                acme(ii-2,1 ) =-1;
            end
            flag = 1;
            break;
        end
         if ii==nsize-2 && abs(acme(ii+1,2)-acme(ii+2,2))<thresh;
            acme(ii+2,1 ) =-1;
            flag = 1;
            break;
         end
        if ii==2 && abs(acme(ii,2)-acme(ii-1,2)) < thresh;
            acme(ii-1, 1) = -1;
            flag = 1;
            break
        end
    end
end
if flag==1
    count = 1;
    for ii=1:1:nsize
        if acme(ii,1)>0;
            acme2(count, :) = acme(ii, :);
            count = count  + 1;
        end
    end
else
    acme2 = acme;
end
end