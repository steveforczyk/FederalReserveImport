function DecodeSummaryStockData(stockline)
% The purpose of ths routine is to decode a single line of data in the text
% file to get a summary of the stock values
% Written By: Stephen Forczyk
% Created: Mar 20,2025
% Revised:-----

global PctHoldings InitialCost MktVal UnrealGainLoss EstAnnualIncome;
global CurrentYield;

[ipoints]=strfind(stockline,'.');
numpoints=length(ipoints);
ascii=double(stockline);
idelin=find(ascii==32);
numidelin=length(idelin);
ilim=ones(numpoints,2);
ifound=0;
% Find out many separators are discovered
for n=1:numidelin-1
    il1=idelin(1,n);
    il2=idelin(1,n+1);
    diff=il2-il1;
    if(diff>1)
        ifound=ifound+1;
    end
end
isearch=ones(ifound,2);
% save the separators to be searched
ifound=0;
for n=1:numidelin-1
    il1=idelin(1,n);
    il2=idelin(1,n+1);
    diff=il2-il1;
    if(diff>1)
        ifound=ifound+1;
        isearch(ifound,1)=il1+1;
        isearch(ifound,2)=il2-1;
    end
end
% Get the location of the last data item
lastblank=max(idelin);
endline=length(stockline);
isearch(numidelin,1)=lastblank+1;
isearch(numidelin,2)=endline-1;
% Now pull out the quantities one by one-there should be 6 items
% Start with the per cent of the holdings in stocks
is=isearch(1,1);
ie=isearch(1,2);
nowStr1=stockline(1,is:ie);
tf1=contains(nowStr1,'%');
if(tf1==1)
    nowStr2=erase(nowStr1,"%");
else
    nowStr2=nowStr1;
end
PctHoldings=str2double(nowStr2);
% continue with the initial cost of the stocks
is=isearch(2,1);
ie=isearch(2,2);
nowStr1=stockline(1,is:ie);
tf1=contains(nowStr1,'$');
if(tf1==1)
    nowStr2=erase(nowStr1,"$");
else
    nowStr2=nowStr1;
end
InitialCost=str2double(nowStr2);
% continue with the Market Value of these stocks
is=isearch(3,1);
ie=isearch(3,2);
nowStr1=stockline(1,is:ie);
tf1=contains(nowStr1,'$');
if(tf1==1)
    nowStr2=erase(nowStr1,"$");
else
    nowStr2=nowStr1;
end
MktVal=str2double(nowStr2);
% continue with the Unrealized Gain or Loss
is=isearch(4,1);
ie=isearch(4,2);
nowStr1=stockline(1,is:ie);
tf1=contains(nowStr1,'$');
if(tf1>0)
    nowStr2=erase(nowStr1,"$");
end
ichs=1;
tf2=contains(nowStr1,'(');
if(tf2>0)
    ichs=-1;
    nowStr2=erase(nowStr1,"(");
end
tf3=contains(nowStr1,')');
if(tf3>0)
    ichs=-1;
    nowStr2=erase(nowStr1,")");
end
UnrealGainLoss=ichs*str2double(nowStr2);
% continue with the Estimated Annual Income
EstAnnualIncome=0;
is=isearch(5,1);
ie=isearch(5,2);
nowStr1=stockline(1,is:ie);
tf1=contains(nowStr1,'$');
if(tf1>0)
    nowStr2=erase(nowStr1,"$");
end
try
    EstAnnualIncome=str2double(nowStr2);
catch
    EstAnnualIncome=0;
end

% Finish with Current Yeield in %
CurrentYield=0;
is=isearch(6,1);
ie=isearch(6,2);
nowStr1=stockline(1,is:ie);
tf1=contains(nowStr1,'%');
if(tf1>0)
    nowStr2=erase(nowStr1,"%");
else
    nowStr2=nowStr1;
end
try
    CurrentYield=str2double(nowStr2);
catch
    CurrentYield=0;
end
ab=1;
end