function [AnnualRateOfReturn,maxiter] = CalculateCompoundInterestRate(PV,FV,NumYears,tol)
% This function with the annulaized Return from the PV or open price to
% the closing FV price. The annualized compound interest rate wil be called
% The annualized Rate of Return
%   Detailed explanation goes here
% Written By: Stephen Forczyk
% Created: June 10,2025
% Revised: ------
AnnualRateOfReturn = 0;
maxiter = 1;

% PV=62;
% FV=65.26;
% PV=65.26;
% FV=62;
% PV=.265;
% FV=11.52;
N=10;
NumInterest=10*NumYears;
TestValues=zeros(NumInterest,9);
guessrate=(FV-PV)/(20*PV);
guessinc=guessrate/4;
mindiff=1E10;
bestfit=0;
isign=1;
FV1=FV;
FV2=FV;
iskip=0;
i=0;
iconsec=0;
igo=1;
    while igo>0
        i=i+1;
        PVNow=PV;
        IRateInc=guessinc;%
        if((i>1) && (iskip==0))
            IRateNow=guessrate+ guessinc*isign;%
        elseif((i>1) && (iskip==1))
            IRateNow=IRateNow;
        else
            IRateNow=guessrate;
        end
        FVNow=0;
        for j=1:N
            FVNow=PVNow+IRateNow*PVNow;
            PVNow=FVNow;
        end
        TestValues(i,1)=IRateNow;
        TestValues(i,2)=FVNow;
        if(i==1)
            difflast=1E10;
        else
            difflast=TestValues(i-1,3);
        end
        diffnow=FVNow-FV;
        TestValues(i,3)=diffnow; 
        if(abs(diffnow)<abs(mindiff))% check to see if this reduced the error
            mindiff=diffnow;
            bestfit=i;
            guessrate=IRateNow;
            iskip=0;
        end
    % If the two recent steps have a sign change in the error
    % flip the direction indicator isign
        if(i>1)
            a1=sign(difflast);
            a2=sign(diffnow);
            if(abs(diffnow) <abs(difflast))
                    iconsec=0;
            else
                    iconsec=iconsec+1;
            end
            if(a1 ~= a2)
                isign=-isign;
                guessinc=-guessinc/4;
                guessrate=IRateNow + guessinc;
                IRateNow=guessrate;
                iskip=1;
                iconsec=0;
            elseif((a1 == a2) && (iconsec<4))
                IRateNow=guessrate + guessinc;
                guessrate=IRateNow;
                iskip=1;
            elseif((a1 == a2) && (iconsec>=4))
                iconsec=0;
                guessinc=-0.5*guessinc;
                IRateNow=guessrate + guessinc;
                guessrate=IRateNow;
                iskip=1;
            end
        end
    
        TestValues(i,4)=bestfit;
        TestValues(i,5)=isign;
        TestValues(i,6)=difflast;
        TestValues(i,7)=diffnow;
        TestValues(i,8)=guessinc;
        TestValues(i,9)=mindiff;
        TestValues(i,10)=iconsec;
        maxiter=i;
        % dispstr=strcat('Now at iteration-',num2str(maxiter));
        % disp(dispstr)
        if(abs(mindiff)<tol)
             maxiter=i;
             break
        end
        if(i>500)
            igo=0;
        end
    end 
    if(igo==1)
        AnnualRateOfReturn=IRateNow;
    else
        AnnualRateOfReturn=NaN;
    end
    dispstr=strcat('Best Rate is=',num2str(AnnualRateOfReturn),'-number of iterations is-',num2str(maxiter));
    disp(dispstr)
% disp('Run done')
   ab=1;
end