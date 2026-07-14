function [RMonth] = CalculateMonthlyRSIStats(RMonth,StartIndex,StopIndex,RSIWhole)
% This function will calculate the monthly RSI Stats for a single stock
% Written By: Stephen Forczyk
% Created: Mar 23,2025
% Revised
global meanRSI;
% Now calculate the RSI by month for this stock
for ii=1:12
    s1=StartIndex(ii,1);
    s2=StopIndex(ii,1);
    numvals2=s2-s1+1;
    if(ii==1)
        RSIMON=zeros(numvals2,12);
        RMonth=zeros(12,1);
    end
    if(numvals2>15)
        RSIMON(1:numvals2,ii)=RSIWhole(s1:s1+numvals2-1,1);
        CalculateRSIStatsRev1(RSIMON(:,ii));
        RMonth(ii,1)=meanRSI;
    end
end

end