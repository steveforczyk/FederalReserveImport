function  PlotFredData(FRObj,InputTT,itype,titlestr)
% The purpose of this routine os to plot data from the Federal Reserve
% (FRED)
%  Idea is just to get a quick sanity check
% Written By: Stephen Forczyk
% Created: June 14,2025
% Revised: Jun 21,2025 Added itype 13
% Revised: Jun 22 thru Jun 26 added itype=14-through itype-20
% Revised: Jun 27,2025 added logic to include the logo of the Federal
% Reserve to the bottom right of the chart
% Revised: Jun 28 Thru Aug 4 added more plots
% Revised: Sep 17,2025 replacing global variables with Objects
% Revised: Oct 2025 Thru Feb 2026 added additional items
% Revised: June 2026 added additional charts




% Get the data to add a logo to the bottom right of the chart if desired
iLogo=FRObj.iLogo;
LogoFileName=FRObj.LogoFileName;
govjpegpath=FRObj.govjpegpath;
hor1=FRObj.hor1;
vert1=FRObj.vert1;
widd=FRObj.widd;
lend=FRObj.lend;
chart_time=FRObj.chart_time;
fid=FRObj.fid;
tiffpath=FRObj.tiffpath;
jpegpath=FRObj.jpegpath;
machine=FRObj.machine;
icapture=FRObj.icapture;
GrowthRateAll=FRObj.GrowthRateAll;
InferRecessionDatesTT=FRObj.InferRecessionDatesTT;% Stored Dates of US Recessions
RecessProbTT=FRObj.RecessProbTT;
SmoothedRessProb=FRObj.SmoothedRessProb;
ishowrecession=FRObj.ishowrecession;
%% Display Selected Fred Data
movie_figure1=figure('position',[hor1 vert1 widd lend]);
%set(gcf,'MenuBar','none');
if(itype==1)% Monthly Unemployment Rate
    plot(InputTT.Date,InputTT.UNRATE,'g',...
        InputTT.Date,InputTT.meanUnrate,'r--',...
        InputTT.Date,InputTT.medianUnrate,'b--',...
        InputTT.Date,InputTT.unratesmooth,'y');
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Unemployment Rate %','FontWeight','bold','FontSize',12,'FontWeight','bold');
    % Add a logo if iLogo==1
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    maxval=20;
    set(gca,'YLim',[0 20]);
    meanUnrate=mean(InputTT.UNRATE);
    medianUnrate=median(InputTT.UNRATE);
    filestr1=strcat('Mean Unemployment Rate %=',num2str(meanUnrate,4));
    fprintf(fid,'%20s\n',filestr1);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('UnEmployment Rate %','Mean','Median','Smoothed','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
elseif(itype==2)
    plot(InputTT.Date,InputTT.SCPINFNE,'g',...
        InputTT.Date,InputTT.meanSCPNFNE,'r--',...
        InputTT.Date,InputTT.medianSCPNFNE,'b--',...
        InputTT.Date,InputTT.scpismooth,'y');
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Sticky CPI %','FontWeight','bold','FontSize',12,'FontWeight','bold');
% Add a logo if iLogo==1
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    maxval=20;
    set(gca,'YLim',[0 maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    meanSCPI=mean(InputTT.SCPINFNE);
    medianSCPI=median(InputTT.SCPINFNE);
    hl=legend('Mean Sticky CPI %','Mean','Median','Smoothed','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0])
    filestr2=strcat('Mean Sticky CPI  Rate %=',num2str( meanSCPI,4));
    fprintf(fid,'%20s\n',filestr2);
elseif(itype==3)
    plot(InputTT.Date,InputTT.CIVPART_All,'r',...
        InputTT.Date,InputTT.CIVPART_25_54,'g',...
        InputTT.Date,InputTT.CIVPART_55,'b',...
        InputTT.Date,InputTT.meanPartAll,'y');
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Labor Force Participation Rate %','FontWeight','bold','FontSize',12,'FontWeight','bold');
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    maxval=100;
    set(gca,'YLim',[0 maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Labor Force Participation-All','For Ages 25-54','Ages 55 and Up',...
        'Mean Participation All','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanPartAll=mean(InputTT.CIVPART_All);
    meanPart_55=mean(InputTT.CIVPART_55);
    meanPart_25_54=mean(InputTT.CIVPART_25_54);
elseif(itype==4)
    plot(InputTT.Date,InputTT.DRSFRMACBS,'g',...
        InputTT.Date,InputTT.meanDelRate,'r--',...
        InputTT.Date,InputTT.medianDelRate,'b--',...
        InputTT.Date,InputTT.delsmooth,'y');
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Single Familiy Home Loan Delinquency Rate %','FontWeight','bold','FontSize',12,'FontWeight','bold');
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    minval=0;
    maxval=15;
    set(gca,'YLim',[0 maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Single Home Loan Deliquencies','Mean ','Median','Smoothed','Location','northwest','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanDelRate=mean(InputTT.DRSFRMACBS);
    medianDelRate=median(InputTT.DRSFRMACBS);
    ab=1;
elseif(itype==5)
    plot(InputTT.Date,InputTT.HomeOwnership,'g',...
        InputTT.Date,InputTT.meanHomeOwner,'r--',...
        InputTT.Date,InputTT.medianHomeOwner,'b--',...
        InputTT.Date,InputTT.hownsmooth,'y--');
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('HomeOwership Rate %','FontWeight','bold','FontSize',12,'FontWeight','bold');
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    minval=60;
    maxval=70;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Home Ownership Rate','Mean Rate','Median Rate','Smoothed','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanHomeRate=mean(InputTT.HomeOwnership);
    medianHomeRate=median(InputTT.HomeOwnership);
elseif(itype==6)
    plot(InputTT.Date,InputTT.IPMAN,'g',...
        InputTT.Date,InputTT.IPManMean,'r--',...
        InputTT.Date,InputTT.IPManMedian,'b--',...
        InputTT.Date,InputTT.ipmansmooth,'y--');
    if(ishowrecession==1)
        hold on
        barval=FRObj.barval;
        bar(InputTT.Date,barval*InputTT.RevFlag,'b','LineWidth',1);
        hold off
    end
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Industrial Production Index','FontWeight','bold','FontSize',12,'FontWeight','bold');
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    minval=0;
    maxval=120;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('IndustrialProd Index','Mean Index','Median Index','Smoothed','Location','northwest','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanProdRate=mean(InputTT.IPMAN);
    medianProdRate=median(InputTT.IPMAN);
elseif(itype==7)
    plot(InputTT.Date,InputTT.Income/1000,'g',...
        InputTT.Date,InputTT.HouseIncomeMean/1000,'r--',...
        InputTT.Date,InputTT.HouseIncomeMedian/1000,'b--');
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Median Household Income in thosands of USD','FontWeight','bold','FontSize',12,'FontWeight','bold');
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    minval=56;
    maxval=84;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    meanIncome=mean(InputTT.HouseIncomeMean)/1000;
    hl=legend('Household Inc Thousand USD','Mean','Median','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    GrowthRateAll=FRObj.GrowthRateAll;
elseif(itype==8)
    plot(InputTT.Date,InputTT.VIXCLS,'g',...
        InputTT.Date,InputTT.VixMean,'r--',...
        InputTT.Date,InputTT.vixsmooth,'y--');
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('CBOE Volitility Index','FontWeight','bold','FontSize',12,'FontWeight','bold');
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    minval=0;
    maxval=100;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('CBOE VIX Index','Mean Vix','Smoothed','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanVix=mean(InputTT.VIXCLS);
elseif(itype==9)
    plot(InputTT.Date,InputTT.Confidence,'g',...
      InputTT.Date,InputTT.ConfidenceMean,'r--',...
      InputTT.Date,InputTT.ConfidenceMedian,'b--',...
      InputTT.Date,InputTT.ccsmooth,'y--');
    if(ishowrecession==1)
        hold on
        barval=FRObj.barval;
        bar(InputTT.Date,barval*InputTT.RevFlag,'b','LineWidth',1);
        hold off
    end
 
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Consumer Confidence Index','FontWeight','bold','FontSize',12,'FontWeight','bold');
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    minval=40;
    maxval=120;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Consumer Confidence','Mean CC','Median CC','Smoothed','Location','northwest','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanCC=mean(InputTT.Confidence);
    medianCC=median(InputTT.Confidence);
elseif(itype==10)
    plot(InputTT.Date,InputTT.DaysOnMarket,'g',...
        InputTT.Date,InputTT.meanDays,'r--',...
        InputTT.Date,InputTT.medianDays,'b--',...
        InputTT.Date,InputTT.dayonmktsmooth,'y--');
    if(ishowrecession==1)
        hold on
        barval=FRObj.barval;
        bar(InputTT.Date,barval*InputTT.RevFlag,'b','LineWidth',1);
        hold off
    end

    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Median Days On Market','FontWeight','bold','FontSize',12,'FontWeight','bold');
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    minval=0;
    maxval=100;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('House Days On Market','Mean','Median','Smoothed','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanDaysOnMarket=mean(InputTT.DaysOnMarket);
    medianDaysOnMarket=median(InputTT.DaysOnMarket);
elseif(itype==11)
    plot(InputTT.Date,InputTT.BondYield10Years,'g',...
        InputTT.Date,InputTT.meanYield10Years,'r--',...
        InputTT.Date,InputTT.medianYield10Years,'b--',...
        InputTT.Date,InputTT.bond10smooth,'y--');
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Ten Year Fed Bond Yields','FontWeight','bold','FontSize',12,'FontWeight','bold');
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    minval=0;
    maxval=20;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Fed 10 Year Bond Yield','Mean Yield','Median Yield','Smoothed','Location','northwest','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    mean10YearBondYield=mean(InputTT.BondYield10Years);
    median10YearBondYield=median(InputTT.BondYield10Years);
elseif(itype==12)
    plot(InputTT.Date,InputTT.U2RATE,'g',...
        InputTT.Date,InputTT.meanU2,'r--',...
        InputTT.Date,InputTT.medianU2,'b--',...
        InputTT.Date,InputTT.u2smooth,'y--');
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('U2 Unemployment Rate','FontWeight','bold','FontSize',12,'FontWeight','bold');
    minval=0;
    maxval=15;
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('U2 Rate','Mean Rate','Median Rate','Smoothed','Location','northwest','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanU2=mean(InputTT.U2RATE);
    medianU2=median(InputTT.U2RATE);
elseif(itype==13)
    plot(InputTT.Date,InputTT.GDPC1/1E3,'g',...
        InputTT.Date,InputTT.meanGDP/1E3,'r--',...
        InputTT.Date,InputTT.medianGDP/1E3,'b--',...
        InputTT.Date,InputTT.realgdpsmooth/1E3,'y--');
        title(titlestr)
        xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
        ylabel('Annual GDP Reported By Quarter-Trillion USD','FontWeight','bold','FontSize',12,'FontWeight','bold');
        minval=0;
        maxval=25;
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
        set(gca,'YLim',[minval maxval]);
        set(gca,'Color', [0.3 0.3 0.3]);
        set(gca,'XGrid','on','GridColor',[1 1 1]);
        set(gca,'YGrid','on','GridColor',[1 1 1]);
        hl=legend('GDP','Mean GDP','Median GDP','Smoothed','Location','northwest','FontSize',10,'FontWeight','bold');
        set(hl,'Color',[1 1 1])
        set(hl,'TextColor',[0 0 0]);
        meanGDP=mean(InputTT.GDPC1/1E3);
        medianGDP=mean(InputTT.GDPC1/1E3);
        GrowthRateAll=FRObj.GrowthRateAll;
  elseif(itype==14)
        plot(InputTT.Date,InputTT.GDPPerCapita/1000,'g',...
            InputTT.Date,InputTT.meanGDPPerCap/1000,'r--',...
            InputTT.Date,InputTT.medianGDPPerCap/1000,'b--',...
            InputTT.Date,InputTT.gdpsmooth,'y--');
        title(titlestr)
        xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
        ylabel('Annual GDP Per Cap in 2017 Thousands USD','FontWeight','bold','FontSize',12,'FontWeight','bold');
        minval=0;
        maxval=80;
        ab=1;
   if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
        set(gca,'YLim',[minval maxval]);
        set(gca,'Color', [0.3 0.3 0.3]);
        set(gca,'XGrid','on','GridColor',[1 1 1]);
        set(gca,'YGrid','on','GridColor',[1 1 1]);
        hl=legend('GDPPerCap','Mean GDPPerCap','Median GDPPerCap','Smoothed','Location','northwest','FontSize',10,'FontWeight','bold');
        set(hl,'Color',[1 1 1])
        set(hl,'TextColor',[0 0 0]);
        meanGDPPerCap=mean(InputTT.GDPPerCapita);
        medianGDPPerCap=mean(InputTT.GDPPerCapita);
elseif(itype==15)
    plot(InputTT.Date,InputTT.Yield,'g',...
        InputTT.Date,InputTT.meanYield2Years,'r--',...
        InputTT.Date,InputTT.medianYield2Years,'b--',...
        InputTT.Date,InputTT.bond2smooth,'y--');
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Two Year Fed Bond Yields','FontWeight','bold','FontSize',12,'FontWeight','bold');
    minval=0;
    maxval=20;
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);

        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Fed 2 Year Bond Yield','Mean Yield','Median Yield','Smoothed','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    mean2YearBondYield=mean(InputTT.Yield,'omitnan');
    median2YearBondYield=median(InputTT.Yield,'omitnan');
elseif(itype==16)
    plot(InputTT.Date,InputTT.ICSA/1E6,'g',...
        InputTT.Date,InputTT.meanInitialClaims/1E6,'r--',...
        InputTT.Date,InputTT.medianInitialClaims/1E6,'b--',...
        InputTT.Date,InputTT.initu2smooth,'y--');
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Initial Unemployment Claims-Millions','FontWeight','bold','FontSize',12,'FontWeight','bold');
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    minval=0;
    maxval=10;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('InitialUnemploymentClaims','Mean Claims','Median Claim','Smoothed','Location','northwest','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanClaims=mean(InputTT.meanInitialClaims);
    medianClaims=median(InputTT.medianInitialClaims);
    ab=1;
 elseif(itype==17)
    plot(InputTT.Date,InputTT.CCSA/1E6,'g',...
        InputTT.Date,InputTT.meanContinueClaims/1E6,'r--',...
        InputTT.Date,InputTT.medianContinueClaims/1E6,'b--',...
        InputTT.Date,InputTT.contu2smooth,'y--');
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Continued Unemployment Claims-Millions','FontWeight','bold','FontSize',12,'FontWeight','bold');
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    minval=0;
    maxval=30;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Continued UnemploymentClaims','Mean Claims','Median Claim','Smoothed','Location','northwest','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanClaims=mean(InputTT.meanContinueClaims);
    medianClaims=median(InputTT.medianContinueClaims);
 elseif(itype==18)
    plot(InputTT.Date,InputTT.JTSJOL,'g',...
        InputTT.Date,InputTT.meanNFJO,'r--',...
        InputTT.Date,InputTT.medianNFJO,'b--',...
        InputTT.Date,InputTT.nfarmsmooth,'y--');
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('NF Job Openings in thousands','FontWeight','bold','FontSize',12,'FontWeight','bold');
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    minval=0;
    maxval=14000;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('NonFarm Jobs Open','Mean Open','Median Open','Smoothed','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanNFJO=mean(InputTT.JTSJOL,'omitnan');
    medianNFJO=median(InputTT.JTSJOL,'omitnan');
 elseif(itype==19)
    plot(InputTT.Date,InputTT.JTS2300JOL,'g',...
        InputTT.Date,InputTT.meanCJOpen,'r--',...
        InputTT.Date,InputTT.medianCJOpen,'b--',...
        InputTT.Date,InputTT.constsmooth,'y--');
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Construction Jobs Open-thousands','FontWeight','bold','FontSize',12,'FontWeight','bold');
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    maxCJOpenVal=max(InputTT.JTS2300JOL,[],'omitnan');
    minval=0;
    maxval1=floor(maxCJOpenVal/100);
    maxval=100*maxval1+100;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Construction Jobs Open','Mean Open','Median Open','Smoothed','Location','northwest','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanCJ=mean(InputTT.JTS2300JOL,'omitnan');
    medianCJ=median(InputTT.JTS2300JOL,'omitnan');
    ab=1;
  elseif(itype==20)
    plot(InputTT.Date,InputTT.JTS3000JOL,'g',...
        InputTT.Date,InputTT.meanMFacOpen,'r--',...
        InputTT.Date,InputTT.medianMFacOpen,'b--',...
        InputTT.Date,InputTT.mansmooth,'y--');
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Manufacturing Jobs Open-thousands','FontWeight','bold','FontSize',12,'FontWeight','bold');
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    maxMFacOpenVal=max(InputTT.JTS3000JOL,[],'omitnan');
    minval=0;
    maxval1=floor(maxMFacOpenVal/1000);
    maxval=1200;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Manufacturing Jobs Open','Mean Open','Median Open','Smoothed','Location','northwest','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanMFacVal=mean(InputTT.JTS3000JOL,'omitnan');
    medianMFacVal=median(InputTT.JTS3000JOL,'omitnan');
  elseif(itype==21)
    plot(InputTT.Date,InputTT.JTS540099JOL,'g',...
        InputTT.Date,InputTT.meanProfOpen,'r--',...
        InputTT.Date,InputTT.medianProfOpen,'b--', ...
        InputTT.Date,InputTT.profsmooth,'y');
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Professional Jobs Open-thousands','FontWeight','bold','FontSize',12,'FontWeight','bold');
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    maxProfOpenVal=max(InputTT.JTS540099JOL,[],'omitnan');
    minval=0;
    maxval1=floor(maxProfOpenVal/1000);
    maxval=1000*maxval1+1000;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Professional Jobs Open','Mean Open','Median Open','Smoothed','Location','northwest','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanProfOpenVal=mean(InputTT.JTS540099JOL,'omitnan');
    medianProfOpenVal=median(InputTT.JTS540099JOL,'omitnan');
  elseif(itype==22)
    plot(InputTT.Date,InputTT.JTS6200JOL,'g',...
        InputTT.Date,InputTT.meanHCOpen,'r--',...
        InputTT.Date,InputTT.medianHCOpen,'b--',...
        InputTT.Date,InputTT.hcaresmooth,'y--');
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Health Care Jobs Open-thousands','FontWeight','bold','FontSize',12,'FontWeight','bold');
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    maxHCOpenVal=max(InputTT.JTS6200JOL,[],'omitnan');
    minval=0;
    maxval1=floor(maxHCOpenVal/100);
    maxval=100*maxval1+100;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('HealthCare Jobs Open','Mean Open','Median Open','Smoothed','Location','northwest','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanHCOpenVal=mean(InputTT.JTS6200JOL,'omitnan');
    medianHCOpenVal=median(InputTT.JTS6200JOL,'omitnan');
elseif(itype==23)
    plot(InputTT.Date,InputTT.JTS9000JOL,'g',...
        InputTT.Date,InputTT.meanGovOpen,'r--',...
        InputTT.Date,InputTT.medianGovOpen,'b--',...
        InputTT.Date,InputTT.govsmooth,'y');
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Government Jobs Open-thousands','FontWeight','bold','FontSize',12,'FontWeight','bold');
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    maxGovOpenVal=max(InputTT.JTS9000JOL,[],'omitnan');
    minval=0;
    maxval1=floor(maxGovOpenVal/100);
    maxval=100*maxval1+100;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Govt Jobs Open','Mean Open','Median Open','Smooted','Location','northwest','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanGovOpenVal=mean(InputTT.JTS9000JOL,'omitnan');
    medianGovOpenVal=median(InputTT.JTS9000JOL,'omitnan');
 elseif(itype==24)
    plot(InputTT.Date,InputTT.Income/1000,'g',...
        InputTT.Date,InputTT.meanPIncome/1000,'r--',...
        InputTT.Date,InputTT. medianPIncome/1000,'b--');
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Median Real Personal Income Thousands USD','FontWeight','bold','FontSize',12,'FontWeight','bold');
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    minval=20;
    maxval=50;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Median Personal Income','Mean Income','Median Income','Location','northwest','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanRealPIncomeVal=mean(InputTT.Income/1000,'omitnan');
    medianRealPIncomeVal=median(InputTT.Income/1000,'omitnan');
 elseif(itype==25)
    plot(InputTT.Date,InputTT.T10Y2Y,'g',...
         InputTT.Date,InputTT.meanRateDiff,'r--',...
         InputTT.Date,InputTT.medianRateDiff,'b--',...
         InputTT.Date,InputTT.diffsmooth,'y');
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Bond Rate Diff','FontWeight','bold','FontSize',12,'FontWeight','bold');
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    minval=-3;
    maxval=3;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    % set(hl,'Color',[1 1 1])
    % set(hl,'TextColor',[0 0 0]);
    hl=legend('Rate Diff','Mean Diff','Median Diff','Smoothed','Location','northwest','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanRateDiffVal=mean(InputTT.T10Y2Y,'omitnan');
    medianRateDiffVal=median(InputTT.T10Y2Y,'omitnan');
 elseif(itype==26)
    plot(InputTT.Date,InputTT.VISADiscretionary,'g',...
        InputTT.Date,InputTT.meanDisc,'r--',...
        InputTT.Date,InputTT.medianDisc,'b--');
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Visa Discretionary Spend Index','FontWeight','bold','FontSize',12,'FontWeight','bold');
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    maxDiscVal=max(InputTT.VISADiscretionary,[],'omitnan');
    minval=0;
    maxval=150;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Discretionary Spend Index','Mean','Median','Location','northwest','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanDiscVal=mean(InputTT.VISADiscretionary,'omitnan');
    medianDiscVal=median(InputTT.VISADiscretionary,'omitnan');
 elseif(itype==27)
    plot(InputTT.Date,InputTT.HousePriceIndex,'g',...
        InputTT.Date,InputTT.meanIndex,'r--',...
        InputTT.Date,InputTT.medianIndex,'b--',...
        InputTT.Date,InputTT.shillersmooth,'y');
    if(ishowrecession==1)
        hold on
        barval=FRObj.barval;
        bar(InputTT.Date,barval*InputTT.RevFlag,'b','LineWidth',1);
        hold off
    end
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Case Shiller House Price Index','FontWeight','bold','FontSize',12,'FontWeight','bold');
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    minval=0;
    maxval=400;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('House Price Index','Mean','Median','Smoothed','Location','northwest','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanIndexVal=mean(InputTT.meanIndex,'omitnan');
    medianIndexVal=median(InputTT.medianIndex,'omitnan');
 elseif(itype==28)
    plot(InputTT.Date,InputTT.WeeklyWage,'g',...
        InputTT.Date,InputTT.meanWage,'r--',...
        InputTT.Date,InputTT.medianWage,'b--',...
        InputTT.Date,InputTT.wagessmooth,'y');
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Median Weekly US Wage','FontWeight','bold','FontSize',12,'FontWeight','bold');
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    minval=250;
    maxval=450;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Mean Weekly Wage','Mean','Median','Smoothed Wages','Location','northwest','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanWageVal=mean(InputTT.WeeklyWage,'omitnan');
    medianWageVal=median(InputTT.WeeklyWage,'omitnan');
 elseif(itype==29)
    plot(InputTT.Date,InputTT.FYGDP/1E3,'g',...
        InputTT.Date,InputTT.meanGDP/1E3,'r--',...
        InputTT.Date,InputTT.medianGDP/1E3,'b--');
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('FYGDP-Trillions USD','FontWeight','bold','FontSize',12,'FontWeight','bold');
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    minval=0;
    maxval=30;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('FYGDP','Mean','Median','Location','northwest','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanGDPVal=mean(InputTT.FYGDP,'omitnan');
    medianGDPVal=median(InputTT.FYGDP,'omitnan');
 elseif(itype==30)
    plot(InputTT.Date,InputTT.DebtPerCent,'g',...
        InputTT.Date,InputTT.meanDebt,'r--',...
        InputTT.Date,InputTT.medianDebt,'b--',...
        InputTT.Date,InputTT.debtsmooth,'y');
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Fed Debt As Percentage of GDP','FontWeight','bold','FontSize',12,'FontWeight','bold');
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    minval=0;
    maxval=150;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Debt %','Mean','Median','Smoothed','Location','northwest','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanDebtVal=mean(InputTT.DebtPerCent,'omitnan');
    medianDebtVal=median(InputTT.DebtPerCent,'omitnan');
 elseif(itype==31)
    plot(InputTT.Date,InputTT.Surplus/1000,'g',...
        InputTT.Date,InputTT.meanSurplus,'r--',...
        InputTT.Date,InputTT.medianSurplus,'b--',...
        InputTT.Date,InputTT.bdebtsmooth,'y--');
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Fed Budget Surplus Billions USD','FontWeight','bold','FontSize',12,'FontWeight','bold');
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    minval=-800;
    maxval=800;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Surplus Billion','Mean','Median','Smoothed','Location','northwest','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanSurplusVal=mean(InputTT.Surplus,'omitnan')/1000;
    medianSurplusVal=median(InputTT.Surplus,'omitnan')/1000;
 elseif(itype==32)
    plot(InputTT.Date,InputTT.NetOutlays,'g',...
        InputTT.Date,InputTT.meanOutlay,'r--',...
        InputTT.Date,InputTT.medianOutlay,'b--');
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Fed Budget Outlay as % GDP','FontWeight','bold','FontSize',12,'FontWeight','bold');
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    minval=0;
    maxval=50;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Outlay %','Mean','Median','Location','northwest','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanOutlayVal=mean(InputTT.NetOutlays,'omitnan');
    medianOutlayVal=median(InputTT.NetOutlays,'omitnan');
 elseif(itype==33)
    plot(InputTT.Date,InputTT.Receipts,'g',...
        InputTT.Date,InputTT.meanReceipts,'r--',...
        InputTT.Date,InputTT.medianReceipts,'b--', ...
        InputTT.Date,InputTT.receipsmooth,'y--');
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Fed Budget Receipts as % GDP','FontWeight','bold','FontSize',12,'FontWeight','bold');
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    minval=0;
    maxval=50;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Receipts %','Mean','Median','Smoothed','Location','northwest','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanReceiptVal=mean(InputTT.Receipts,'omitnan');
    medianReceiptVal=median(InputTT.Receipts,'omitnan');
  elseif(itype==34)
    plot(InputTT.Date,InputTT.PublicDebt/1E6,'g',...
        InputTT.Date,InputTT.meanDebt/1E6,'r--',...
        InputTT.Date,InputTT.medianDebt/1E6,'b--',...
        InputTT.Date,InputTT.fpdsmooth/1E6,'y--');
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('PublicDept-Trillions-USD','FontWeight','bold','FontSize',12,'FontWeight','bold');
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    minval=0;
    maxval1=max(InputTT.PublicDebt/1E6,[],'omitnan');
    maxval=maxval1;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Public Debt','Mean','Median','Smoothed','Location','northwest','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanDebtVal=mean(InputTT.PublicDebt,'omitnan')/1E6;
    medianDebtVal=median(InputTT.PublicDebt,'omitnan')/1E6;
elseif(itype==35)
    plot(InputTT.Date,InputTT.Interest,'g',...
        InputTT.Date,InputTT.meanInterest,'r--',...
        InputTT.Date,InputTT.medianInterest,'b--',...
        InputTT.Date,InputTT.intpaysmooth,'y--');
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('FedInterestPayments%GDP','FontWeight','bold','FontSize',12,'FontWeight','bold');
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    minval=0;
    maxval=4;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Fed Interest','Mean','Median','Smoothed','Location','northwest','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanInterestVal=mean(InputTT.Interest,'omitnan');
    medianInterestVal=median(InputTT.Interest,'omitnan');
elseif(itype==36)
    plot(InputTT.Date,InputTT.TreasuryDebt/1E3,'g',...
        InputTT.Date,InputTT.meanTDebt/1E3,'r--',...
        InputTT.Date,InputTT.medianTDebt/1E3,'b--',...
        InputTT.Date,InputTT.tdebtsmooth/1E3,'y--');
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('MktValue-TresuryDebt-Trillion-USD','FontWeight','bold','FontSize',12,'FontWeight','bold');
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    minval=0;
    maxval1=max(InputTT.TreasuryDebt/1E3,[],'omitnan');
    maxval=maxval1;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Mkt Value','Mean','Median','Smoothed','Location','northwest','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanTDebtVal=mean(InputTT.TreasuryDebt,'omitnan')/1E3;
    medianTDebtVal=median(InputTT.TreasuryDebt,'omitnan')/1E3;
    ab=1;% Mar 12
 elseif(itype==37)
    plot(InputTT.Date,InputTT.AUINSA,'g',...
        InputTT.Date,InputTT.meanInventory,'r--',...
        InputTT.Date,InputTT.medianInventory,'b--',...
        InputTT.Date,InputTT.autosmooth,'y--');
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Domestic Auto Inventory-Thousands','FontWeight','bold','FontSize',12,'FontWeight','bold');
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    minval=0;
    % maxval1=max(InputTT.AUINSA,[],'omitnan');
    % maxval=1000*floor(maxval1/1000)+1000;
    maxval=2000;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Auto Inventory','Mean','Median','smoothed','Location','northwest','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanInventoryVal=mean(InputTT.AUINSA,'omitnan')/1E3;
    medianInventoryVal=median(InputTT.AUINSA,'omitnan')/1E3;
 elseif(itype==38)
    plot(InputTT.Date,InputTT.FAUTOSAAR,'g',...
        InputTT.Date,InputTT.meanFSales,'r--',...
        InputTT.Date,InputTT.medianFSales,'b--',...
        InputTT.Date,InputTT.autosmooth,'y--');
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Foreign Auto Sales Millions','FontWeight','bold','FontSize',12,'FontWeight','bold');
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    minval=0;
    maxval=4.0;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Foreign Auto Sales','Mean','Median','Smoothed','Location','northwest','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanFSalesVal=mean(InputTT.FAUTOSAAR,'omitnan');
    medianFSalesVal=median(InputTT.FAUTOSAAR,'omitnan');
 elseif(itype==39)
    plot(InputTT.Date,InputTT.TOTALSA,'g',...
        InputTT.Date,InputTT.meanTSales,'r--',...
        InputTT.Date,InputTT.medianTSales,'b--',...
        InputTT.Date,InputTT.autosmooth,'y--');
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Total Vehicle Sales Millions','FontWeight','bold','FontSize',12,'FontWeight','bold');
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    minval=0;
    maxval=25;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Total Vehicle Sales','Mean','Median','Smoothed','Location','northwest','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanTSalesVal=mean(InputTT.TOTALSA,'omitnan');
    medianTSalesVal=median(InputTT.TOTALSA,'omitnan');
 elseif(itype==40)
    plot(InputTT.Date,InputTT.DAUPSA,'g',...
        InputTT.Date,InputTT.meanDomProd,'r--',...
        InputTT.Date,InputTT.medianDomProd,'b--',...
        InputTT.Date,InputTT.dautosmooth,'y--');
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Domestic Auto Production-Thousands','FontWeight','bold','FontSize',12,'FontWeight','bold');
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    minval=0;
    maxval=600;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Total Vehicle Sales','Mean','Median','Smoothed','Location','northeast','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanDomProdVal=mean(InputTT.DAUPSA,'omitnan');
    medianDomProdVal=median(InputTT.DAUPSA,'omitnan');
 elseif(itype==41)
    plot(InputTT.Date,InputTT.AUENSA,'g',...
        InputTT.Date,InputTT.meanAutoExports,'r--',...
        InputTT.Date,InputTT.medianAutoExports,'b--',...
        InputTT.Date,InputTT.exsmooth,'y--');
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('DomesticAutoExports-Thousands','FontWeight','bold','FontSize',12,'FontWeight','bold');
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    minval=0;
    maxval=200;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Total Exports','Mean','Median','Smoothed','Location','northwest','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanAutoExportsVal=mean(InputTT.AUENSA,'omitnan');
    medianAutoExportsVal=median(InputTT.AUENSA,'omitnan');
 elseif(itype==42)
    plot(InputTT.Date,InputTT.Miles/1000,'g',...
        InputTT.Date,InputTT.meanVehMiles,'r--',...
        InputTT.Date,InputTT.medianVehMiles,'b--',...
        InputTT.Date,InputTT.vmsmooth,'y');
    if(ishowrecession==1)
        hold on
        barval=FRObj.barval;
        bar(InputTT.Date,barval*InputTT.RevFlag,'b','LineWidth',1);
        hold off
    end
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Vehicle Miles In Billion','FontWeight','bold','FontSize',12,'FontWeight','bold');
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    minval=0;
    maxval=400;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Total Miles','Mean','Median','Smoothed Miles','Location','northwest','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanVehMilesVal=mean(InputTT.Miles,'omitnan')/1000;
    medianVehMilesVal=median(InputTT.Miles,'omitnan')/1000;
elseif(itype==43)
    plot(InputTT.Date,InputTT.FTI,'g',...
        InputTT.Date,InputTT.meanFreightIndex,'r--',...
        InputTT.Date,InputTT.medianFreightIndex,'b--');
    if(ishowrecession==1)
        hold on
        barval=FRObj.barval;
        bar(InputTT.Date,barval*InputTT.RevFlag,'b','LineWidth',1);
        hold off
    end
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Freight Transport Index','FontWeight','bold','FontSize',12,'FontWeight','bold');
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    minval=0;
    maxval=200;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('FTI','Mean','Median','Location','northwest','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanFTIVal=mean(InputTT.FTI,'omitnan');
    medianFTIVal=median(InputTT.FTI,'omitnan');
elseif(itype==44)
    plot(InputTT.Date,InputTT.RailCarLoads/1E3,'g',...
        InputTT.Date,InputTT.meanRailLoads/1E3,'r--',...
        InputTT.Date,InputTT.medianRailLoads/1E3,'b--');
    title(titlestr)
    if(ishowrecession==1)
        hold on
        barval=FRObj.barval;
        bar(InputTT.Date,barval*InputTT.RevFlag,'b','LineWidth',1);
        hold off
    end
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('RailCarLoads-Thousands','FontWeight','bold','FontSize',12,'FontWeight','bold');
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    minval=0;
    maxval=1500;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Rail Loads','Mean','Median','Location','northeast','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanRailCarVal=mean(InputTT.RailCarLoads,'omitnan')/1E3;
    medianRailCarVal=median(InputTT.RailCarLoads,'omitnan')/1E3;
elseif(itype==45)
    plot(InputTT.Date,InputTT.Loadfactor,'g',...
        InputTT.Date,InputTT.meanAirLoads,'r--',...
        InputTT.Date,InputTT.medianAirLoads,'b--',...
        InputTT.Date,InputTT.loadsmooth,'y');
    if(ishowrecession==1)
        hold on
        barval=FRObj.barval;
        bar(InputTT.Date,barval*InputTT.RevFlag,'b','LineWidth',1);
        hold off
    end
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('AirlineLoadFactor','FontWeight','bold','FontSize',12,'FontWeight','bold');
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    minval=0;
    maxval=100;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Air Loads','Mean','Median','Smoothed','Location','northeast','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanAirLoadVal=mean(InputTT.Loadfactor,'omitnan');
    medianAirLoadVal=median(InputTT.Loadfactor,'omitnan');
elseif(itype==46)
    plot(InputTT.Date,InputTT.AvailMiles/1E6,'g',...
        InputTT.Date,InputTT.meanASM,'r--',...
        InputTT.Date,InputTT.medianASM,'b--',...
        InputTT.Date,InputTT.asmsmooth/1E6,'y');
    if(ishowrecession==1)
        hold on
        barval=FRObj.barval;
        bar(InputTT.Date,barval*InputTT.RevFlag,'b','LineWidth',1);
        hold off
    end
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('AvailableSeatMiles-in-Millions','FontWeight','bold','FontSize',12,'FontWeight','bold');
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    minval=0;
    maxval=120;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('ASM','Mean','Median','Smoothed ','Location','northeast','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanASMVal=mean(InputTT.AvailMiles/1E6,'omitnan');
    medianASMVal=median(InputTT.AvailMiles/1E6,'omitnan');
elseif(itype==47)
    plot(InputTT.Date,InputTT.Petrol/1E6,'g',...
        InputTT.Date,InputTT.meanPetrol,'r--',...
        InputTT.Date,InputTT.medianPetrol,'b--',...
        InputTT.Date,InputTT.oilsmooth,'y');
    if(ishowrecession==1)
        hold on
        barval=FRObj.barval;
        bar(InputTT.Date,barval*InputTT.RevFlag,'b','LineWidth',1);
        hold off
    end
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Petrol-Millions-Of=Barrels','FontWeight','bold','FontSize',12,'FontWeight','bold');
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    minval=0;
    maxval=1;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Petrol','Mean','Median','Smoothed','Location','northeast','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanPetrolVal=mean(InputTT.Petrol,'omitnan')/1E6;
    medianPetrolVal=median(InputTT.Petrol,'omitnan')/1E6;
elseif(itype==48)
    plot(InputTT.Date,InputTT.HousingStarts,'g',...
        InputTT.Date,InputTT.meanHousing,'r--',...
        InputTT.Date,InputTT.medianHousing,'b--',...
        InputTT.Date,InputTT.housesmooth,'y');
    if(ishowrecession==1)
        hold on
        barval=FRObj.barval;
        bar(InputTT.Date,barval*InputTT.RevFlag,'b','LineWidth',1);
        hold off
    end
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Housing-Starts-Thousands','FontWeight','bold','FontSize',12,'FontWeight','bold');
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    minval=0;
    maxval=2000;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('HStarts','Mean','Median','Smoothed ','Location','northeast','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanHouseVal=mean(InputTT.HousingStarts,'omitnan');
    medianHouseVal=median(InputTT.HousingStarts,'omitnan');
 elseif(itype==49)
    plot(InputTT.Date,InputTT.MDSP,'g',...
        InputTT.Date,InputTT.meanMDSP,'r--',...
        InputTT.Date,InputTT.medianMDSP,'b--',...
        InputTT.Date,InputTT.mdspsmooth,'y');
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Mortgage Payments As Income Per Centage','FontWeight','bold','FontSize',12,'FontWeight','bold');
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    minval=0;
    maxval=10;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('MDSP%','Mean','Median','Smoothed','Location','northeast','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanMDSPVal=mean(InputTT.MDSP,'omitnan');
    medianMDSPVal=median(InputTT.MDSP,'omitnan');
 elseif(itype==50)
    plot(InputTT.Date,InputTT.Vacant/1E3,'g',...
        InputTT.Date,InputTT.meanVacant/1E3,'r--',...
        InputTT.Date,InputTT.medianVacant/1E3,'b--');
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Vacant Housing Units In Millions','FontWeight','bold','FontSize',12,'FontWeight','bold');
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    minval=10;
    maxval=20;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Vacant Units','Mean','Median','Location','northeast','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanVacantVal=mean(InputTT.Vacant,'omitnan')/1E3;
    medianVacantVal=median(InputTT.Vacant,'omitnan')/1E3;
  elseif(itype==51)
    plot(InputTT.Date,InputTT.USPatents/1E3,'g',...
        InputTT.Date,InputTT.meanPatents/1E3,'r--',...
        InputTT.Date,InputTT.medianPatents/1E3,'b--');
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('US Patents Granted In Thousands','FontWeight','bold','FontSize',12,'FontWeight','bold');
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    minval=0;
    maxval=200;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Patents','Mean','Median','Location','northeast','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanPatentsVal=mean(InputTT.USPatents,'omitnan')/1E3;
    medianPatentsVal=median(InputTT.USPatents,'omitnan')/1E3;
  elseif(itype==52)
    plot(InputTT.Date,InputTT.TCU,'g',...
        InputTT.Date,InputTT.meanTCU,'r--',...
        InputTT.Date,InputTT.medianTCU,'b--',...
        InputTT.Date,InputTT.capsmooth,'y--');
    if(ishowrecession==1)
        hold on
        barval=FRObj.barval;
        bar(InputTT.Date,barval*InputTT.RevFlag,'b','LineWidth',1);
        hold off
    end
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Total Capacity Utlization %','FontWeight','bold','FontSize',12,'FontWeight','bold');
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    minval=50;
    maxval=100;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Capacity','Mean','Median','Smoothed','Location','northeast','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanTCUVal=mean(InputTT.TCU,'omitnan');
    medianTCUVal=median(InputTT.TCU,'omitnan');
  elseif(itype==53)
    plot(InputTT.Date,InputTT.Semiconductors,'g',...
        InputTT.Date,InputTT.meanSemi,'r--',...
        InputTT.Date,InputTT.medianSemi,'b--',...
        InputTT.Date,InputTT.techsmooth,'y--');
    if(ishowrecession==1)
        hold on
        barval=FRObj.barval;
        bar(InputTT.Date,barval*InputTT.RevFlag,'b','LineWidth',1);
        hold off
    end
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Semiconductor Capacity Utlization %','FontWeight','bold','FontSize',12,'FontWeight','bold');
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    minval=0;
    maxval=200;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Capacity','Mean','Median','Smoothed','Location','northeast','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanSemiVal=mean(InputTT.Semiconductors,'omitnan');
    medianSemiVal=median(InputTT.Semiconductors,'omitnan');
 elseif(itype==54)
    plot(InputTT.Date,InputTT.Defense,'g',...
        InputTT.Date,InputTT.meanDefense,'r--',...
        InputTT.Date,InputTT.medianDefense,'b--',...
        InputTT.Date,InputTT.defsmooth,'y--');
    if(ishowrecession==1)
        hold on
        barval=FRObj.barval;
        bar(InputTT.Date,barval*InputTT.RevFlag,'b','LineWidth',1);
        hold off
    end
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Defense Capacity Utlization %','FontWeight','bold','FontSize',12,'FontWeight','bold');
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    minval=0;
    maxval=150;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Def Capacity','Mean','Median','Smoothed','Location','northeast','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanDefenseVal=mean(InputTT.Defense,'omitnan');
    medianDefenseVal=median(InputTT.Defense,'omitnan');
 elseif(itype==55)
    plot(InputTT.Date,InputTT.TotalRevenue/1E3,'g',...
        InputTT.Date,InputTT.meanTotRev,'r--',...
        InputTT.Date,InputTT.medianTotRev,'b--',...
        InputTT.Date,InputTT.hospsmooth/1E3,'y--');
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Total Revenue All Hospitals-Billions USD','FontWeight','bold','FontSize',12,'FontWeight','bold');
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    minval=0;
    maxval=600;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Revenue','Mean','Median',',Smoothed','Location','northeast','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanTotRevenueVal=mean(InputTT.TotalRevenue,'omitnan')/1E3;
    medianTotRevenueVal=median(InputTT.TotalRevenue,'omitnan')/1E3;
elseif(itype==56)
    plot(InputTT.Date,InputTT.PharmaIndex,'g',...
        InputTT.Date,InputTT.meanPrice,'r--',...
        InputTT.Date,InputTT.medianPrice,'b--');
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Pharma Price Index Relative to 2017','FontWeight','bold','FontSize',12,'FontWeight','bold');
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    minval=90;
    maxval=110;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Price Index','Mean','Median','Location','northeast','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanPriceVal=mean(InputTT.PharmaIndex,'omitnan');
    medianPriceVal=median(InputTT.PharmaIndex,'omitnan');
  elseif(itype==57)
    plot(InputTT.Date,InputTT.PPIACO,'g',...
        InputTT.Date,InputTT.meanPPI,'r--',...
        InputTT.Date,InputTT.medianPPI,'b--',...
        InputTT.Date,InputTT.ppismooth,'y--');
    if(ishowrecession==1)
        hold on
        barval=FRObj.barval;
        bar(InputTT.Date,barval*InputTT.RevFlag,'b','LineWidth',1);
        hold off
    end
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Producer Price Index wrt 1982','FontWeight','bold','FontSize',12,'FontWeight','bold');
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    minval=0;
    maxval=320;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('PPI','Mean','Median','Smoothed','Location','northeast','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanPPIVal=mean(InputTT.PPIACO,'omitnan');
    medianPPIVal=median(InputTT.PPIACO,'omitnan');
 elseif(itype==58)
    plot(InputTT.Date,InputTT.FlexCPI,'g',...
        InputTT.Date,InputTT.meanFCPI,'r--',...
        InputTT.Date,InputTT.medianFCPI,'b--',...
        InputTT.Date,InputTT.flexsmooth,'y');
    if(ishowrecession==1)
        hold on
        barval=FRObj.barval;
        bar(InputTT.Date,barval*InputTT.RevFlag,'b','LineWidth',1);
        hold off
    end
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Flex CPI %','FontWeight','bold','FontSize',12,'FontWeight','bold');
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    minval=-10;
    maxval=20;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('FCPPI','Mean','Median','Smoothed','Location','northeast','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanFCPIVal=mean(InputTT.FlexCPI,'omitnan');
    medianFCPIVal=median(InputTT.FlexCPI,'omitnan');
 elseif(itype==59)
    plot(InputTT.Date,InputTT.Completed,'g',...
        InputTT.Date,InputTT.meanHStarts,'r--',...
        InputTT.Date,InputTT.medianHStarts,'b--',...
        InputTT.Date,InputTT.compsmooth,'y');
    if(ishowrecession==1)
        hold on
        barval=FRObj.barval;
        bar(InputTT.Date,barval*InputTT.RevFlag,'b','LineWidth',1);
        hold off
    end
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Housing Starts in Thousands','FontWeight','bold','FontSize',12,'FontWeight','bold');
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    minval=0;
    maxval=2000;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('HStarts','Mean','Median','Smoothed','Location','northeast','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanHStartsVal=mean(InputTT.Completed,'omitnan');
    medianHStartsVal=median(InputTT.Completed,'omitnan');
 elseif(itype==60)
    plot(InputTT.Date,InputTT.Sales/1E3,'g',...
        InputTT.Date,InputTT.meanAdvSales/1E3,'r--',...
        InputTT.Date,InputTT.medianAdvSales/1E3,'b--',...
        InputTT.Date,InputTT.retailsmooth/1E3,'y');
    if(ishowrecession==1)
        hold on
        barval=FRObj.barval;
        bar(InputTT.Date,barval*InputTT.RevFlag,'b','LineWidth',1);
        hold off
    end
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Sales in Billions USD','FontWeight','bold','FontSize',12,'FontWeight','bold');
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    minval=0;
    maxval=800;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Retail Sales','Mean','Median','Smoothed','Location','northeast','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanSalesVal=mean(InputTT.Sales,'omitnan')/1E3;
    medianSalesVal=median(InputTT.Sales,'omitnan')/1E3;
 elseif(itype==61)
    plot(InputTT.Date,InputTT.Sales/1E3,'g',...
        InputTT.Date,InputTT.meanSales/1E3,'r--',...
        InputTT.Date,InputTT.medianSales/1E3,'b--',...
        InputTT.Date,InputTT.ecomsmooth/1E3,'y');
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Sales in Billions USD','FontWeight','bold','FontSize',12,'FontWeight','bold');
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    minval=0;
    maxval=400;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Retail Sales','Mean','Median','Smoothed','Location','northeast','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanSalesVal=mean(InputTT.Sales,'omitnan')/1E3;
    medianSalesVal=median(InputTT.Sales,'omitnan')/1E3;
elseif(itype==62)
    plot(InputTT.Date,InputTT.SalesRatio,'g',...
        InputTT.Date,InputTT.meanInventory,'r--',...
        InputTT.Date,InputTT.medianInventory,'b--',...
        InputTT.Date,InputTT.invsmooth,'y--');
    if(ishowrecession==1)
        hold on
        barval=FRObj.barval;
        bar(InputTT.Date,barval*InputTT.RevFlag,'b','LineWidth',1);
        hold off
    end
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Inventory To Sales Ratio','FontWeight','bold','FontSize',12,'FontWeight','bold');
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    minval=1;
    maxval=2;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('SalesRatio','Mean','Median','Smoothed','Location','northeast','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanSRatioVal=mean(InputTT.SalesRatio,'omitnan');
    medianSRatioVal=median(InputTT.SalesRatio,'omitnan');
 elseif(itype==63)
    plot(InputTT.Date,InputTT.Inventories/1E3,'g',...
        InputTT.Date,InputTT.meanRInventory/1E3,'r--',...
        InputTT.Date,InputTT.medianRInventory/1E3,'b--',...
        InputTT.Date,InputTT.retailsmooth/1E3,'y--') 
    if(ishowrecession==1)
        hold on
        barval=FRObj.barval;
        bar(InputTT.Date,barval*InputTT.RevFlag,'b','LineWidth',1);
        hold off
    end
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Retail Inventories Billions USD','FontWeight','bold','FontSize',12,'FontWeight','bold');
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    minval=0;
    maxval=1000;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Inventories','Mean','Median','Smoothed','Location','northeast','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanInventoryVal=mean(InputTT.Inventories,'omitnan')/1E3;
    medianInventoryVal=median(InputTT.Inventories,'omitnan')/1E3;
 elseif(itype==64)
    plot(InputTT.Date,InputTT.UsedCars/1E3,'g',...
        InputTT.Date,InputTT.meanUsedCarSales/1E3,'r--',...
        InputTT.Date,InputTT.medianUsedCarSales/1E3,'b--',...
        InputTT.Date,InputTT.salessmooth/1E3,'y--');
    if(ishowrecession==1)
        hold on
        barval=FRObj.barval;
        bar(InputTT.Date,barval*InputTT.RevFlag,'b','LineWidth',1);
        hold off
    end
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Retail Sales Used Cars- Billion USD','FontWeight','bold','FontSize',12,'FontWeight','bold');
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    minval=0;
    maxval=20;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Used Car Sales','Mean','Median','Smoothed Sales','Location','northeast','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanSalesVal=mean(InputTT.UsedCars,'omitnan')/1E3;
    medianSalesVal=median(InputTT.UsedCars,'omitnan')/1E3;
 elseif(itype==65)
    plot(InputTT.Date,InputTT.Expenses/1E3,'g',...
        InputTT.Date,InputTT.meanRSales/1E3,'r--',...
        InputTT.Date,InputTT.medianRSales/1E3,'b--',...
        InputTT.Date,InputTT.restsmooth/1E3,'y--');
    if(ishowrecession==1)
        hold on
        barval=FRObj.barval;
        bar(InputTT.Date,barval*InputTT.RevFlag,'b','LineWidth',1);
        hold off
    end
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Restaurant Sales- Billion USD','FontWeight','bold','FontSize',12,'FontWeight','bold');
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    minval=0;
    maxval=120;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Restaurant Sales','Mean','Median','Smoothed','Location','northeast','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanRSalesVal=mean(InputTT.Expenses,'omitnan')/1E3;
    medianRSalesVal=median(InputTT.Expenses,'omitnan')/1E3;
 elseif(itype==66)
    plot(InputTT.Date,InputTT.Hfurn/1E3,'g',...
        InputTT.Date,InputTT.meanFSales/1E3,'r--',...
        InputTT.Date,InputTT.medianFSales/1E3,'b--',...
        InputTT.Date,InputTT.furnsmooth/1E3,'y--');
    if(ishowrecession==1)
        hold on
        barval=FRObj.barval;
        bar(InputTT.Date,barval*InputTT.RevFlag,'b','LineWidth',1);
        hold off
    end
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Furniture Sales- Billion USD','FontWeight','bold','FontSize',12,'FontWeight','bold');
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    minval=0;
    maxval=15;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Furniture Sales','Mean','Median','Smoothed','Location','northeast','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanFSalesVal=mean(InputTT.Hfurn,'omitnan')/1E3;
    medianFSalesVal=median(InputTT.Hfurn,'omitnan')/1E3;
elseif(itype==67)
    plot(InputTT.Date,InputTT.Sales/1E6,'g',...
        InputTT.Date,InputTT.meanMSales/1E6,'r--',...
        InputTT.Date,InputTT.medianMSales/1E6,'b--',...
        InputTT.Date,InputTT.mansmooth/1E6,'y--');
    if(ishowrecession==1)
        hold on
        barval=FRObj.barval;
        bar(InputTT.Date,barval*InputTT.RevFlag,'b','LineWidth',1);
        hold off
    end 
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Manufacturing Sales- Trillion USD','FontWeight','bold','FontSize',12,'FontWeight','bold');
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    minval=0;
    maxval=2;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Restaurant Sales','Mean','Median','Smoothed','Location','northeast','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanMSalesVal=mean(InputTT.Sales,'omitnan')/1E6;
    medianMSalesVal=median(InputTT.Sales,'omitnan')/1E6;
 elseif(itype==68)
    plot(InputTT.Date,InputTT.NewCars/1E3,'g',...
        InputTT.Date,InputTT.meanNewCarSales/1E3,'r--',...
        InputTT.Date,InputTT.medianNewCarSales/1E3,'b--',...
        InputTT.Date,InputTT.carsmooth/1E3,'y');
    if(ishowrecession==1)
        hold on
        barval=FRObj.barval;
        bar(InputTT.Date,barval*InputTT.RevFlag,'b','LineWidth',1);
        hold off
    end 
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Dealer Sales New Cars- Billion USD','FontWeight','bold','FontSize',12,'FontWeight','bold');
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    minval=0;
    maxval=160;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('New Car Sales','Mean','Median','Smoothed','Location','northeast','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanSalesVal=mean(InputTT.NewCars,'omitnan')/1E3;
    medianSalesVal=median(InputTT.NewCars,'omitnan')/1E3;
 elseif(itype==69)
    plot(InputTT.Date,InputTT.Sales/1E3,'g',...
        InputTT.Date,InputTT.meanRestSales/1E3,'r--',...
        InputTT.Date,InputTT.medianRestSales/1E3,'b--',...
        InputTT.Date,InputTT.restsmooth/1E3,'y--');
    if(ishowrecession==1)
        hold on
        barval=FRObj.barval;
        bar(InputTT.Date,barval*InputTT.RevFlag,'b','LineWidth',1);
        hold off
    end 
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Restuarant Sales - Billion USD','FontWeight','bold','FontSize',12,'FontWeight','bold');
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    minval=0;
    maxval=50;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('RestSales','Mean','Median','Smoothed','Location','northeast','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanSalesVal=mean(InputTT.Sales,'omitnan')/1E3;
    medianSalesVal=median(InputTT.Sales,'omitnan')/1E3;
 elseif(itype==70)
    plot(InputTT.Date,InputTT.Gas/1E3,'g',...
        InputTT.Date,InputTT.meanGasSales/1E3,'r--',...
        InputTT.Date,InputTT.medianGasSales/1E3,'b--',...
        InputTT.Date,InputTT.gassmooth/1E3,'y--');
    if(ishowrecession==1)
        hold on
        barval=FRObj.barval;
        bar(InputTT.Date,barval*InputTT.RevFlag,'b','LineWidth',1);
        hold off
    end  
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Gas Sales - Billion USD','FontWeight','bold','FontSize',12,'FontWeight','bold');
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    minval=0;
    maxval=100;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Gas  Sales','Mean','Median','Smoothed','Location','northeast','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanGasSalesVal=mean(InputTT.Gas,'omitnan')/1E3;
    medianGasSalesVal=median(InputTT.Gas,'omitnan')/1E3;
 elseif(itype==71)
    plot(InputTT.Date,InputTT.Parts/1E3,'g',...
        InputTT.Date,InputTT.meanAutoParts/1E3,'r--',...
        InputTT.Date,InputTT.medianAutoParts/1E3,'b--',...
        InputTT.Date,InputTT.autopartssmooth/1E3,'y--');
    if(ishowrecession==1)
        hold on
        barval=FRObj.barval;
        bar(InputTT.Date,barval*InputTT.RevFlag,'b','LineWidth',1);
        hold off
    end
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Auto Parts Sales - Billion USD','FontWeight','bold','FontSize',12,'FontWeight','bold');
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    minval=0;
    maxval=200;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Auto Parts Sales','Mean','Median','Smoothed','Location','northeast','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanAutoPartsVal=mean(InputTT.Parts,'omitnan')/1E3;
    medianAutoPartsVal=median(InputTT.Parts,'omitnan')/1E3;
elseif(itype==72)
    plot(InputTT.Date,InputTT.Index,'g',...
        InputTT.Date,InputTT.meanLI,'r--',...
        InputTT.Date,InputTT.medianLI,'b--',...
        InputTT.Date,InputTT.leadsmooth,'y--');
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Leading Index Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    minval=-5;
    maxval=5;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Lead Index','Mean','Median','Smoothed','Location','northeast','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanLIVal=mean(InputTT.Index,'omitnan');
    medianLIVal=median(InputTT.Index,'omitnan');
elseif(itype==73)
    plot(InputTT.Date,InputTT.Rflag,'g',...
        InputTT.Date,InputTT.meanRflag,'r--',...
        InputTT.Date,InputTT.medianRflag,'b--');
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Recession Flag','FontWeight','bold','FontSize',12,'FontWeight','bold');
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    minval=-2;
    maxval=2;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('RecessionFlag','Mean','Median','Location','northeast','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanRflagVal=mean(InputTT.Rflag,'omitnan');
    medianRflagVal=median(InputTT.Rflag,'omitnan');
elseif(itype==74)
    plot(InputTT.Date,InputTT.Indicator,'g',...
        InputTT.Date,InputTT.meanIndicator,'r--',...
        InputTT.Date,InputTT.medianIndicator,'b--',...
        InputTT.Date,InputTT.coeasmooth,'y--');
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Economic Indicator','FontWeight','bold','FontSize',12,'FontWeight','bold');
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    minval=0;
    maxval=200;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('EconomicIndicator','Mean','Median','Smoothed','Location','northeast','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanIndicatorVal=mean(InputTT.Indicator,'omitnan');
    medianIndicatorVal=median(InputTT.Indicator,'omitnan');
elseif(itype==75)
    plot(InputTT.Date,InputTT.Assets/1E6,'g',...
        InputTT.Date,InputTT.meanBankAssets/1E6,'r--',...
        InputTT.Date,InputTT.medianBankAssets/1E6,'b--',...
        InputTT.Date,InputTT.bbalsmooth/1E6,'y--');
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Bank Assets Trillions Of USD','FontWeight','bold','FontSize',12,'FontWeight','bold');
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    minval=0;
    maxval=30;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Bank Assets','Mean','Median','Smoothed','Location','northeast','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanBankAssetsVal=mean(InputTT.Assets,'omitnan')/1E6;
    medianBankAssetsVal=median(InputTT.Assets,'omitnan')/1E6;
elseif(itype==76)
    plot(InputTT.Date,InputTT.Balance/1E6,'g',...
        InputTT.Date,InputTT.meanCreditDebt/1E6,'r--',...
        InputTT.Date,InputTT.medianCreditDebt/1E6,'b--',...
        InputTT.Date,InputTT.creditsmooth/1E6,'y--');
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Credit Card Debt Trillions Of USD','FontWeight','bold','FontSize',12,'FontWeight','bold');
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    minval=0;
    maxval=2;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Credit Card Debt','Mean','Median','Smoothed','Location','northeast','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanCreditCardDebtVal=mean(InputTT.Balance,'omitnan')/1E6;
    medianCreditCardDebtVal=median(InputTT.Balance,'omitnan')/1E6;
  elseif(itype==77)
    plot(InputTT.Date,InputTT.Performance,'g',...
        InputTT.Date,InputTT.meanLPerf,'r--',...
        InputTT.Date,InputTT.medianLPerf,'b--',...
        InputTT.Date,InputTT.loansmooth,'y--');
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Per Cent Non Performing Loans','FontWeight','bold','FontSize',12,'FontWeight','bold');
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    minval=0;
    maxval=6;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Non Performing Loans','Mean','Median','Smoothed','Location','northeast','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanLPerfVal=mean(InputTT.Performance,'omitnan');
    medianLPerfVal=median(InputTT.Performance,'omitnan');
  elseif(itype==78)
    plot(InputTT.Date,InputTT.Pop/1E3,'g',...
        InputTT.Date,InputTT.meanPop/1E3,'r--',...
        InputTT.Date,InputTT.medianPop/1E3,'b--');
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Population in Millions','FontWeight','bold','FontSize',12,'FontWeight','bold');
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    minval=0;
    maxval=400;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('US Total Pop','Mean','Median','Location','northeast','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanPopVal=mean(InputTT.Pop,'omitnan')/1E3;
    medianPopVal=median(InputTT.Pop,'omitnan')/1E3;
  elseif(itype==79)
    plot(InputTT.Date,InputTT.Households/1E3,'g',...
        InputTT.Date,InputTT.meanHH/1E3,'r--',...
        InputTT.Date,InputTT.medianHH/1E3,'b--');
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('US HouseHolds-Millions','FontWeight','bold','FontSize',12,'FontWeight','bold');
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    minval=0;
    maxval=200;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('US Households','Mean','Median','Location','northeast','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanHHVal=mean(InputTT.Households,'omitnan')/1E3;
    medianHHVal=median(InputTT.Households,'omitnan')/1E3;
  elseif(itype==80)
    plot(InputTT.Date,InputTT.POP55/1E3,'g',...
        InputTT.Date,InputTT.meanP55/1E3,'r--',...
        InputTT.Date,InputTT.medianP55/1E3,'b--');
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('USD Pop over 55-Millions','FontWeight','bold','FontSize',12,'FontWeight','bold');
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    minval=0;
    maxval=150;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('US Households','Mean','Median','Location','northeast','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanP55Val=mean(InputTT.POP55,'omitnan')/1E3;
    medianP55Val=median(InputTT.POP55,'omitnan')/1E3;
  elseif(itype==81)
    plot(InputTT.Date,InputTT.Pop/1E3,'g',...
        InputTT.Date,InputTT.meanP2554/1E3,'r--',...
        InputTT.Date,InputTT.medianP2554/1E3,'b--');
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('USD Pop Between 25 and 54-in Millions','FontWeight','bold','FontSize',12,'FontWeight','bold');
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    minval=0;
    maxval=200;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('POP 25-54','Mean','Median','Location','northeast','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanP2554Val=mean(InputTT.Pop,'omitnan')/1E3;
    medianP2554Val=median(InputTT.Pop,'omitnan')/1E3;
  elseif(itype==82)
    plot(InputTT.Date,InputTT.Children/1E3,'g',...
        InputTT.Date,InputTT.meanChild/1E3,'r--',...
        InputTT.Date,InputTT.medianChild/1E3,'b--');
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('US Families Living W Children','FontWeight','bold','FontSize',12,'FontWeight','bold');
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    minval=0;
    maxval=50;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Families wChild','Mean','Median','Location','northeast','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanChildVal=mean(InputTT.Children,'omitnan')/1E3;
    medianChildVal=median(InputTT.Children,'omitnan')/1E3;
  elseif(itype==83)
    plot(InputTT.Date,InputTT.BlackPop/1E3,'g',...
        InputTT.Date,InputTT.meanBlack/1E3,'r--',...
        InputTT.Date,InputTT.medianBlack/1E3,'b--');
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Black Population In Millions','FontWeight','bold','FontSize',12,'FontWeight','bold');
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    minval=0;
    maxval=80;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('BlackPop','Mean','Median','Location','northeast','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanBlackVal=mean(InputTT.BlackPop,'omitnan')/1E3;
    medianBlackVal=median(InputTT.BlackPop,'omitnan')/1E3;
 elseif(itype==84)
    plot(InputTT.Date,InputTT.WhitePop/1E3,'g',...
        InputTT.Date,InputTT.meanWhite/1E3,'r--',...
        InputTT.Date,InputTT.medianWhite/1E3,'b--');
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('White Population In Millions','FontWeight','bold','FontSize',12,'FontWeight','bold');
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    minval=0;
    maxval=220;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('WhitePop','Mean','Median','Location','northeast','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanWhiteVal=mean(InputTT.WhitePop,'omitnan')/1E3;
    medianWhiteVal=median(InputTT.WhitePop,'omitnan')/1E3;
 elseif(itype==85)
    plot(InputTT.Date,InputTT.HispanicPop/1E3,'g',...
        InputTT.Date,InputTT.meanHisp/1E3,'r--',...
        InputTT.Date,InputTT.medianHisp/1E3,'b--');
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Hispanic Population In Millions','FontWeight','bold','FontSize',12,'FontWeight','bold');
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    minval=0;
    maxval=60;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('HispPop','Mean','Median','Location','northeast','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanHispVal=mean(InputTT.HispanicPop,'omitnan')/1E3;
    medianHispVal=median(InputTT.HispanicPop,'omitnan')/1E3;
 elseif(itype==86)
    plot(InputTT.Date,InputTT.Ratio,'g',...
        InputTT.Date,InputTT.meanFeRatio,'r--',...
        InputTT.Date,InputTT.medianFeRatio,'b--',...
        InputTT.Date,InputTT.femsmooth,'y--');
    if(ishowrecession==1)
        hold on
        barval=FRObj.barval;
        bar(InputTT.Date,barval*InputTT.RevFlag,'b','LineWidth',1);
        hold off
    end
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Female Employment Ratio','FontWeight','bold','FontSize',12,'FontWeight','bold');
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    minval=0;
    maxval=100;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Female Employment Ratio','Mean','Median','Smoothed','Location','northeast','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanFERatioVal=mean(InputTT.Ratio,'omitnan');
    medianFERatioVal=median(InputTT.Ratio,'omitnan');
 elseif(itype==87)
    plot(InputTT.Date,InputTT.VXNCLS,'g',...
        InputTT.Date,InputTT.meanVola,'r--',...
        InputTT.Date,InputTT.medianVola,'b--',...
        InputTT.Date,InputTT.volsmooth,'y--');
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('CBOE Nasdaq Volatility Ratio','FontWeight','bold','FontSize',12,'FontWeight','bold');
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    minval=0;
    maxval=100;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Volatility','Mean','Median','Smoothed','Location','northeast','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanVolaVal=mean(InputTT.VXNCLS,'omitnan');
    medianVolaVal=median(InputTT.VXNCLS,'omitnan');
 elseif(itype==88)
    plot(InputTT.Date,InputTT.USSLIND,'g',...
        InputTT.Date,InputTT.meanLeading,'r--',...
        InputTT.Date,InputTT.medianLeading,'b--');
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('USA Leading Indicators','FontWeight','bold','FontSize',12,'FontWeight','bold');
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    minval=-4;
    maxval=4;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Leading Indicators','Mean','Median','Location','northeast','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanLeadingVal=mean(InputTT.USSLIND,'omitnan');
    medianLeadingVal=median(InputTT.USSLIND,'omitnan');
elseif(itype==89)
    plot(InputTT.Date,InputTT.Yield,'g',...
        InputTT.Date,InputTT.meanYield3Months,'r--',...
        InputTT.Date,InputTT.medianYield3Months,'b--',...
        InputTT.Date,InputTT.m3smooth,'y');
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Three Month Fed Bond Yields','FontWeight','bold','FontSize',12,'FontWeight','bold');
    minval=0;
    maxval=20;
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Fed 3 Month Bond Yield','Mean Yield','Median Yield','Smoothed','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    mean3MonthBondYieldVal=mean(InputTT.Yield);
    median3MonthBondYieldVal=median(InputTT.Yield);
elseif(itype==90)
    plot(InputTT.Date,InputTT.TDSP,'g',...
        InputTT.Date,InputTT.meanTDSP,'r--',...
        InputTT.Date,InputTT.medianTDSP,'b--',...
        InputTT.Date,InputTT.hdsmooth,'y--');
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('HouseHold Debt Service % wrt Disposable Income','FontWeight','bold','FontSize',12,'FontWeight','bold');
    minval=8;
    maxval=18;
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Household Debt Service','Mean Yield','Median Yield','Smoothed','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanTDSPVal=mean(InputTT.TDSP);
    medianTDSPVal=median(InputTT.TDSP);
  elseif(itype==91)
    plot(InputTT.Date,InputTT.CDSP,'g',...
        InputTT.Date,InputTT.meanCDSP,'r--',...
        InputTT.Date,InputTT.medianCDSP,'b--',...
        InputTT.Date,InputTT.cdsmooth,'y--');
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Consumer Debt Service % wrt Disposable Income','FontWeight','bold','FontSize',12,'FontWeight','bold');
    minval=2;
    maxval=8;
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Household Debt Service','Mean Yield','Median Yield','Smoothed','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanCDSPVal=mean(InputTT.CDSP);
    medianCDSPVal=median(InputTT.CDSP);
 elseif(itype==92)
    plot(InputTT.Date,InputTT.DIncome/1000,'g',...
        InputTT.Date,InputTT.meanRDInc/1000,'r--',...
        InputTT.Date,InputTT.medianRDInc/1000,'b--',...
        InputTT.Date,InputTT.dincsmooth/1000,'y--');
    if(ishowrecession==1)
        hold on
        barval=FRObj.barval;
        bar(InputTT.Date,barval*InputTT.RevFlag,'b','LineWidth',1);
        hold off
    end 
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Real Disposible Income Trillion USD','FontWeight','bold','FontSize',12,'FontWeight','bold');
    minval=0;
    maxval=30;
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Disp Income','Mean Yield','Median Yield','Smoothed','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanRDIncVal=mean(InputTT.DIncome)/1000;
    medianRDIncVal=median(InputTT.DIncome)/1000;
 elseif(itype==93)
    plot(InputTT.Date,InputTT.PCE/1000,'g',...
        InputTT.Date,InputTT.meanPCE/1000,'r--',...
        InputTT.Date,InputTT.medianPCE/1000,'b--',...
        InputTT.Date,InputTT.pcesmooth/1000,'y--');
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Personal Consumption Trillion USD','FontWeight','bold','FontSize',12,'FontWeight','bold');
    minval=0;
    maxval=30;
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Consumption','Mean Yield','Median Yield','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanPCEVal=mean(InputTT.PCE)/1000;
    medianPCEVal=median(InputTT.PCE)/1000;
    ab=1;
 elseif(itype==94)
    plot(InputTT.Date,InputTT.Sales,'g',...
        InputTT.Date,InputTT.meanSales,'r--',...
        InputTT.Date,InputTT.medianSales,'b--',...
        InputTT.Date,InputTT.autosmooth,'y--');
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Domestic Auto Sales Millions of Cars','FontWeight','bold','FontSize',12,'FontWeight','bold');
    minval=0;
    maxval=30;
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    set(gca,'YLim',[0 15]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Sales','Mean ','Median','Smoothed','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanSalesVal=mean(InputTT.Sales);
    medianSalesVal=median(InputTT.Sales);
elseif(itype==95)
    plot(InputTT.Date,InputTT.PriceIndex,'g',...
        InputTT.Date,InputTT.meanPrice,'r--',...
        InputTT.Date,InputTT.medianPrice,'b--',...
        InputTT.Date,InputTT.transmooth,'y--');
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('All House Price Index','FontWeight','bold','FontSize',12,'FontWeight','bold');
    minval=0;
    maxval=1000;
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    set(gca,'YLim',[0 1000]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('PriceIndex','Mean ','Median','Smoothed','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanPriceVal=mean(InputTT.PriceIndex);
    medianPriceVal=median(InputTT.PriceIndex);
elseif(itype==96)
    plot(InputTT.Date,InputTT.Balance,'g',...
        InputTT.Date,InputTT.meanBalance,'r--',...
        InputTT.Date,InputTT.medianBalance,'b--',...
        InputTT.Date,InputTT.creditsmooth,'y--');
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Credit Card Balances-Billions USD','FontWeight','bold','FontSize',12,'FontWeight','bold');
    minval=0;
    maxval=1000;
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Credit Card','Mean ','Median','Smoothed','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanBalanceVal=mean(InputTT.Balance);
    medianBalanceVal=median(InputTT.Balance);
elseif(itype==97)
    plot(InputTT.Date,InputTT.Sum,'g',...
        InputTT.Date,InputTT.meanSum,'r--',...
        InputTT.Date,InputTT.medianSum,'b--', ...
        InputTT.Date,InputTT.loansmooth,'y--');
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('New Mortgage Origination Sum Billions USD','FontWeight','bold','FontSize',12,'FontWeight','bold');
    minval=0;
    maxval=250;
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Loan Sum','Mean ','Median','Smoothed','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanSumVal=mean(InputTT.Sum);
    medianSumVal=median(InputTT.Sum);
elseif(itype==98)
    plot(InputTT.Date,InputTT.PastDue,'g',...
        InputTT.Date,InputTT.meanPastDue,'r--',...
        InputTT.Date,InputTT.medianPastDue,'b--');
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Mortgages Past Due 10 Days In Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    minval=0;
    maxval=20;
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    minval=0;
    maxval=20;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Past Due Loans','Mean ','Median','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanPastDueVal=mean(InputTT.PastDue);
    medianPastDueVal=median(InputTT.PastDue);
elseif(itype==99)
    plot(InputTT.Date,InputTT.Score,'g',...
        InputTT.Date,InputTT.meanScore,'r--',...
        InputTT.Date,InputTT.medianScore,'b--');
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Credit Score 50th Ptile','FontWeight','bold','FontSize',12,'FontWeight','bold');
    minval=750;
    maxval=770;
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Credit Score','Mean ','Median','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanScoreVal=mean(InputTT.Score);
    medianScoreVal=median(InputTT.Score);
elseif(itype==100)
    plot(InputTT.Date,InputTT.Assets/1000,'g',...
        InputTT.Date,InputTT.meanEquity/1000,'r--',...
        InputTT.Date,InputTT.medianEquity/1000,'b--',...
        InputTT.Date,InputTT.homesmooth/1000,'y--');
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Home Equity Loans Billions USD','FontWeight','bold','FontSize',12,'FontWeight','bold');
    minval=0;
    maxval=700;
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Home Equity Loans','Mean ','Median','Smoothed','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanEquityVal=mean(InputTT.Assets/1000);
    medianEquityVal=median(InputTT.Assets/1000);
elseif(itype==101)
    plot(InputTT.Date,InputTT.DEXUSUK,'g',...
        InputTT.Date,InputTT.meanUSD,'r--',...
        InputTT.Date,InputTT.medianUSD,'b--',...
        InputTT.Date,InputTT.conv1smooth,'y--');
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('USD Per Pound Sterling','FontWeight','bold','FontSize',12,'FontWeight','bold');
    minval=0;
    maxval=3;
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('USDToSterling','Mean ','Median','Smoothed','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanconv1Val=mean(InputTT.conv1smooth);
    medianconv1Val=median(InputTT.conv1smooth);
elseif(itype==102)
    plot(InputTT.Date,InputTT.DTWEXBGS,'g',...
        InputTT.Date,InputTT.meanUSD,'r--',...
        InputTT.Date,InputTT.medianUSD,'b--',...
        InputTT.Date,InputTT.conv2smooth,'y--');
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('USD Rate Vs Broad Currency Index','FontWeight','bold','FontSize',12,'FontWeight','bold');
    minval=80;
    maxval=150;
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('USDToBroadCurrency','Mean ','Median','Smoothed','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanconv2Val=mean(InputTT.conv2smooth);
    medianconv2Val=median(InputTT.conv2smooth);
elseif(itype==103)
    plot(InputTT.Date,InputTT.DEXJPUS,'g',...
        InputTT.Date,InputTT.meanUSD,'r--',...
        InputTT.Date,InputTT.medianUSD,'b--',...
        InputTT.Date,InputTT.conv3smooth,'y--');
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Japanese Yen To USD','FontWeight','bold','FontSize',12,'FontWeight','bold');
    minval=40;
    maxval=400;
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('USDToBroadCurrency','Mean','Median','Smoothed','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanconv3Val=mean(InputTT.conv3smooth);
    medianconv3Val=median(InputTT.conv3smooth);
elseif(itype==104)
    plot(InputTT.Date,InputTT.DDDM01USA156NWDB,'g',...
        InputTT.Date,InputTT.meanCap,'r--',...
        InputTT.Date,InputTT.medianCap,'b--',...
        InputTT.Date,InputTT.capsmooth,'y--');
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Stock Mkt Cap to GDP %','FontWeight','bold','FontSize',12,'FontWeight','bold');
    minval=20;
    maxval=200;
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('StocmMktCapitilization','Mean','Median','Smoothed','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meancapVal=mean(InputTT.capsmooth);
    mediancapVal=median(InputTT.capsmooth);
elseif(itype==105)
    plot(InputTT.Date,InputTT.CPALTT01USM657N,'g',...
        InputTT.Date,InputTT.meanCPI,'r--',...
        InputTT.Date,InputTT.medianCPI,'b--',...
        InputTT.Date,InputTT.cpiallsmooth,'y--');
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('CPI All Growth Rate %','FontWeight','bold','FontSize',12,'FontWeight','bold');
    minval=-2;
    maxval=2;
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('CPIALL','Mean','Median','Smoothed','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meangrowthVal=mean(InputTT.cpiallsmooth);
    mediangrowthVal=median(InputTT.cpiallsmooth);
elseif(itype==106)
    plot(InputTT.Date,InputTT.MKTGNIUSA646NWDB/1E12,'g',...
        InputTT.Date,InputTT.meanUSD/1E12,'r--',...
        InputTT.Date,InputTT.medianUSD/1E12,'b--',...
        InputTT.Date,InputTT.gnatincsmooth/1E12,'y--');
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Gross National Income Trillions USD','FontWeight','bold','FontSize',12,'FontWeight','bold');
    minval=0;
    maxval=32;
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('GNI','Mean','Median','Smoothed','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanNatIncomeVal=mean(InputTT.gnatincsmooth/1E9);
    medianNatIncomeVal=median(InputTT.gnatincsmooth/1E9);
elseif(itype==107)
    plot(InputTT.Date,InputTT.GASREGW,'g',...
        InputTT.Date,InputTT.meanRegGas,'r--',...
        InputTT.Date,InputTT.medianRegGas,'b--',...
        InputTT.Date,InputTT.gasregsmooth,'y--');
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Regular Gas Price Per Gallon USD','FontWeight','bold','FontSize',12,'FontWeight','bold');
    minval=0;
    maxval=6;
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('GasPrice','Mean','Median','Smoothed','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meangaspriceVal=mean(InputTT.gasregsmooth);
    mediangaspriceVal=median(InputTT.gasregsmooth);
elseif(itype==108)
    plot(InputTT.Date,InputTT.DCOILBRENTEU,'g',...
        InputTT.Date,InputTT.meanBrentOil,'r--',...
        InputTT.Date,InputTT.medianBrentOil,'b--',...
        InputTT.Date,InputTT.brentsmooth,'y--');
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Brent Oil Cost USD','FontWeight','bold','FontSize',12,'FontWeight','bold');
    minval=0;
    maxval=150;
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Brent Price','Mean','Median','Smoothed','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanBrentPriceVal=mean(InputTT.brentsmooth);
    medianBrentPriceVal=median(InputTT.brentsmooth);
elseif(itype==109)
    plot(InputTT.Date,InputTT.Prices,'g',...
        InputTT.Date,InputTT.meanEggPrices,'r--',...
        InputTT.Date,InputTT.medianEggPrices,'b--',...
        InputTT.Date,InputTT.eggsmooth,'y--');
    if(ishowrecession==1)
        hold on
        barval=FRObj.barval;
        bar(InputTT.Date,barval*InputTT.RevFlag,'b','LineWidth',1);
        hold off
    end
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Grade A Egg Price Per Dozen USD','FontWeight','bold','FontSize',12,'FontWeight','bold');
    minval=0;
    maxval=7;
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Egg Price','Mean','Median','Smoothed','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanEggPriceVal=mean(InputTT.eggsmooth);
    medianEggPriceVal=median(InputTT.eggsmooth);
elseif(itype==110)
    plot(InputTT.Date,InputTT.Price,'g',...
        InputTT.Date,InputTT.meanGroundBeefPrices,'r--',...
        InputTT.Date,InputTT.medianGroundBeefPrices,'b--',...
        InputTT.Date,InputTT.beefsmooth,'y--');
    if(ishowrecession==1)
        hold on
        barval=FRObj.barval;
        bar(InputTT.Date,barval*InputTT.RevFlag,'b','LineWidth',1);
        hold off
    end
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('GroundBeefPrice per pound USD','FontWeight','bold','FontSize',12,'FontWeight','bold');
    minval=0;
    maxval=7;
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Beef Price','Mean','Median','Smoothed','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanGroundBeefPriceVal=mean(InputTT.beefsmooth);
    medianGroundBeefPriceVal=median(InputTT.beefsmooth);
elseif(itype==111)
    plot(InputTT.Date,InputTT.Price,'g',...
        InputTT.Date,InputTT.meanElectrcityPrices,'r--',...
        InputTT.Date,InputTT.medianElectricityPrices,'b--',...
        InputTT.Date,InputTT.elecsmooth,'y--');
    if(ishowrecession==1)
        hold on
        barval=FRObj.barval;
        bar(InputTT.Date,barval*InputTT.RevFlag,'b','LineWidth',1);
        hold off
    end

    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Electricity Price/KwHr in USD','FontWeight','bold','FontSize',12,'FontWeight','bold');
    minval=0;
    maxval=.25;
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Electricity Price','Mean','Median','Smoothed','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanElectricityPriceVal=mean(InputTT.elecsmooth);
    medianElectricityPriceVal=median(InputTT.elecsmooth);
elseif(itype==112)
    plot(InputTT.Date,InputTT.Price,'g',...
        InputTT.Date,InputTT.meanWTIPrices,'r--',...
        InputTT.Date,InputTT.medianWTIPrices,'b--',...
        InputTT.Date,InputTT.wtismooth,'y--');
     if(ishowrecession==1)
        hold on
        barval=FRObj.barval;
        bar(InputTT.Date,barval*InputTT.RevFlag,'b','LineWidth',1);
        hold off
     end
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('WTI Crude Price Per Barrel in USD','FontWeight','bold','FontSize',12,'FontWeight','bold');
    minval=0;
    maxval=150;
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('WTI Price','Mean','Median','Smoothed','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanWTIPriceVal=mean(InputTT.wtismooth);
    medianWTIPriceVal=median(InputTT.wtismooth);
 elseif(itype==113)
    plot(InputTT.Date,InputTT.Price,'g',...
        InputTT.Date,InputTT.meanNatGasPrices,'r--',...
        InputTT.Date,InputTT.medianNatGasPrices,'b--',...
        InputTT.Date,InputTT.natgassmooth,'y--');
     % if(ishowrecession==1)
     %    hold on
     %    barval=FRObj.barval;
     %    bar(InputTT.Date,barval*InputTT.RevFlag,'b','LineWidth',1);
     %    hold off
     % end
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('HenryHubNaturalGas Prices-USD/Million BTU','FontWeight','bold','FontSize',12,'FontWeight','bold');
    minval=0;
    maxval=20;
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('NatGasPrice','Mean','Median','Smoothed','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanNatGasPriceVal=mean(InputTT.natgassmooth);
    medianNatGasPriceVal=median(InputTT.natgassmooth);
elseif(itype==114)
    plot(InputTT.Date,InputTT.Price/1000,'g',...
        InputTT.Date,InputTT.meanCopper/1000,'r--',...
        InputTT.Date,InputTT.medianCopper/1000,'b--',...
        InputTT.Date,InputTT.coppersmooth/1000,'y--');
     if(ishowrecession==1)
        hold on
        barval=FRObj.barval;
        bar(InputTT.Date,barval*InputTT.RevFlag,'b','LineWidth',1);
        hold off
     end
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Copper Price-ThousandUSD/Metric Ton','FontWeight','bold','FontSize',12,'FontWeight','bold');
    minval=0;
    maxval=15;
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('NatGasPrice','Mean','Median','Smoothed','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanCopperVal=mean(InputTT.coppersmooth)/1000;
    medianCopperVal=median(InputTT.coppersmooth)/1000;
elseif(itype==115)
    plot(InputTT.Date,InputTT.Price,'g',...
        InputTT.Date,InputTT.meanDiesel,'r--',...
        InputTT.Date,InputTT.medianDiesel,'b--',...
        InputTT.Date,InputTT.dieselsmooth,'y--');
     if(ishowrecession==1)
        hold on
        barval=FRObj.barval;
        bar(InputTT.Date,barval*InputTT.RevFlag,'b','LineWidth',1);
        hold off
     end
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Diesel Price-USD/Gallon','FontWeight','bold','FontSize',12,'FontWeight','bold');
    minval=0;
    maxval=8;
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('DieselPrice','Mean','Median','Smoothed','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanDieselVal=mean(InputTT.dieselsmooth);
    medianDieselVal=median(InputTT.dieselsmooth);
elseif(itype==116)
    plot(InputTT.Date,InputTT.Price,'g',...
        InputTT.Date,InputTT.meanJet,'r--',...
        InputTT.Date,InputTT.medianJet,'b--',...
        InputTT.Date,InputTT.jetsmooth,'y--');
     if(ishowrecession==1)
        hold on
        barval=FRObj.barval;
        bar(InputTT.Date,barval*InputTT.RevFlag,'b','LineWidth',1);
        hold off
     end
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Jet Fuel Price-USD/Gallon','FontWeight','bold','FontSize',12,'FontWeight','bold');
    minval=0;
    maxval=5;
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('JetFuelPrice','Mean','Median','Smoothed','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanJetVal=mean(InputTT.jetsmooth);
    medianJetVal=median(InputTT.jetsmooth);
elseif(itype==117)
    plot(InputTT.Date,InputTT.Price/1000,'g',...
        InputTT.Date,InputTT.meanAluminum/1000,'r--',...
        InputTT.Date,InputTT.medianAluminum/1000,'b--',...
        InputTT.Date,InputTT.alsmooth/1000,'y--');
     if(ishowrecession==1)
        hold on
        barval=FRObj.barval;
        bar(InputTT.Date,barval*InputTT.RevFlag,'b','LineWidth',1);
        hold off
     end

    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Aluminum-Thousand USD/Metric Ton','FontWeight','bold','FontSize',12,'FontWeight','bold');
    minval=0;
    maxval=5;
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Aluminum Price','Mean','Median','Smoothed','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanAlumVal=mean(InputTT.alsmooth)/1000;
    medianAlumVal=median(InputTT.alsmooth)/1000;
elseif(itype==118)
    plot(InputTT.Date,InputTT.Price/1000,'g',...
        InputTT.Date,InputTT.meanCocoa/1000,'r--',...
        InputTT.Date,InputTT.medianCocoa/1000,'b--',...
        InputTT.Date,InputTT.cocoasmooth/1000,'y--');
    if (ishowrecession==1)
        hold on
        barval=FRObj.barval;
        bar(InputTT.Date,barval*InputTT.RevFlag,'b','LineWidth',1);
        hold off
    end
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Cocoa-Thousand USD/Metric Ton','FontWeight','bold','FontSize',12,'FontWeight','bold');
    minval=0;
    maxval=12;
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Cocoa Price','Mean','Median','Smoothed','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanCocoaVal=mean(InputTT.cocoasmooth)/1000;
    medianCocoaVal=median(InputTT.cocoasmooth)/1000;
elseif(itype==119)
    plot(InputTT.Date,InputTT.Price,'g',...
        InputTT.Date,InputTT.meanGlobalEnergy,'r--',...
        InputTT.Date,InputTT.medianGlobalEnergy,'b--',...
        InputTT.Date,InputTT.energysmooth,'y--');
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Global Energy Index','FontWeight','bold','FontSize',12,'FontWeight','bold');
    minval=0;
    maxval=400;
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Energy Index','Mean','Median','Smoothed','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanEnergyIndexVal=mean(InputTT.energysmooth);
    medianEnergyIndexVal=median(InputTT.energysmooth);
elseif(itype==120)
    plot(InputTT.Date,InputTT.Price,'g',...
        InputTT.Date,InputTT.meanBreadPrice,'r--',...
        InputTT.Date,InputTT.medianBreadPrice,'b--',...
        InputTT.Date,InputTT.breadsmooth,'y--');
    if (ishowrecession==1)
        hold on
        barval=FRObj.barval;
        bar(InputTT.Date,barval*InputTT.RevFlag,'b','LineWidth',1);
        hold off
    end
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Bread Price','FontWeight','bold','FontSize',12,'FontWeight','bold');
    minval=0;
    maxval=3;
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Bread Price','Mean','Median','Smoothed','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanBreadVal=mean(InputTT.breadsmooth);
    medianBreadVal=median(InputTT.breadsmooth);
elseif(itype==121)
    plot(InputTT.Date,InputTT.Price,'g',...
        InputTT.Date,InputTT.meanWheatPrice,'r--',...
        InputTT.Date,InputTT.medianWheatPrice,'b--',...
        InputTT.Date,InputTT.wheatsmooth,'y--');
     if (ishowrecession==1)
        hold on
        barval=FRObj.barval;
        bar(InputTT.Date,barval*InputTT.RevFlag,'b','LineWidth',1);
        hold off
    end
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Wheat Price-USD/Metric Ton','FontWeight','bold','FontSize',12,'FontWeight','bold');
    minval=0;
    maxval=500;
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Wheat Price','Mean','Median','Smoothed','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanWheatVal=mean(InputTT.wheatsmooth);
    medianWheatVal=median(InputTT.wheatsmooth);
elseif(itype==122)
    plot(InputTT.Date,InputTT.Price,'g',...
        InputTT.Date,InputTT.meanUraniumPrice,'r--',...
        InputTT.Date,InputTT.medianUraniumPrice,'b--',...
        InputTT.Date,InputTT.uransmooth,'y--');
    if (ishowrecession==1)
        hold on
        barval=FRObj.barval;
        bar(InputTT.Date,barval*InputTT.RevFlag,'b','LineWidth',1);
        hold off
    end
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Uranium Price-USD/lb','FontWeight','bold','FontSize',12,'FontWeight','bold');
    minval=0;
    maxval=150;
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Uranium Price','Mean','Median','Smoothed','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanU2Val=mean(InputTT.uransmooth);
    medianU2Val=median(InputTT.uransmooth);
elseif(itype==123)
    plot(InputTT.Date,InputTT.Price/1000,'g',...
        InputTT.Date,InputTT.meanNickelPrice/1000,'r--',...
        InputTT.Date,InputTT.medianNickelPrice/1000,'b--',...
        InputTT.Date,InputTT.nicksmooth/1000,'y--');
    if (ishowrecession==1)
        hold on
        barval=FRObj.barval;
        bar(InputTT.Date,barval*InputTT.RevFlag,'b','LineWidth',1);
        hold off
    end
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Nickel Price-kUSD/Ton','FontWeight','bold','FontSize',12,'FontWeight','bold');
    minval=0;
    maxval=60;
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Nickel Price','Mean','Median','Smoothed','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanNickelVal=mean(InputTT.nicksmooth)/1000;
    medianNickelVal=median(InputTT.nicksmooth)/1000;
elseif(itype==124)
    plot(InputTT.Date,InputTT.Price/100,'g',...
        InputTT.Date,InputTT.meanRubberPrice/100,'r--',...
        InputTT.Date,InputTT.medianRubberPrice/100,'b--',...
        InputTT.Date,InputTT.rubbersmooth/100,'y--');
    if (ishowrecession==1)
        hold on
        barval=FRObj.barval;
        bar(InputTT.Date,barval*InputTT.RevFlag,'b','LineWidth',1);
        hold off
    end
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Rubber Price-USD/lb','FontWeight','bold','FontSize',12,'FontWeight','bold');
    minval=0;
    maxval=4;
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Rubber Price','Mean','Median','Smoothed','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanRubberVal=mean(InputTT.rubbersmooth)/100;
    medianRubberVal=median(InputTT.rubbersmooth)/100;
elseif(itype==125)
    plot(InputTT.Date,InputTT.Price/100,'g',...
        InputTT.Date,InputTT.meanSugarPrice/100,'r--',...
        InputTT.Date,InputTT.medianSugarPrice/100,'b--',...
        InputTT.Date,InputTT.sugarsmooth/100,'y--');
    if (ishowrecession==1)
        hold on
        barval=FRObj.barval;
        bar(InputTT.Date,barval*InputTT.RevFlag,'b','LineWidth',1);
        hold off
    end

    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Sugar Price-USD/lb','FontWeight','bold','FontSize',12,'FontWeight','bold');
    minval=0;
    maxval=1;
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Sugar Price','Mean','Median','Smoothed','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanSugarVal=mean(InputTT.sugarsmooth)/100;
    medianSugarVal=median(InputTT.sugarsmooth)/100;
elseif(itype==126)
    plot(InputTT.Date,InputTT.Index,'g',...
        InputTT.Date,InputTT.meanHF,'r--',...
        InputTT.Date,InputTT.medianHF,'b--',...
        InputTT.Date,InputTT.urbanhfsmooth,'y--');
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('UrbanHomeFoodPriceIndex','FontWeight','bold','FontSize',12,'FontWeight','bold');
    minval=0;
    maxval=360;
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Home Food Index','Mean','Median','Smoothed','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanFoodVal=mean(InputTT.urbanhfsmooth);
    medianFoodVal=median(InputTT.urbanhfsmooth);
elseif(itype==127)
    plot(InputTT.Date,InputTT.Index,'g',...
        InputTT.Date,InputTT.meanPPIFood,'r--',...
        InputTT.Date,InputTT.medianPPIFood,'b--',...
        InputTT.Date,InputTT.ppifoodsmooth,'y--');
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('PCI FoodPriceIndex','FontWeight','bold','FontSize',12,'FontWeight','bold');
    minval=80;
    maxval=300;
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('PPI Food Index','Mean','Median','Smoothed','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanPPIFoodVal=mean(InputTT.ppifoodsmooth);
    medianPPIFoodVal=median(InputTT.ppifoodsmooth);
 elseif(itype==128)
        plot(InputTT.Date,InputTT.Index,'g',...
        InputTT.Date,InputTT.meanPPIDiesel,'r--',...
        InputTT.Date,InputTT.medianPPIDiesel,'b--',...
        InputTT.Date,InputTT.ppidieselsmooth,'y--');
        ishowrecession=1;
    if(ishowrecession==1)
        hold on
        barval=FRObj.barval;
        bar(InputTT.Date,barval*InputTT.RevFlag,'b','LineWidth',1);
        hold off
    end
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('PCI DieselPriceIndex wrt 1982','FontWeight','bold','FontSize',12,'FontWeight','bold');
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    minval=0;
    maxval=700;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('PPI Diesel Index','Mean','Median','Smoothed','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanPPIDieselVal=mean(InputTT.ppidieselsmooth);
    medianPPIDieselVal=median(InputTT.ppidieselsmooth);
 elseif(itype==129)
    plot(InputTT.Date,InputTT.Price,'g',...
        InputTT.Date,InputTT.meanBologna,'r--',...
        InputTT.Date,InputTT.medianBologna,'b--',...
        InputTT.Date,InputTT.bolognasmooth,'y--');
    ishowrecession=1;
    if(ishowrecession==1)
        hold on
        barval=FRObj.barval;
        bar(InputTT.Date,barval*InputTT.RevFlag,'b','LineWidth',1);
        hold off
    end
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Beef Bologna Prices USD per pound','FontWeight','bold','FontSize',12,'FontWeight','bold');
    minval=0;
    maxval=4;
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Bologna Price','Mean','Median','Smoothed','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanBolognaVal=mean(InputTT.bolognasmooth);
    medianBolognaVal=median(InputTT.bolognasmooth);
 elseif(itype==130)
    plot(InputTT.Date,InputTT.Price,'g',...
        InputTT.Date,InputTT.meanHam,'r--',...
        InputTT.Date,InputTT.medianHam,'b--',...
        InputTT.Date,InputTT.hamsmooth,'y--');
        ishowrecession=1;
    if(ishowrecession==1)
        hold on
        barval=FRObj.barval;
        bar(InputTT.Date,barval*InputTT.RevFlag,'b','LineWidth',1);
        hold off
    end
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Boneless Ham Prices USD per pound','FontWeight','bold','FontSize',12,'FontWeight','bold');
    minval=2;
    maxval=6;
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Boneless Ham Price','Mean','Median','Smoothed','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanHamVal=mean(InputTT.hamsmooth);
    medianHamVal=median(InputTT.hamsmooth);
 elseif(itype==131)
    plot(InputTT.Date,InputTT.Price,'g',...
        InputTT.Date,InputTT.meanCRoast,'r--',...
        InputTT.Date,InputTT.medianCRoast,'b--',...
        InputTT.Date,InputTT.croastsmooth,'y--');
    ishowrecession=1;
    if(ishowrecession==1)
        hold on
        barval=FRObj.barval;
        bar(InputTT.Date,barval*InputTT.RevFlag,'b','LineWidth',1);
        hold off
    end
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Boneless Chuck Roast Price USD per pound','FontWeight','bold','FontSize',12,'FontWeight','bold');
    minval=0;
    maxval=10;
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Boneless Ham Price','Mean','Median','Smoothed','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanCroastVal=mean(InputTT.croastsmooth);
    medianCroastVal=median(InputTT.croastsmooth);
 elseif(itype==132)
    plot(InputTT.Date,InputTT.Price,'g',...
        InputTT.Date,InputTT.meanBacon,'r--',...
        InputTT.Date,InputTT.medianBacon,'b--',...
        InputTT.Date,InputTT.baconsmooth,'y--');
    ishowrecession=1;
    if(ishowrecession==1)
        hold on
        barval=FRObj.barval;
        bar(InputTT.Date,barval*InputTT.RevFlag,'b','LineWidth',1);
        hold off
    end
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Bacon Price USD per pound','FontWeight','bold','FontSize',12,'FontWeight','bold');
    minval=0;
    maxval=10;
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Bacon Price','Mean','Median','Smoothed','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanBaconVal=mean(InputTT.baconsmooth);
    medianBaconVal=median(InputTT.baconsmooth);
 elseif(itype==133)
    plot(InputTT.Date,InputTT.Index,'g',...
        InputTT.Date,InputTT.meanSoybean,'r--',...
        InputTT.Date,InputTT.medianSoybean,'b--',...
        InputTT.Date,InputTT.soysmooth,'y--');
        ishowrecession=1;
    if(ishowrecession==1)
        hold on
        barval=FRObj.barval;
        bar(InputTT.Date,barval*InputTT.RevFlag,'b','LineWidth',1);
        hold off
    end
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Soybean Index wrt 1982','FontWeight','bold','FontSize',12,'FontWeight','bold');
    minval=0;
    maxval=320;
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Soybean Index','Mean','Median','Smoothed','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanSoybeanVal=mean(InputTT.soysmooth);
    medianSoybeanVal=median(InputTT.soysmooth);
 elseif(itype==134)
    plot(InputTT.Date,InputTT.Price,'g',...
        InputTT.Date,InputTT.meanFlourPrice,'r--',...
        InputTT.Date,InputTT.medianFlourPrice,'b--',...
        InputTT.Date,InputTT.floursmooth,'y--');
   if(ishowrecession==1)
        hold on
        barval=FRObj.barval;
        bar(InputTT.Date,barval*InputTT.RevFlag,'b','LineWidth',1);
        hold off
    end
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('FlourPrice-USD/lb','FontWeight','bold','FontSize',12,'FontWeight','bold');
    minval=0;
    maxval=3;
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Flour Price','Mean','Median','Smoothed','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanFlourVal=mean(InputTT.floursmooth);
    medianFlourVal=median(InputTT.floursmooth);
elseif(itype==135)
    plot(InputTT.Date,InputTT.Index,'g',...
        InputTT.Date,InputTT.meanCookingOilIndex,'r--',...
        InputTT.Date,InputTT.medianCookingOilIndex,'b--',...
        InputTT.Date,InputTT.coilsmooth,'y--');
    if(ishowrecession==1)
        hold on
        barval=FRObj.barval;
        bar(InputTT.Date,barval*InputTT.RevFlag,'b','LineWidth',1);
        hold off
    end
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Cooking Oil Index','FontWeight','bold','FontSize',12,'FontWeight','bold');
    minval=0;
    maxval=500;
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Cooking Oil Index','Mean','Median','Smoothed','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanCoilVal=mean(InputTT.coilsmooth);
    medianCoilVal=median(InputTT.coilsmooth);
elseif(itype==136)
    plot(InputTT.Date,InputTT.Price,'g',...
        InputTT.Date,InputTT.meanWChickenPrice,'r--',...
        InputTT.Date,InputTT.medianWChickenPrice,'b--',...
        InputTT.Date,InputTT.chicksmooth,'y--');
    if(ishowrecession==1)
        hold on
        barval=FRObj.barval;
        bar(InputTT.Date,barval*InputTT.RevFlag,'b','LineWidth',1);
        hold off
    end
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Whole Chicken Price-USD/lb','FontWeight','bold','FontSize',12,'FontWeight','bold');
    minval=0;
    maxval=3;
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Chicken Price','Mean','Median','Smoothed','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanWhChickVal=mean(InputTT.chicksmooth);
    medianWhChickVal=median(InputTT.chicksmooth);
 elseif(itype==137)
    plot(InputTT.Date,InputTT.Index,'g',...
        InputTT.Date,InputTT.meanFarmProducts,'r--',...
        InputTT.Date,InputTT.medianFarmProducts,'b--',...
        InputTT.Date,InputTT.farmsmooth,'y--');
    if(ishowrecession==1)
        hold on
        barval=FRObj.barval;
        bar(InputTT.Date,barval*InputTT.RevFlag,'b','LineWidth',1);
        hold off
    end
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('PPI Farm Index','FontWeight','bold','FontSize',12,'FontWeight','bold');
    minval=0;
    maxval=300;
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Farm Index','Mean','Median','Smoothed','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanFarmIndexVal=mean(InputTT.farmsmooth);
    medianFarmIndexVal=median(InputTT.farmsmooth);
 elseif(itype==138)
    plot(InputTT.Date,InputTT.Index,'g',...
        InputTT.Date,InputTT.meanCattle,'r--',...
        InputTT.Date,InputTT.medianCattle,'b--',...
        InputTT.Date,InputTT.cattlesmooth,'y--');
    if(ishowrecession==1)
        hold on
        barval=FRObj.barval;
        bar(InputTT.Date,barval*InputTT.RevFlag,'b','LineWidth',1);
        hold off
    end
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('PPI Cattle Index wrt 1982','FontWeight','bold','FontSize',12,'FontWeight','bold');
    minval=0;
    maxval=450;
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Cattle Index','Mean','Median','Smoothed','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanCattleIndexVal=mean(InputTT.cattlesmooth);
    medianCattleIndexVal=median(InputTT.cattlesmooth);
 elseif(itype==139)
    plot(InputTT.Date,InputTT.Index,'g',...
        InputTT.Date,InputTT.meanTomatoes,'r--',...
        InputTT.Date,InputTT.medianTomatoes,'b--',...
        InputTT.Date,InputTT.tomatoessmooth,'y--');
    if(ishowrecession==1)
        hold on
        barval=FRObj.barval;
        bar(InputTT.Date,barval*InputTT.RevFlag,'b','LineWidth',1);
        hold off
    end
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('PPI Tomatoes wrt 1982','FontWeight','bold','FontSize',12,'FontWeight','bold');
    minval=0;
    maxval=800;
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Tomatoes Index','Mean','Median','Smoothed','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanTomatoesIndexVal=mean(InputTT.tomatoessmooth);
    medianTomatoesIndexVal=median(InputTT.tomatoessmooth);
 elseif(itype==140)
    plot(InputTT.Date,InputTT.Index,'g',...
        InputTT.Date,InputTT.meanCorn,'r--',...
        InputTT.Date,InputTT.medianCorn,'b--',...
        InputTT.Date,InputTT.cornsmooth,'y--');
    if(ishowrecession==1)
        hold on
        barval=FRObj.barval;
        bar(InputTT.Date,barval*InputTT.RevFlag,'b','LineWidth',1);
        hold off
    end
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('PPI Corn wrt 1982','FontWeight','bold','FontSize',12,'FontWeight','bold');
    minval=0;
    maxval=400;
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Corn Index','Mean','Median','Smoothed','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanCornIndexVal=mean(InputTT.cornsmooth);
    medianCornIndexVal=median(InputTT.cornsmooth);
 elseif(itype==141)
    plot(InputTT.Date,InputTT.Index,'g',...
        InputTT.Date,InputTT.meanRawMilk,'r--',...
        InputTT.Date,InputTT.medianRawMilk,'b--',...
        InputTT.Date,InputTT.milksmooth,'y--');
    if(ishowrecession==1)
        hold on
        barval=FRObj.barval;
        bar(InputTT.Date,barval*InputTT.RevFlag,'b','LineWidth',1);
        hold off
    end
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('PPI Raw Milk wrt 1982','FontWeight','bold','FontSize',12,'FontWeight','bold');
    minval=0;
    maxval=250;
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Milk Index','Mean','Median','Smoothed','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanMilkIndexVal=mean(InputTT.milksmooth);
    medianMilkIndexVal=median(InputTT.milksmooth);
 elseif(itype==142)
    plot(InputTT.Date,InputTT.Index,'g',...
        InputTT.Date,InputTT.meanFruits,'r--',...
        InputTT.Date,InputTT.medianFruits,'b--',...
        InputTT.Date,InputTT.fruitsmooth,'y--');
    if(ishowrecession==1)
        hold on
        barval=FRObj.barval;
        bar(InputTT.Date,barval*InputTT.RevFlag,'b','LineWidth',1);
        hold off
    end
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('PPI Fruit wrt 1982','FontWeight','bold','FontSize',12,'FontWeight','bold');
    minval=0;
    maxval=400;
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Fruit Index','Mean','Median','Smoothed','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanFruitIndexVal=mean(InputTT.fruitsmooth);
    medianFruitIndexVal=median(InputTT.fruitsmooth);

 elseif(itype==143)
    plot(InputTT.Date,InputTT.Index,'g',...
        InputTT.Date,InputTT.meanCabbage,'r--',...
        InputTT.Date,InputTT.medianCabbage,'b--',...
        InputTT.Date,InputTT.cabbagesmooth,'y--');
    if(ishowrecession==1)
        hold on
        barval=FRObj.barval;
        bar(InputTT.Date,barval*InputTT.RevFlag,'b','LineWidth',1);
        hold off
    end
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('PPI Cabbage wrt 1982','FontWeight','bold','FontSize',12,'FontWeight','bold');
    minval=0;
    maxval=500;
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Cabbage Index','Mean','Median','Smoothed','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanCabbageIndexVal=mean(InputTT.cabbagesmooth);
    medianCabbageIndexVal=median(InputTT.cabbagesmooth);
 elseif(itype==144)
    plot(InputTT.Date,InputTT.Index,'g',...
        InputTT.Date,InputTT.meanRice,'r--',...
        InputTT.Date,InputTT.medianRice,'b--',...
        InputTT.Date,InputTT.ricesmooth,'y--');
    if(ishowrecession==1)
        hold on
        barval=FRObj.barval;
        bar(InputTT.Date,barval*InputTT.RevFlag,'b','LineWidth',1);
        hold off
    end
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('PPI Rice wrt 2004','FontWeight','bold','FontSize',12,'FontWeight','bold');
    minval=0;
    maxval=300;
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Rice Index','Mean','Median','Smoothed','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanRiceIndexVal=mean(InputTT.ricesmooth);
    medianRiceIndexVal=median(InputTT.ricesmooth);

elseif(itype==145)
    plot(InputTT.Date,InputTT.Index,'g',...
        InputTT.Date,InputTT.meanCitrus,'r--',...
        InputTT.Date,InputTT.medianCitrus,'b--',...
        InputTT.Date,InputTT.citrussmooth,'y--');
    if(ishowrecession==1)
        hold on
        barval=FRObj.barval;
        bar(InputTT.Date,barval*InputTT.RevFlag,'b','LineWidth',1);
        hold off
    end
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('PPI Citrus Fruits wrt 1947','FontWeight','bold','FontSize',12,'FontWeight','bold');
    minval=0;
    maxval=500;
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    hl=legend('Citrus Index','Mean','Median','Smoothed','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanCitrusIndexVal=mean(InputTT.citrussmooth);
    medianCitrusIndexVal=median(InputTT.citrussmooth);
elseif(itype==146)
    bar(InputTT.Date,InputTT.RFlag,'r','LineWidth',1);
    title(titlestr)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Recession Flag','FontWeight','bold','FontSize',12,'FontWeight','bold');
    minval=0;
    maxval=2;
    if(iLogo==1)
        eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
        ha =gca;
        uistack(ha,'bottom');
        haPos = get(ha,'position');
        ha2=axes('position',[haPos(1)+.7,haPos(2)-.10, .15,.06,]);
        [x, ~]=imread(LogoFileName);
        imshow(x);
        set(ha2,'handlevisibility','off','visible','off')
    end
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);

end

% Set up an axis for writing text at the bottom of the chart
newaxesh=axes('Position',[0 0 1 1]);
set(newaxesh,'XLim',[0 1],'YLim',[0 1]);
tx1=.08;
ty1=.05;
tx2=.08;
ty2=.02;
if(itype==1)
    txtstr1='Monthly Unemployment Rate';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Mean Rate %=',num2str(meanUnrate,4),'-Median Rate %= ',num2str(medianUnrate,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==2)
    txtstr1='Monthly CPI Data-excludes food and energy';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Mean CPI Rate %=',num2str(meanSCPI,4),'-Median',num2str(medianSCPI,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==3)
    txtstr1='Labor Force Participation Rate By Age Groups';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Mean Rate All=',num2str(meanPartAll,4),...
        '-Ages 25-54=',num2str(meanPart_25_54,4),...
        '-Ages 55+=',num2str(meanPart_55,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==4)
    txtstr1='Single Family Home Loan Delinquency Rate';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Mean Rate =',num2str(meanDelRate,4),'-Median Rate=',num2str(medianDelRate,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==5)
    txtstr1='Home Ownership Rate';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Mean Ownership Rate =',num2str(meanHomeRate,4),'--%','-Median Rate=',num2str(medianHomeRate,4),'--%');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==6)
    txtstr1='Industrial Production with 2017 baseline';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG6=FRObj.SG6;
    txtstr2=strcat('Mean Production =',num2str(meanProdRate,4),'-Scaled to 2017-Growth Rate-',num2str(SG6));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==7)
    txtstr1='Real Median Family Income in thousands of USD';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG7=FRObj.SG7;
    txtstr2=strcat('Mean Income =',num2str(meanIncome,4),'-USD in thousands','-AnnualGrowthRate=',num2str(SG7),'-in pct');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
 elseif(itype==8)
    txtstr1='CBOE Volitility Index';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Mean Vix Index =',num2str(meanVix,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==9)
    txtstr1='Consumer Confidence';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Mean Consumer Confidence Index =',num2str(meanCC,4),'-Median-',num2str(medianCC,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==10)
    txtstr1='Days On Market For House Sale';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Mean Days  =',num2str(meanDaysOnMarket,4),'-Medians Days',num2str(medianDaysOnMarket,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==11)
    txtstr1='Mean/Median 10 Year Bond Yields %';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Mean Bond Yield =',num2str(mean10YearBondYield,4),...
        '-Median Bond Yield =',num2str(median10YearBondYield,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==12)
    txtstr1='Mean U2 Rate %';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Mean U2 Rate =',num2str(meanU2,4),...
        '-Median U2 Rate=',num2str(medianU2),'- In Pct');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==13)
    txtstr1='Mean Annual GDP Trillion USD reported By Quarter';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG13=FRObj.SG13;
    txtstr2=strcat('Mean GDP =',num2str(meanGDP,4),'-USD in thousands','-AnnualGrowthRate=',num2str(SG13),'-in pct');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==14)
    txtstr1='Annual GDP Per Cap Thousand USD ';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG14=FRObj.SG14;
    txtstr2=strcat('Mean GDPPerCap =',num2str(meanGDPPerCap,4),'-Thousands USD','Median GDPPerCap =',num2str(meanGDPPerCap,4),...
        '-AnnualGrowthRate=',num2str(SG14),'-in pct');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==15)
    txtstr1='Mean/Median 2 Year Bond Yields %';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Mean Bond Yield =',num2str(mean2YearBondYield,4),...
        '-Median Bond Yield =',num2str(median2YearBondYield,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==16)
    txtstr1='Mean/Median Unemployment Claims %';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Mean Initial Claims =',num2str(meanClaims/1E6,6),...
        '-Median Initial Claims =',num2str(medianClaims/1E6,6));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==17)
    txtstr1='Mean/Median Unemployment Claims %';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Mean Continued Claims =',num2str(meanClaims/1E6,4),...
        '-Median Continued Claims =',num2str(medianClaims/1E6,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==18)
    txtstr1='Mean/Median Non Farm Job Openings in thousands';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Mean =',num2str(meanNFJO,5),...
        '-Median =',num2str(medianNFJO,5));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==19)
    txtstr1='Mean/Median Construction Job Openings in thousands';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Mean =',num2str(meanCJ,5),...
        '-Median =',num2str(medianCJ,5));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==20)
    txtstr1='Mean/Median Manufacturing Job Openings in thousands';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Mean =',num2str(meanMFacVal,6),...
        '-Median =',num2str(medianMFacVal,6));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==21)
    txtstr1='Mean/Median Professional Job Openings in thousands';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Mean =',num2str(meanProfOpenVal,6),...
        '-Median =',num2str(medianProfOpenVal,6));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==22)
    txtstr1='Mean/Median Health Care Job Openings in thousands';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Mean =',num2str(meanHCOpenVal,6));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==23)
    txtstr1='Mean/Median Government Job Openings in thousands';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Mean =',num2str(meanGovOpenVal,7),...
        '-Median =',num2str(medianGovOpenVal,7));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==24)
    txtstr1='Mean/Median Personal Income in thousands';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG24=FRObj.SG24;
    txtstr2=strcat('Mean =',num2str(meanRealPIncomeVal,6),...
        '-Median =',num2str(medianRealPIncomeVal,6),'-Annual Rise-',num2str(SG24));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==25)
    txtstr1='Mean/Median Bond Interest Rate Diff';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Mean =',num2str(meanRateDiffVal,4),...
        '-Median =',num2str(medianRateDiffVal,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==26)
    txtstr1='Mean/Median Visa Discretionary Spending Index';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Mean =',num2str(meanDiscVal,4),...
        '-Median =',num2str(medianDiscVal,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==27)
    txtstr1='Mean/Median House Price Index Jan 2000 = 100';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG27=FRObj.SG27;
    txtstr2=strcat('Mean =',num2str(meanIndexVal,4),...
        '-Median =',num2str(medianIndexVal,4),'-Annual CSI Increase-',num2str(SG27));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==28)
    txtstr1='Mean/Median Wage in 1982-1984 dollars';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG28=FRObj.SG28;
    txtstr2=strcat('Mean =',num2str(meanWageVal,4),...
        '-Median =',num2str(medianWageVal,4),'-AnnualGrowthRate=',num2str(SG28),'-in pct');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==29)
    txtstr1='Fiscal Year US GDP In Trillions USD';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG29=FRObj.SG29;
    txtstr2=strcat('Mean GDP =',num2str(meanGDPVal/1E3,3),'-Trillion USD',...
        'Median GDP =',num2str(medianGDPVal/1E3,6),'-Trillion USD',...
        '-AnnualGrowthRate=',num2str(SG29),'-in pct');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==30)
    txtstr1='Mean/Median Debt Vs GDP';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG30=FRObj.SG30;
    txtstr2=strcat('Mean =',num2str(meanDebtVal,6),...
        '-Median =',num2str(medianDebtVal,4),'-Annual Increase In Public Debt-',num2str(SG30),'-%');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==31)
    txtstr1='Mean/Median US Budget Surplus';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Mean =',num2str(meanSurplusVal,4),...
        '-Median =',num2str(medianSurplusVal,4),'-Deficit Fraction =',num2str(FRObj.BudgetDeficitFraction));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==32)
    txtstr1='Mean/Median Fed Budget Outlays';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Mean =',num2str(meanOutlayVal,4),...
        '-Median =',num2str(medianOutlayVal,4));
    SG32=FRObj.SG32;
    txtstr2=strcat('Mean GDP =',num2str(meanOutlayVal,6),'-Pct GDP',...
        'Median GDP =',num2str(medianOutlayVal,6),'-AnnualGrowthRate=',num2str(SG32),'-in pct');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==33)
    txtstr1='Mean/Median Fed Receipts As % GDP';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG33=FRObj.SG33;
    txtstr2=strcat('Mean GDP =',num2str(meanReceiptVal,4),'-Pct GDP','-AnnualGrowthRate=',num2str(SG33),'-in pct');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==34)
    txtstr1='Mean/Median Federal Debt Held By Public';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG34=FRObj.SG34;
    txtstr2=strcat('Mean GDP =',num2str(meanDebtVal,6),'-Pct Debt','-AnnualGrowthRate=',num2str(SG34),'-in pct');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==35)
    txtstr1='Mean/Median Interest On Federal Dept';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG35=FRObj.SG35;
    txtstr2=strcat('Mean GDP =',num2str(meanInterestVal,4),'-Pct Debt','-AnnualGrowthRate=',num2str(SG35),'-in pct');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==36)
    txtstr1='Mean/Median Market Value-Trillion USD';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG36=FRObj.SG36;
    txtstr2=strcat('Mean GDP =',num2str(meanTDebtVal,4),'-US Debt','-AnnualGrowthRate=',num2str(SG36),'-in pct');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==37)
    txtstr1='Mean/Median Market Value-Auto Inventory';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG37=FRObj.GrowthRateAll(37);
    txtstr2=strcat('Mean =',num2str(meanInventoryVal,6),...
        '-Median =',num2str(medianInventoryVal,6),'-Annual Inventory Chng-',num2str(SG37),'-%');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==38)
    txtstr1='Mean/Median Foreign Auto Sales';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG38=FRObj.GrowthRateAll(38);
    txtstr2=strcat('Mean =',num2str(meanFSalesVal,6),...
        '-Median =',num2str(medianFSalesVal,6),'-Annual Saled Chng-',num2str(SG38),'-%');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==39)
    txtstr1='Mean/Median Total Vehicle  Sales';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG39=FRObj.GrowthRateAll(39);
    txtstr2=strcat('Mean =',num2str(meanTSalesVal,4),...
        '-Median =',num2str(medianTSalesVal,4),'-Increase in Total Auto Sales-',num2str(SG39),'-%');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==40)
    txtstr1='Mean/Median Domestic Auto Production';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG40=FRObj.GrowthRateAll(40);
    txtstr2=strcat('Mean =',num2str(meanDomProdVal,4),...
        '-Median =',num2str(medianDomProdVal,4),'-Increase in Total Domestic Auto Production-',num2str(SG40),'-%');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==41)
    txtstr1='Mean/Median US Auto Exports';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG41=FRObj.GrowthRateAll(41);
    txtstr2=strcat('Mean =',num2str(meanAutoExportsVal,4),...
        '-Median =',num2str(medianAutoExportsVal,4),'-Increase in Auto Exports-',num2str(SG41),'-%');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==42)
    txtstr1='Mean/Median Vehicle Miles Travelled';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG42=FRObj.SG42;
    txtstr2=strcat('Mean GDP =',num2str(meanVehMilesVal,6),'-Veh Miles','-AnnualGrowthRate=',num2str(SG42),'-in pct');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==43)
    txtstr1='Mean/Median FTI-Base Year is 2000 Index is set 100';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Mean =',num2str( meanFTIVal,5),...
        '-Median =',num2str(medianFTIVal,5));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==44)
    txtstr1='Mean/Median Rail Car Loads';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG44=FRObj.SG44;
    txtstr2=strcat('Meadian Rail Car Loads =',num2str(meanRailCarVal,5),'-AnnualGrowthRate=',num2str(SG44),'-in pct');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==45)
    txtstr1='Mean/Median Airline Load Factors';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG45=FRObj.SG45;
    txtstr2=strcat('Median Air Load Factor =',num2str(medianAirLoadVal,5),'-pct','-AnnualGrowthRate=',num2str(SG45),'-in pct');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==46)
    txtstr1='Mean/Median Available Seat Milles in Millions';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Mean =',num2str(meanASMVal,5),...
        '-Median =',num2str(medianASMVal,5));
    SG46=FRObj.SG46;
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==47)
    txtstr1='Mean/Median Barrels Of Petrol-In Billions';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('-Median =',num2str(medianPetrolVal,5),'-Millions Of Barrels');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==48)
    txtstr1='Mean/Median House Starts-Thousands';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG48=FRObj.SG48;
    txtstr2=strcat('Mean =',num2str(meanHouseVal,5),...
        '-Median =',num2str(medianHouseVal,5),'-Annual Pct Increase-',num2str(SG48));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==49)
    txtstr1='Mean/Median MDSP %';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Mean =',num2str(meanMDSPVal,5),...
        '-Median =',num2str(medianMDSPVal,5));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==50)
    txtstr1='Mean/Median Vacant Unit in Millions';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Mean =',num2str(meanVacantVal,5),...
        '-Median =',num2str(medianVacantVal,5));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==51)
    txtstr1='Mean/Median US Patents in Thousands';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG51=FRObj.GrowthRateAll(51);
    txtstr2=strcat('Mean =',num2str(meanPatentsVal,4),...
        '-Median =',num2str(medianPatentsVal,4),'-Increase in Patents-',num2str(SG51),'-%');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==52)
    txtstr1='Mean/Median Capacity Utilization';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Mean =',num2str(meanTCUVal,4),...
        '-Median =',num2str(medianTCUVal,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==53)
    txtstr1='Mean/Median Semiconductor Capacity Utilization';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG53=FRObj.GrowthRateAll(53);
    txtstr2=strcat('Mean =',num2str(meanSemiVal,4),...
        '-Median =',num2str(medianSemiVal,4),'-Growth Rate-',num2str(SG53),'-%');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==54)
    txtstr1='Mean/Median Defense Capacity Utilization';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG54=FRObj.GrowthRateAll(54);
    txtstr2=strcat('Mean =',num2str(meanDefenseVal,4),...
        '-Median =',num2str(medianDefenseVal,4),'-Growth Rate-',num2str(SG54),'-%');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==55)
    txtstr1='Mean/Median Total Revenue All Hospitals Billions USD';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG55=FRObj.GrowthRateAll(55);
    txtstr2=strcat('Mean =',num2str(meanTotRevenueVal,4),...
        '-Median =',num2str(medianTotRevenueVal,4),'-Growth Rate=',num2str(SG55),'-%');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==56)
    txtstr1='Mean/Median Pharma Price Index';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Mean =',num2str(meanPriceVal,5),...
        '-Median =',num2str(medianPriceVal,5));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==57)
    txtstr1='Mean/Median Producer Price Index';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Mean =',num2str(meanPPIVal,5),...
        '-Median =',num2str(medianPPIVal,5));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==58)
    txtstr1='Mean/Median Flex CPI Value';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Mean =',num2str(meanFCPIVal,5),'-Median = ',num2str(medianFCPIVal,5));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==59)
    txtstr1='Mean/Median Housing Starts In Thousands';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG59=FRObj.SG59;
    txtstr2=strcat('Mean =',num2str(meanHStartsVal,5),...
        '-Median =',num2str(medianHStartsVal,5),'-Annual Increase-',num2str(SG59),'-%');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==60)
    txtstr1='Mean/Median Retails Sales In Billions USD';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Mean =',num2str(meanSalesVal,5),...
        '-Median =',num2str(medianSalesVal,5));
    SG60=FRObj.SG60;
    % txtstr2=strcat('Mean Sales =',num2str(meanSalesVal,5),'-Retail Sales','-AnnualGrowthRate=',num2str(SG60),'-in pct');
    % txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==61)
    txtstr1='Mean/Median E Commerce Retails Sales In Billions USD';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG61=FRObj.SG61;
    txtstr2=strcat('Mean Sales =',num2str(meanSalesVal,5),'-Retail Sales','-AnnualGrowthRate=',num2str(SG61),'-in pct');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==62)
    txtstr1='Mean/Median Inventory To Sales Ratio';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Mean =',num2str(meanSRatioVal,5),...
        '-Median =',num2str(medianSRatioVal,5));
    SG62x=FRObj.SG62x;
    txtstr2=strcat('Mean Ratio =',num2str(meanSRatioVal,5),'-','-Inventory/Sales=',num2str(SG62x),'-in pct');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==63)
    txtstr1='Mean/Median Retail Inventories Billions of USD';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Mean =',num2str(meanInventoryVal,5),...
        '-Median =',num2str(medianInventoryVal,5));
    SG63=FRObj.SG63;
    txtstr2=strcat('Mean Inventory =',num2str(meanInventoryVal,5),'-USD','-AnnualGrowthRate=',num2str(SG63),'-in pct');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==64)
    txtstr1='Mean/Median Retail Used Car Sales Billions of USD';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG64=FRObj.SG64;
    txtstr2=strcat('Mean Inventory =',num2str(meanSalesVal,5),'-USD','-AnnualGrowthRate=',num2str(SG64),'-in pct');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==65)
    txtstr1='Mean/Median Restaurant Sales Billions of USD';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG65=FRObj.SG65;
    txtstr2=strcat('Mean =',num2str(meanRSalesVal,5),...
        '-Median =',num2str(medianRSalesVal,5),'-Annual Rate Of Change-',num2str(SG65),'-%');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==66)
    txtstr1='Mean/Median Furniture Sales Billions of USD';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG66=FRObj.SG66;
    txtstr2=strcat('Mean Sales=',num2str(meanFSalesVal,5),...
        '-Median Sales=',num2str(medianFSalesVal,5),'-Annual Rate Of Change-',num2str(SG66),'-%');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==67)
    txtstr1='Mean/Median Manufacturing Sales Trillions of USD';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG67=FRObj.SG67;
    txtstr2=strcat('Mean Sales=',num2str(meanMSalesVal,5),...
        '-Median Sales=',num2str(medianMSalesVal,5),' Yearly Rate of Change-',num2str(SG67),'-%');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==68)
    txtstr1='Mean/Median Dealer New Car Sales Billions of USD';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG68=FRObj.SG68;
    txtstr2=strcat('Mean =',num2str(meanSalesVal,5),...
        '-Median =',num2str(medianSalesVal,5),' Yearly Rate of Change-',num2str(SG68),'-%');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==69)
    txtstr1='Mean/Median Full Serve Restaurant Sales Billions of USD';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG69=FRObj.SG69;
    txtstr2=strcat('Mean =',num2str(meanSalesVal,5),...
        '-Median =',num2str(medianSalesVal,5),' Yearly Rate of Change-',num2str(SG69),'-%');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==70)
    txtstr1='Mean/Median Retail Gas Sales Billions of USD';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG70=FRObj.SG70;
    txtstr2=strcat('Mean =',num2str(meanGasSalesVal,5),...
        '-Median =',num2str(medianGasSalesVal,5),' Yearly Rate of Change-',num2str(SG70),'-%');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==71)
    txtstr1='Mean/Median Auto Parts Saled Billions of USD';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG71=FRObj.SG71;
    txtstr2=strcat('Mean =',num2str(meanAutoPartsVal,5),...
        '-Median =',num2str(medianAutoPartsVal,5),' Yearly Rate of Change-',num2str(SG71),'-%');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==72)
    txtstr1='Mean/Median Lead Index Pct';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Mean =',num2str(meanLIVal,4),...
        '-Median =',num2str(medianLIVal,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==73)
    txtstr1='Mean/Median Recession Flag';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Mean =',num2str(meanRflagVal,4),...
        '-Median =',num2str(medianRflagVal,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==74)
    txtstr1='Mean/Median Economic Indicator wrt 2007';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Mean =',num2str(meanIndicatorVal,4),...
        '-Median =',num2str(medianIndicatorVal,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==75)
    txtstr1='Mean/Median Bank Assets in Trillions Of USD';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG75=FRObj.SG75;
    txtstr2=strcat('Mean =',num2str(meanBankAssetsVal,5),...
        '-Median =',num2str(medianBankAssetsVal,5),'-Annual Asset Growth=',num2str(SG75),'-%');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==76)
    txtstr1='Mean/Median Credit Card Debt in Trillions Of USD';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG76=FRObj.SG76;  
    txtstr2=strcat('Mean =',num2str(meanCreditCardDebtVal,5),...
        '-Median =',num2str(medianCreditCardDebtVal,5),'-CC Annual Debt Growth=',num2str(SG76),'-%');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==77)
    txtstr1='Mean/Median % Non Performing Loans';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Mean =',num2str(meanLPerfVal,5),...
        '-Median =',num2str(medianLPerfVal,5));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==78)
    txtstr1='Mean/Median US Population';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG78=FRObj.SG78;
    txtstr2=strcat('Mean =',num2str(meanPopVal,5),...
        '-Median =',num2str(medianPopVal,5),'-Avg Annual Growth Rate-',num2str(SG78),'-in %');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==79)
    txtstr1='Mean/Median US Households in Millions';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Mean =',num2str(meanHHVal,5),...
        '-Median =',num2str(medianHHVal,5));
    SG79=FRObj.SG79;
    txtstr2=strcat('Mean =',num2str(meanHHVal,5),...
        '-Median =',num2str(medianHHVal,5),'-Avg Annual Growth Rate-',num2str(SG79),'-in %');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==80)
    txtstr1='Mean/Median US Pop Over 55';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG80=FRObj.SG80;
    txtstr2=strcat('Mean =',num2str(meanP55Val,5),...
        '-Median =',num2str(medianP55Val,5),'-Avg Annual Growth Rate-',num2str(SG80),'-in %');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==81)
    txtstr1='Mean/Median US Pop Between 25 and 54';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG81=FRObj.SG81;
    txtstr2=strcat('Mean =',num2str(meanP2554Val,5),...
        '-Median =',num2str(medianP2554Val,5),'-Annual Growth Rate-',num2str(SG81),'-%');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==82)
    txtstr1='Mean/Median US Families With Children Under 18';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG82=FRObj.SG82;
    txtstr2=strcat('Mean =',num2str(meanChildVal,5),...
        '-Median =',num2str(medianChildVal,5),'-Annual Rate of Change-',num2str(SG82),'-%');    
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==83)
    txtstr1='Mean/Median Black Population';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG83=FRObj.SG83;
    txtstr2=strcat('Mean =',num2str(meanBlackVal,5),...
        '-Median =',num2str(medianBlackVal,5),'-Annual Growth Black Pop-',num2str(SG83),'-%');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==84)
    txtstr1='Mean/Median White Population';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG84=FRObj.SG84;
    txtstr2=strcat('Mean =',num2str(meanWhiteVal,5),...
        '-Median =',num2str(medianWhiteVal,5),'-Annual Growth White Pop-',num2str(SG84),'-%');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==85)
    txtstr1='Mean/Median Hispanic Population';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG85=FRObj.SG85;
    txtstr2=strcat('Mean =',num2str(meanHispVal,5),...
        '-Median =',num2str(medianHispVal,5),'-Annual Growth Hispanic Pop-',num2str(SG85),'-%');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==86)
    txtstr1='Mean/Median Female Employment Ratio';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG86=FRObj.SG86;
    txtstr2=strcat('Mean =',num2str(meanFERatioVal,5),...
        '-Median =',num2str(medianFERatioVal,5),'-Annual Change Female Employ Ratio-',num2str(SG86),'-%');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==87)
    txtstr1='Mean/Median Nasdaq Volatility';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Mean =',num2str(meanVolaVal,5),...
        '-Median =',num2str(medianVolaVal,5));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==88)
    txtstr1='Mean/Median US Leading Indicators';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Mean =',num2str(meanLeadingVal,4),...
        '-Median =',num2str(medianLeadingVal,5));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==89)
    txtstr1='Mean/Median Fed 3 month Bond Yields';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Mean =',num2str(mean3MonthBondYieldVal,4),...
        '-Median =',num2str(median3MonthBondYieldVal,5));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==90)
    txtstr1='Mean/Median TDSP';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Mean =',num2str(meanTDSPVal,4),...
        '-Median =',num2str(medianTDSPVal,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==91)
    txtstr1='Mean/Median CDSP';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Mean =',num2str(meanCDSPVal,4),...
        '-Median =',num2str(medianCDSPVal,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==92)
    txtstr1='Mean/Median Real Disp Income';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG92=FRObj.SG92;
    txtstr2=strcat('Mean =',num2str(meanRDIncVal,4),...
        '-Median =',num2str(medianRDIncVal,4),'-Growth Rate-',num2str(SG92),'-%');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==93)
    txtstr1='Mean/Median Personal Consumption';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG93=FRObj.SG93;
    txtstr2=strcat('Mean =',num2str(meanPCEVal,4),...
        '-Median =',num2str(medianPCEVal,4),'-Annual Increase Personal Comsumption=',num2str(SG93),'%');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==94)
    txtstr1='Median Auto Sales';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG94=100*GrowthRateAll(94,1);
    MedianSalesVal=FRObj.CurrentMedianValue;
    txtstr2=strcat('Median =',num2str(medianSalesVal,4),'-Annual Growth Rate--',num2str(SG94),'-%');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==95)
    txtstr1='Mean/Median House Price Index';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG95=100*GrowthRateAll(95,1);
    txtstr2=strcat('Mean =',num2str(meanPriceVal,4),...
        '-Median =',num2str(medianPriceVal,4),'Annual Growth Rate--',num2str(SG95),'-%');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==96)
    txtstr1='Mean/Median Credit Card Balance';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG96=100*GrowthRateAll(96,1);
    txtstr2=strcat('Mean =',num2str(meanBalanceVal,4),...
        '-Median =',num2str(medianBalanceVal,4),'-Credit Rate Of Growth-',num2str(SG96),'-%');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==97)
    txtstr1='Mean/Median Sum New Mortgages';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG97=100*GrowthRateAll(97,1);
    txtstr2=strcat('Mean =',num2str(meanSumVal,4),...
        '-Median =',num2str(medianSumVal,4),'-Mortgage Rate Of Growth-',num2str(SG97),'-%');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==98)
    txtstr1='Mean/Median Past Due Loans';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Mean =',num2str(meanPastDueVal,4),...
        '-Median =',num2str(medianPastDueVal,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==99)
    txtstr1='Mean/Median Credit Score';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Mean =',num2str(meanScoreVal,4),...
        '-Median =',num2str(medianScoreVal,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==100)
    txtstr1='Mean/Median HomeEquity Loans';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Mean =',num2str(meanEquityVal/1000,4),...
        '-Median =',num2str(medianEquityVal/1000,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==101)
    txtstr1='Mean/Median USD To Pound Sterling Conversion';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Mean =',num2str(meanconv1Val,4),...
        '-Median =',num2str(medianconv1Val,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==102)
    txtstr1='Mean/Median USD Board Currency Index';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Mean =',num2str(meanconv2Val,4),...
        '-Median =',num2str(medianconv2Val,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==103)
    txtstr1='Mean/Median Japanase Yen To USD';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Mean =',num2str(meanconv3Val,4),...
        '-Median =',num2str(medianconv3Val,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==104)
    txtstr1='Mean/Median Stock Mkt Cap to GDP';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Mean =',num2str(meancapVal,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==105)
    txtstr1='Mean/Median CPI Growth Rate %';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Mean =',num2str(meangrowthVal,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==106)
    txtstr1='Mean/Median National Income';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Mean =',num2str(meanNatIncomeVal,4),...
        '-Median =',num2str(medianNatIncomeVal,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==107)
    txtstr1='Mean/Median RegGas Price';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Mean =',num2str(meangaspriceVal,4),...
        '-Median =',num2str(mediangaspriceVal,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==108)
    txtstr1='Mean/Median Brent Oil Price';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Mean =',num2str(meanBrentPriceVal,4),...
        '-Median =',num2str(medianBrentPriceVal,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==109)
    txtstr1='Mean/Median Egg Price Per Dozen';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG109=100*GrowthRateAll(109,1);
    txtstr2=strcat('Mean =',num2str(meanEggPriceVal,4),...
        '-Median =',num2str(medianEggPriceVal,4),'-Growth Rate=',num2str(SG109,4),'-%');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==110)
    txtstr1='Mean/Median Beef Price Per Pound';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG110=100*GrowthRateAll(110,1);
    txtstr2=strcat('Mean =',num2str(meanGroundBeefPriceVal,4),...
        '-Median =',num2str(meanGroundBeefPriceVal,4),'-Growth Rate=',num2str(SG110,4),'-%');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==111)
    txtstr1='Mean/Median Electricty Price KwHr-in USD';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG111=100*GrowthRateAll(111,1);
    txtstr2=strcat('Mean =',num2str(meanElectricityPriceVal,4),...
        '-Median =',num2str(medianElectricityPriceVal,4),'-Growth Rate=',num2str(SG111,4),'-%');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==112)
    txtstr1='Mean/Median WTI Price in USD';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG112=100*GrowthRateAll(112,1);
    txtstr2=strcat('Mean =',num2str(meanWTIPriceVal,4),...
        '-Median =',num2str(medianWTIPriceVal,4),'-Growth Rate=',num2str(SG112,4),'-%');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==113)
    txtstr1='Mean/Median Natural Gas Price in USD';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG113=100*GrowthRateAll(113,1);
    txtstr2=strcat('Mean =',num2str(meanNatGasPriceVal,4),...
        '-Median =',num2str(medianNatGasPriceVal,4),'-Growth Rate=',num2str(SG113,4),'-%');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==114)
    txtstr1='Mean/Median Natural CopperPrice in USD';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG114=100*GrowthRateAll(114,1);
    txtstr2=strcat('Mean =',num2str(meanCopperVal,4),...
        '-Median =',num2str(medianCopperVal,4),'-Growth Rate=',num2str(SG114,4),'-%');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==115)
    txtstr1='Mean/Median Natural Diesel in USD';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG115=100*GrowthRateAll(115,1);
    txtstr2=strcat('Mean =',num2str(meanDieselVal,4),...
        '-Median =',num2str(medianDieselVal,4),'-Growth Rate=',num2str(SG115,4),'-%');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==116)
    txtstr1='Mean/Median Natural Jet Fuel in USD';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG116=100*GrowthRateAll(116,1);
    txtstr2=strcat('Mean =',num2str(meanJetVal,4),...
        '-Median =',num2str(medianJetVal,4),'-Growth Rate=',num2str(SG116,4),'-%');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==117)
    txtstr1='Mean/Median Aluminum Price kUSD';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG117=100*GrowthRateAll(117,1);
    txtstr2=strcat('Mean =',num2str( meanAlumVal,4),...
        '-Median =',num2str(medianAlumVal,4),'-Growth Rate=',num2str(SG117,4),'-%');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==118)
    txtstr1='Mean/Median Cocoa Price kUSD';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG118=100*GrowthRateAll(118,1);
    txtstr2=strcat('Mean =',num2str(meanCocoaVal,4),...
        '-Median =',num2str(medianCocoaVal,4),'-Growth Rate=',num2str(SG118,4),'-%');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==119)
    txtstr1='Mean/Median Energy Index';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG119=100*GrowthRateAll(119,1);
    txtstr2=strcat('Mean =',num2str(meanEnergyIndexVal,4),...
        '-Median =',num2str(medianEnergyIndexVal,4),'-Growth Rate=',num2str(SG119,4),'-%');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==120)
    txtstr1='Mean/Median Bread Price';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG120=100*GrowthRateAll(120,1);
    txtstr2=strcat('Mean =',num2str(meanBreadVal,4),...
        '-Median =',num2str(medianBreadVal,4),'-Growth Rate=',num2str(SG120,4),'-%');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==121)
    txtstr1='Mean/Median Wheat Price';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG121=100*GrowthRateAll(121,1);
    txtstr2=strcat('Mean =',num2str(meanWheatVal,4),...
        '-Median =',num2str(medianWheatVal,4),'-Growth Rate=',num2str(SG121,4),'-%');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==122)
    txtstr1='Mean/Median Uranium Price';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG122=100*GrowthRateAll(122,1);
    txtstr2=strcat('Mean =',num2str(meanU2Val,4),...
        '-Median =',num2str(medianU2Val,4),'-Growth Rate=',num2str(SG122,4),'-%');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==123)
    txtstr1='Mean/Median Nickel Price';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG123=100*GrowthRateAll(123,1);
    txtstr2=strcat('Mean =',num2str(meanNickelVal,4),...
        '-Median =',num2str(medianNickelVal,4),'-Growth Rate=',num2str(SG123,4),'-%');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==124)
    txtstr1='Mean/Median Rubber Price';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG124=100*GrowthRateAll(124,1);
    txtstr2=strcat('Mean =',num2str(meanRubberVal,4),...
        '-Median =',num2str(medianRubberVal,4),'-Growth Rate=',num2str(SG124,4),'-%');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==125)
    txtstr1='Mean/Median Sugar Price';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG125=100*GrowthRateAll(125,1);
    txtstr2=strcat('Mean =',num2str(meanSugarVal,4),...
        '-Median =',num2str(medianSugarVal,4),'-Growth Rate=',num2str(SG125,4),'-%');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==126)
    txtstr1='Mean/Median Urban Home Food Indices';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG126=100*GrowthRateAll(126,1);
    txtstr2=strcat('Mean =',num2str(meanFoodVal,4),...
        '-Median =',num2str(medianFoodVal,4),'-Growth Rate=',num2str(SG126,4),'-%');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==127)
    txtstr1='Mean/Median PPI Food Indices';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG127=100*GrowthRateAll(127,1);
    txtstr2=strcat('Mean =',num2str(meanPPIFoodVal,4),...
        '-Median =',num2str(medianPPIFoodVal,4),'-Growth Rate=',num2str(SG127,4),'-%');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==128)
    txtstr1='Mean/Median PPI Diesel Indices';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG128=100*GrowthRateAll(128,1);
    txtstr2=strcat('Mean =',num2str(meanPPIDieselVal,4),...
        '-Median =',num2str(medianPPIDieselVal,4),'-Growth Rate=',num2str(SG128,4),'-%');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==129)
    txtstr1='Mean/Median Bologna Prices per pound';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG129=100*GrowthRateAll(129,1);
    txtstr2=strcat('Mean =',num2str(meanBolognaVal,4),...
        '-Median =',num2str(medianBolognaVal,4),'-Growth Rate=',num2str(SG129,4),'-%');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==130)
    txtstr1='Mean/Median Ham Prices per pound';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG130=100*GrowthRateAll(130,1);
    txtstr2=strcat('Mean =',num2str(meanHamVal,4),...
        '-Median =',num2str(medianHamVal,4),'-Growth Rate=',num2str(SG130,4),'-%');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==131)
    txtstr1='Mean/Median Chuck Roast Prices per pound';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG131=100*GrowthRateAll(131,1);
    txtstr2=strcat('Mean =',num2str(meanCroastVal,4),...
        '-Median =',num2str(medianCroastVal,4),'-Growth Rate=',num2str(SG131,4),'-%');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==132)
    txtstr1='Mean/Median Bacon Prices per pound';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG132=100*GrowthRateAll(132,1);
    txtstr2=strcat('Mean =',num2str(meanBaconVal,4),...
        '-Median =',num2str(medianBaconVal,4),'-Growth Rate=',num2str(SG132,4),'-%');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==133)
    txtstr1='Mean/Median Soybean Index';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG133=100*GrowthRateAll(133,1);
    txtstr2=strcat('Mean =',num2str(meanSoybeanVal,4),...
        '-Median =',num2str(medianSoybeanVal,4),'-Growth Rate=',num2str(SG133,4),'-%');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==134)
    txtstr1='Mean/Median Flour Price USD/lb';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG134=100*GrowthRateAll(134,1);
    txtstr2=strcat('Mean =',num2str(meanFlourVal,4),...
        '-Median =',num2str(medianFlourVal,4),'-Growth Rate=',num2str(SG134,4),'-%');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==135)
    txtstr1='Mean/Median Cooking Oil Index';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG135=100*GrowthRateAll(135,1);
    txtstr2=strcat('Mean =',num2str(meanCoilVal,4),...
        '-Median =',num2str(medianCoilVal,4),'-Growth Rate=',num2str(SG135,4),'-%');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==136)
    txtstr1='Mean/Median Whole Chicken Price';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG136=100*GrowthRateAll(136,1);
    txtstr2=strcat('Mean =',num2str(meanWhChickVal,4),...
        '-Median =',num2str(medianWhChickVal,4),'-Growth Rate=',num2str(SG136,4),'-%');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==137)
    txtstr1='Mean/Median Farm Price Index';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG137=100*GrowthRateAll(137,1);
    txtstr2=strcat('Mean =',num2str(meanFarmIndexVal,4),...
        '-Median =',num2str(medianFarmIndexVal,4),'-Growth Rate=',num2str(SG137,4),'-%');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==138)
    txtstr1='Mean/Median Cattle Price Index';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG138=100*GrowthRateAll(138,1);
    txtstr2=strcat('Mean =',num2str(meanCattleIndexVal,4),...
        '-Median =',num2str(medianCattleIndexVal,4),'-Growth Rate=',num2str(SG138,4),'-%');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==139)
    txtstr1='Mean/Median Tomatoes Price Index';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG139=100*GrowthRateAll(139,1);
    txtstr2=strcat('Mean =',num2str(meanTomatoesIndexVal,4),...
        '-Median =',num2str(medianTomatoesIndexVal,4),'-Growth Rate=',num2str(SG139,4),'-%');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==140)
    txtstr1='Mean/Median Corn Price Index';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG140=100*GrowthRateAll(140,1);
    txtstr2=strcat('Mean =',num2str(meanCornIndexVal,4),...
        '-Median =',num2str(medianCornIndexVal,4),'-Growth Rate=',num2str(SG140,4),'-%');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==141)
    txtstr1='Mean/Median MilkPrice Index';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG141=100*GrowthRateAll(141,1);
    txtstr2=strcat('Mean =',num2str(meanMilkIndexVal,4),...
        '-Median =',num2str(medianMilkIndexVal,4),'-Growth Rate=',num2str(SG141,4),'-%');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==142)
    txtstr1='Mean/Median Fruit Price Index';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG142=100*GrowthRateAll(142,1);
    txtstr2=strcat('Mean ',num2str(meanFruitIndexVal,4),...
        '-Median =',num2str(medianFruitIndexVal,4),'-Growth Rate=',num2str(SG142,4),'-%');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==143)
    txtstr1='Mean/Median Cabbage Price Index';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG143=100*GrowthRateAll(143,1);
    txtstr2=strcat('Mean =',num2str(meanCabbageIndexVal,4),...
        '-Median =',num2str(medianCabbageIndexVal,4),'-Growth Rate=',num2str(SG143,4),'-%');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==144)
    txtstr1='Mean/Median Rice Price Index';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG144=100*GrowthRateAll(144,1);
    txtstr2=strcat('Mean =',num2str(meanRiceIndexVal,4),...
        '-Median =',num2str(medianRiceIndexVal,4),'-Growth Rate=',num2str(SG144,4),'-%');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==145)
    txtstr1='Mean/Median Rice Price Index';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG145=100*GrowthRateAll(145,1);
    txtstr2=strcat('Mean =',num2str(meanCitrusIndexVal,4),...
        '-Median =',num2str(medianCitrusIndexVal,4),'-Growth Rate=',num2str(SG145,4),'-%');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
end
set(newaxesh,'Visible','Off');
pause(chart_time)
%% Save the plot
try
    eval(['cd ' jpegpath(1:length(jpegpath)-1)]);
catch
    ab=1;
end
titlestr=char(titlestr);
actionstr='print';
typestr='-djpeg';
figstr=strcat(titlestr,'.jpg');
figstr2=strcat(titlestr,'.png');
figstr=char(figstr);
figstr2=char(figstr2);
[cmdString]=MyStrcat2(actionstr,typestr,figstr);
eval(cmdString);
pause(5)
if(icapture==1)
    eval(['cd ' tiffpath(1:length(tiffpath)-1)]);
    screencapture(gcf,[],figstr2);
    eval(['cd ' jpegpath(1:length(jpegpath)-1)]);
end
if(itype==128)
    ab=1;
elseif(itype==133)
    ab=2;
end
close('all')
%% Save the name of the image file created

end