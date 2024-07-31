function [xc, yc] = redistributePdf(x, y, bin)
% x frequency; y energy at x; bin, [xs, xe], n+1 bounds
% xc, center of bin; yc accumulated energy in one bin
    xc = zeros(length(bin)-1, 1);
    yc = xc;
    for ii=1:length(xc)
        xc(ii) = 0.5 * (bin(ii) + bin(ii+1));
    end
    for ii=1:length(x)
        ind = findind(x(ii), bin);
        if ind>=0
            yc(ind) = yc(ind) + y(ii);
        end
    end
end

function ind = findind(x, bin)
    len = length(bin);
    if x<bin(1) || x>bin(len)
        ind = -1;
        return;
    end
    if x == bin(len)
        ind = len - 1;
        return;
    end
    for ii=1:length(bin)-1
        if bin(ii) <= x && x<bin(ii+1)
            ind = ii;
            break;
        end
    end
end