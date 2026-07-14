function [outTableTT] = CalculateEquityTableDateNumVer2(WorkTable,Meandays50,Meandays200,numprices)
% This routine is designed to  calculate the datenum value for each entry
% in the original table.Note the datenum function is being phased out in
% Matlab but still works.This may have to be changed later
% Written By: Stephen Forczyk
% Created: Apr 10,2025
% Revised:---
% 
nowDate=zeros(numprices,1);
for n=1:numprices
    temp=char(WorkTable.Date(n));
    DateString = temp;
    formatIn = 'dd-mmm-yyyy';
    d1=datenum(DateString,formatIn);
    nowDate(n,1)=d1;
    %nowDate(n,1)=datenum(temp);
end
T2 = addvars(WorkTable,Meandays50,Meandays200,nowDate);
outTableTT = table2timetable(T2,'RowTimes','Date');
end