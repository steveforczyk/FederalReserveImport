function [rho,significance,numover] = CalculateCorrelation(Table1,Table2,ikind,minPts)
% This fuction will calculate the correlation between to vectors taken
% from two different tables.
% Before a correlation can be calculated the function first must calculate
% if sufficient points taken at the same time can be found for the two
% vectors
%
% Written By:Stephen Forczyk
% Created: Jun 11,2026
% Revised:---
numoverlap=0;
correlation=-1;
significance=-1;
% First calculate dates of table 1 and 2 and then count overlap values
numTable1=height(Table1);
numTable2=height(Table2);
if(numTable1>=numTable2)
    Table3=Table1;
    Table4=Table2;
    numTable3=numTable1;
    numTable4=numTable2;
else
    Table3=Table2;
    Table4=Table1;
    numTable3=numTable2;
    numTable4=numTable1;
end
Table3Start=min(Table3.DateNumbers);
Table3End=max(Table3.DateNumbers);
Table4Start=min(Table4.DateNumbers);
Table4End=max(Table4.DateNumbers);

ab=1;

intersect=0;
% Now calculate the number of overlapping points
if((Table3Start<=Table4Start) && (Table3End>=Table4Start+minPts))
    intersect=1;
end
ab=1;
% If an intersection is found calculate which points need to be pulled out
% of the tables in order to match
imatch3Start=0;
imatch3End=0;
jmatch4Start=0;
jmatch4End=0;
imatch=zeros(numTable4,1);
jmatch=zeros(numTable4,1);
nmatch=0;
if(intersect==1)
% Find the start of the matching segments
    for i=1:numTable3
        for j=1:numTable4
            dnum3=Table3.DateNumbers(i);
            dnum4=Table4.DateNumbers(j);
            if(dnum3==dnum4)
                nmatch=nmatch+1;
                imatch(nmatch,1)=i;
                jmatch(nmatch,1)=j;
            end
        end
    end
end
ab=2;
if(nmatch>=minPts)
% If the end of the end of the shorter Table runs off the end of the longer
% table clip off the ends
    if(nmatch<numTable4)
        imatchfinal=zeros(nmatch,1);
        jmatchfinal=zeros(nmatch,1);
        for i=1:nmatch
            imatchfinal(i,1)=imatch(i,1);
            jmatchfinal(i,1)=jmatch(i,1);
        end
    else
        imatchfinal=imatch;
        jmatchfinal=jmatch;
    end
    ab=3;
    Vector3=zeros(nmatch,1);
    Vector4=zeros(nmatch,1);
    if(ikind==1)
        for n=1:nmatch
            Vector3(n,1)=Table3.Index(n);
            Vector4(n,1)=Table4.Index(n);
        end
    elseif(ikind==2)
        for n=1:nmatch
            Vector3(n,1)=Table3.Index(n);
            Vector4(n,1)=Table4.Price(n);
        end
    elseif(ikind==3)
        for n=1:nmatch
            Vector3(n,1)=Table3.Index(n);
            Vector4(n,1)=Table4.Prices(n);
        end
    end
    numover=nmatch;
% Calculate the correlation
%    rho = corr(Vector3,Vector4);
    rho = corr(Vector3,Vector4,'Rows','pairwise');
end
end