function [FinalItemTT,icase] = OverlapTimeLinesRev1(BaseTT,ItemTT)
% The purpose of this function to is take a base time table and find the
% overlap points (if any) to create as output a Final Item Array that finds
% the
% value of the corresponding timeperiod of a matching timepoint in the
% BaseTT array.
% If not enough matching points are found a Dummy FinalItemTT will be
% created
% Written By:Stephen Forczyk
% Created: Jul 6,2026
% Revised: -------
%   Detailed explanation goes here
FinalItemTT=BaseTT;
icase=0;
ht1=height(BaseTT);
ht2=height(ItemTT);
%FinalItemTT=ItemTT;
% start by retriving this data as an array
darray1=BaseTT.Variables;
darray2=ItemTT.Variables;
% Find the point at the start of the overlapping data
istart=0;
iend=0;
% Find the start and end datetimes for each TimeTable
X1=darray1(:,2);
X2=darray2(:,2);
X23=darray2(:,3);
minX1=min(X1);
maxX1=max(X1);
minX2=min(X2);
maxX2=max(X2);
RevFlag=zeros(ht1,1);
DateAbs=zeros(ht1,1);
DateBase=zeros(ht1,1);
DateItem=zeros(ht2,1);
Prob=zeros(ht1,1);
icase=5;
if((minX1<=minX2) && (maxX1>=maxX2)) % Complete overlap
    icase=1;
%    disp('this is case 1')
    % istart=find(X2==minX2);
    % iend=find(X2==maxX2);
    istart=find(X1==minX2);
    iend=ht1;
    iend=ht2;
    if(iend>=ht1)
        iend=ht1;
    end
    % if(iend>=ht2)
    %     iend=ht2;
    % end

     ik=0;
     ik=ht1-ht2;
     ip=0;
     istart=1;
     iend=ht2;
     for k=istart:iend
        ik=ik+1;
        if(ik<ht1)
            nowval=table2array(ItemTT(k,3));
            nowprob=table2array(ItemTT(k,1));
            RevFlag(ik,1)=nowval;
            DateItem(ik,1)=table2array(ItemTT(k,2));
            nowdateitem=DateItem(k,1);
            Prob(ik,1)=nowprob;
            if(nowval==0)
                dispstr=strcat('ik=',num2str(ik,4),'-k=',num2str(k,4),'-nowProb=',num2str(nowprob));
            elseif(nowval>0)
                ip=ip+1;
                dispstr=strcat('ik=',num2str(ik,4),'-k=',num2str(k,4),'-nowProb=',num2str(nowprob),'-nowval=',num2str(nowval),'-ip=',num2str(ip));
            end
            % disp(dispstr)
            % dispstr2=strcat('Match Date-',num2str(nowdateitem,8));
            % disp(dispstr2)
            ab=2;
        end
     end
    % dispstr=strcat('Number of High points Found-',num2str(ip,4));
    % disp(dispstr)
    FinalItemTT = addvars(FinalItemTT,RevFlag);
    ab=1;% Check This
elseif((minX1>minX2) && (maxX1>=maxX2))% overlap on hi side
    icase=2;
%    disp('This is case 2')
    istart=find(X2==minX1);
    iend=ht2;
    ik=0;
     for k=istart:iend
        ik=ik+1;
        if(ik<=ht1)
            RevFlag(ik,1)=X23(k,1);
            DateAbs(ik,1)=X2(k,1);
        end
     end
    ab=2;
    FinalItemTT = addvars(FinalItemTT,RevFlag);
elseif((minX1<=minX2) && (maxX1<maxX2))% overlap on low side
    icase=3;
%    disp('This is case 3');
    ik=0;
    ip=0;
    istart=find(X1==minX2);
    iend=find(X2==maxX1);
    if(iend>=ht1)
        iend=ht1;
    end
 for k=istart:iend
    ik=ik+1;
    nowval=table2array(ItemTT(ik,3));
    nowprob=table2array(ItemTT(ik,1));
    RevFlag(k,1)=nowval;
    DateAbs(k,1)=X2(k,1);
    Prob(k,1)=nowprob;
    if(nowval==0)
        dispstr=strcat('ik=',num2str(ik,4),'-k=',num2str(k,4),'-nowProb=',num2str(nowprob));
    elseif(nowval>0)
        ip=ip+1;
        dispstr=strcat('ik=',num2str(ik,4),'-k=',num2str(k,4),'-nowProb=',num2str(nowprob),'-nowval=',num2str(nowval),'-ip=',num2str(ip));
        ab=1;
    end
   %    disp(dispstr)
    ab=2;
 end
    FinalItemTT = addvars(FinalItemTT,RevFlag);
    ab=3;
elseif((minX1>minX2) && (maxX1<maxX2))% missing points on low and high side
%    disp('this is case 4')
    icase=4;
    ik=0;
    ip=0;
    istart=find(minX1==X2);
    iend=find(X2==maxX1);
    if(iend>=ht2)% Changed this
        iend=ht2;
    end
    for k=istart:iend
        ik=ik+1;
        if(ik<=ht1)
            nowval=table2array(ItemTT(k,3));
            nowprob=table2array(ItemTT(k,1));
            RevFlag(ik,1)=nowval;
            DateAbs(ik,1)=X2(k,1);
            Prob(ik,1)=nowprob;
            if(nowval==0)
                dispstr=strcat('ik=',num2str(ik,4),'-k=',num2str(k,4),'-nowProb=',num2str(nowprob));
            elseif(nowval>0)
                ip=ip+1;
                dispstr=strcat('ik=',num2str(ik,4),'-k=',num2str(k,4),'-nowProb=',num2str(nowprob),'-nowval=',num2str(nowval),'-ip=',num2str(ip));
            ab=1;
            end
        end
   end
    ab=1;
    FinalItemTT = addvars(FinalItemTT,RevFlag);
end
ab=1;
end