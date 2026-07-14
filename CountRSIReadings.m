function [numlow,numneutral,numhigh] = CountRSIReadingsRev2(RSIWhole)
% This function will take a RSI Table and count the number of readings that
% were oversold,neutral or overbought modified from original version to
% use OOP
% Written By: Stephen Forczyk
% Created: May 23,2025
% Revised: 
global RSIStats RSILowLimit RSIHighLimit istocknum;
global fid;

numlow=0;
numneutral=0;
numhigh=0.0;

numvals=length(RSIWhole);
for ii=1:numvals
    nowval=RSIWhole(ii,1);
    a1=isnan(RSIWhole(ii,1));
    if(a1==0)% It is not a NaN so use it
        if(nowval<RSILowLimit)
            numlow=numlow+1;
        elseif((nowval>=RSILowLimit) && (nowval<RSIHighLimit))
            numneutral=numneutral+1;
        elseif(nowval>RSIHighLimit)
            numhigh=numhigh+1;
        end
    end
end %%
RSIStats(istocknum,5)=numlow;
RSIStats(istocknum,6)=numneutral;
RSIStats(istocknum,7)=numhigh;
end
