function CalculateRSIStatsRev1(RSIWhole)
% Calculate the stats for selected RSI items
% This is similar to the original version but the Rev1 version
% does not send the output to the RSIStats Array and is
% used to just provide the mean value of a monthly array for a
% single stoc
% Written By: Stephen Forczyk
% Created: Feb 10,2025
% Revised:
% to reduce code length
global RSIStats istocknum meanRSI;
global fid;
meanRSI=0;
minRSI=0;
maxRSI=0;
stdevRSI=0;
meanRSI=mean(RSIWhole,'omitnan');
minRSI=min(RSIWhole,[],"all",'omitnan');
maxRSI=max(RSIWhole,[],"all",'omitnan');
stdevRSI=std(RSIWhole,'omitmissing');
% RSIStats(istocknum,1)=meanRSI;
% RSIStats(istocknum,2)=minRSI;
% RSIStats(istocknum,3)=maxRSI;
% RSIStats(istocknum,4)=stdevRSI;

end