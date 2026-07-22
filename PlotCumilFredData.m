 function  PlotCumilFredData(FRObj,itype,titlestr3)
% The purpose of this routine ss to plot data from the Federal Reserve
% (FRED) Database
% Idea is just to get a quick sanity check
% Written By: Stephen Forczyk
% Created: Oct 28,2025
% Revised: Oct 29,2025 thru Nov 15,2025
% global datapath matlabpath moviepath logfilepath mappath fredpath;
% global tablepath govjpegpath  ;
% global widd2 lend2;
% global initialtimestr igrid ijpeg ilog ;
% global vert2 hor2 machine;
% global Fz1 Fz2;
% global idirector mov izoom iwindow;

govjpegpath='K:\Investing2\gov_jpeg\';
%icapture=1;
% Get the data to add a logo to the bottom right of the chart if desired
iLogo=FRObj.iLogo;
LogoFileName=FRObj.LogoFileName;
govjpegapth=FRObj.govjpegpath;
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
% Now create the data for a cumilative distribution plot
xpt=FRObj.DataMarks(1:20,1);
ypt=(FRObj.DataDist(itype,1:20))';
%% Display Selected Fred Data
movie_figure1=figure('position',[hor1 vert1 widd lend]);
%set(gcf,'MenuBar','none');
if(itype==1)% Monthly Unemployment Rate
    plot(xpt,ypt,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('U2 Rate %','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    set(gca,'XLim',[0 110])
    set(gca,'YLim',[0 20]);
    meanUnrate=ypt(10,1);
    filestr1=strcat('Mean Unemployment Rate %=',num2str(meanUnrate,4));
    fprintf(fid,'%20s\n',filestr1);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
  elseif(itype==2)
    plot(xpt,ypt,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('CPI Dist %','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    set(gca,'XLim',[0 110])
    set(gca,'YLim',[0 maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    meanSCPI=ypt(10,1);
    filestr2=strcat('Mean Sticky CPI  Rate %=',num2str( meanSCPI,4));
    fprintf(fid,'%20s\n',filestr2);
elseif(itype==3)
    plot(InputTT.Date,InputTT.CIVPART_All,'r',...
        InputTT.Date,InputTT.CIVPART_25_54,'g',...
        InputTT.Date,InputTT.CIVPART_55,'b',...
        InputTT.Date,InputTT.meanPartAll,'y');
    title(titlestr3)
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
    plot(xpt,ypt,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Mortgage Delinquency %','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    set(gca,'XLim',[0 110])
    set(gca,'YLim',[0 maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    meanDelRate=ypt(10,1);
elseif(itype==5)
    plot(xpt,ypt,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Home Ownership %','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    set(gca,'XLim',[0 110])
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    meanHomeOwnershipRate=ypt(10,1);
elseif(itype==6)
    plot(xpt,ypt,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('IPMAN Index','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    set(gca,'XLim',[0 110]);
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    meanProdRate=ypt(10,1);
elseif(itype==7)
    plot(InputTT.Date,InputTT.Income/1000,'g',...
        InputTT.Date,InputTT.HouseIncomeMean/1000,'r--');
    title(titlestr3)
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
    hl=legend('Household Inc Thousand USD','Mean Income','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    GrowthRateAll=FRObj.GrowthRateAll;
elseif(itype==8)
    plot(xpt,ypt,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    maxval=60;
    set(gca,'XLim',[0 110])
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    meanVix=ypt(10,1);
elseif(itype==9)
    plot(xpt,ypt,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    set(gca,'XLim',[0 110]);
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    meanCC=ypt(10,1);
elseif(itype==10)
    plot(xpt,ypt,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Days On Market','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    set(gca,'XLim',[0 110]);
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    meanDaysOnMarket=ypt(10,1);
elseif(itype==11)
    plot(xpt,ypt,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('FedBond 10Yr Yields','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    set(gca,'XLim',[0 110]);
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    mean10YearBondYield=ypt(10,1);
elseif(itype==12)
    minval=0;
    maxval=15;
    plot(xpt,ypt,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('U2 UnEmployment Rate','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    set(gca,'XLim',[0 110]);
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    meanU2=ypt(10,1);
elseif(itype==13)
        plot(xpt,ypt/1E3,'r','LineWidth',2);
        title(titlestr3)
        xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
        ylabel('Annual GDP Reported By Quarter-Trillions USD','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
        set(gca,'XLim',[0 110]);
        set(gca,'YLim',[minval maxval]);
        set(gca,'Color', [0.3 0.3 0.3]);
        set(gca,'XGrid','on','GridColor',[1 1 1]);
        set(gca,'YGrid','on','GridColor',[1 1 1]);
        meanGDP=ypt(10,1);
        GrowthRateAll=FRObj.GrowthRateAll;
  elseif(itype==14)
        plot(xpt,ypt/1000,'r','LineWidth',2);
        title(titlestr3)
        xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
        ylabel('Annual GDP Per Cap Reported By Thousands 2017 USD','FontWeight','bold','FontSize',12,'FontWeight','bold');
        minval=0;
        maxval=80;
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
        set(gca,'XLim',[0 110])
        set(gca,'YLim',[minval maxval]);
        set(gca,'Color', [0.3 0.3 0.3]);
        set(gca,'XGrid','on','GridColor',[1 1 1]);
        set(gca,'YGrid','on','GridColor',[1 1 1]);
        meanGDPPerCap=ypt(10,1)/1000;
       
elseif(itype==15)
    plot(xpt,ypt,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('FedBond 2Yr Yields','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    set(gca,'XLim',[0 110]);
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    mean2YearBondYield=ypt(10,1);
elseif(itype==16)
    plot(xpt,ypt/1E6,'r','LineWidth',2);
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
    set(gca,'XLim',[0 110])
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    meanClaims=ypt(10,1)/1E6;
 elseif(itype==17)
    plot(xpt,ypt/1E6,'r','LineWidth',2);
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Continued Unemployment Claims','FontWeight','bold','FontSize',12,'FontWeight','bold');
    title(titlestr3)
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
    set(gca,'XLim',[0 110])
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    meanClaims=ypt(10,1)/1E6;
 elseif(itype==18)
    plot(xpt,ypt,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Non Farm Job Openings-Thousands','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    set(gca,'XLim',[0 110])
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    meanNFJO=ypt(10,1);
 elseif(itype==19)
    plot(xpt,ypt,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Construction Job Openings-Thousands','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    set(gca,'XLim',[0 110])
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    meanCJ=ypt(10,1);
  elseif(itype==20)
    plot(xpt,ypt,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Manufacturing Job Openings-Thousands','FontWeight','bold','FontSize',12,'FontWeight','bold');
    minval=0;
    maxval=1200;
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
    set(gca,'XLim',[0 110])
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    meanMFacVal=ypt(10,1);
  elseif(itype==21)
    plot(xpt,ypt,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Prof Job Openings-Thousands','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    maxval=ypt(20);
    set(gca,'XLim',[0 110])
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    meanProfOpenVal=ypt(10);
  elseif(itype==22)
    plot(xpt,ypt,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Health Care Job Openings-Thousands','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    meanHCOpenVal=ypt(10,1);
    minval=0;
    maxval=ypt(20);
    set(gca,'XLim',[0 110])
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    meanHCOpenVal=ypt(10,1);
elseif(itype==23)
    plot(xpt,ypt,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Gov Job Openings-Thousands','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    maxval=ypt(20);
    set(gca,'XLim',[0 110])
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    meanGovOpenVal=ypt(10,1);
 elseif(itype==24)
    plot(InputTT.Date,InputTT.Income/1000,'g',...
        InputTT.Date,InputTT.meanPIncome/1000,'r--',...
        InputTT.Date,InputTT. medianPIncome/1000,'b--');
    title(titlestr3)
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
    plot(xpt,ypt,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Rate Diff','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    set(gca,'XLim',[0 110])
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    meanRateDiffVal=ypt(10,1);

 elseif(itype==26)
    plot(InputTT.Date,InputTT.VISADiscretionary,'g',...
        InputTT.Date,InputTT.meanDisc,'r--',...
        InputTT.Date,InputTT.medianDisc,'b--');
    title(titlestr3)
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
    plot(xpt,ypt,'r','LineWidth',2);
    title(titlestr3)
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
    medianCSVal=ypt(10,1);
 elseif(itype==28)
    plot(xpt,ypt,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Median Weekly Earnings USD','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    maxval=500;
    set(gca,'XLim',[0 110]);
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    medianWageVal=ypt(10,1);
 elseif(itype==29)
    plot(InputTT.Date,InputTT.FYGDP,'g',...
        InputTT.Date,InputTT.meanGDP,'r--',...
        InputTT.Date,InputTT.medianGDP,'b--');
    title(titlestr3)
    xlabel('Date','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Fiscal Year US GDP','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    maxval=30000;
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
    plot(xpt,ypt,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Total Public Debt % Vs GDP','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    medianDebtVal=ypt(10,1);
 elseif(itype==31)
    plot(xpt,ypt/1E3,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Budget Surplus Billion USD','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    set(gca,'XLim',[0 110])
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    medianSurplusVal=ypt(10,1);
 elseif(itype==32)
    plot(InputTT.Date,InputTT.NetOutlays,'g',...
        InputTT.Date,InputTT.meanOutlay,'r--',...
        InputTT.Date,InputTT.medianOutlay,'b--');
    title(titlestr3)
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
        InputTT.Date,InputTT.medianReceipts,'b--');
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
    hl=legend('Receipts %','Mean','Median','Location','northwest','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanReceiptVal=mean(InputTT.Receipts,'omitnan');
    medianReceiptVal=median(InputTT.Receipts,'omitnan');
  elseif(itype==34)
    plot(xpt,ypt/1E6,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Federal Public Debt Trillions USD','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    maxval1=32;
    maxval=maxval1;
    set(gca,'XLim',[0 110]);
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    meanDebtVal=ypt(10,1)/1E6;
elseif(itype==35)
    plot(InputTT.Date,InputTT.Interest,'g',...
        InputTT.Date,InputTT.meanInterest,'r--',...
        InputTT.Date,InputTT.medianInterest,'b--');
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
    hl=legend('Fed Interest','Mean','Median','Location','northwest','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanInterestVal=mean(InputTT.Interest,'omitnan');
    medianInterestVal=median(InputTT.Interest,'omitnan');
elseif(itype==36)
    plot(xpt,ypt/1E3,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Treasury Debt USD','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    maxval=28;
    set(gca,'XLim',[0 110]);
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    meanTDebtVal=ypt(10,1)/1E3;
 elseif(itype==37)
    plot(xpt,ypt,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Thpusands Of Autos','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    maxval1=0;
    maxval=2000;
    set(gca,'XLim',[0 110]);
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    meanInventoryVal=ypt(10,1);
 elseif(itype==38)
    plot(xpt,ypt,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Millions Of Autos','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    set(gca,'XLim',[0 110]);
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    meanFSalesVal=ypt(10,1);
 elseif(itype==39)
    plot(xpt,ypt,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Total Auto Sales Millions Of Autos','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    set(gca,'XLim',[0 110]);
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    meanTSalesVal=ypt(10,1);
 elseif(itype==40)
    plot(xpt,ypt,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('US Auto Exports-Thousand Of Autos','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    set(gca,'XLim',[0 110]);
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    meanDomProdVal=ypt(10,1);
 elseif(itype==41)
    plot(xpt,ypt,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Monthly US Auto Exports In Thousands','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    set(gca,'XLim',[0 110]);
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    meanAutoExportsVal=ypt(10,1);
 elseif(itype==42)
    plot(xpt,ypt/1E3,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Veh Miles','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    maxval=.4;
    set(gca,'XLim',[0 110])
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    medianVehMilesVal=ypt(10)/1000;
elseif(itype==43)
    plot(xpt,ypt,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Freight Index ','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    set(gca,'XLim',[0 110])
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    medianFTIVal=ypt(10);
elseif(itype==44)
    plot(xpt,ypt/1E3,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Rail Car Loads ','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    set(gca,'XLim',[0 110])
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    medianRailCarVal=ypt(10)/1000;
elseif(itype==45)
    plot(xpt,ypt,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Airline Load Factor ','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    set(gca,'XLim',[0 110])
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    medianAirLoadVal=ypt(10,1);
elseif(itype==46)
    plot(xpt,ypt/1E6,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Air Seat Miles','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    set(gca,'XLim',[0 110])
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    medianASMVal=ypt(10,1)/1E6;
elseif(itype==47)
    plot(xpt,ypt/1E3,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Millions Of Barrels Per Month','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    set(gca,'XLim',[0 110])
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    medianPetrolVal=ypt(10,1)/1E3;
elseif(itype==48)
    plot(xpt,ypt,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Housing Starts','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    set(gca,'XLim',[0 110])
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
      meanHouseVal=ypt(10)/1E3;
 elseif(itype==49)
    plot(xpt,ypt,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('IPMAN Index','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    set(gca,'XLim',[0 110])
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    meanMDSPVal=ypt(10,1);
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
    minval=0;
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
    plot(xpt,ypt,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Total Capacity Utilization %','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    set(gca,'XLim',[0 110])
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
     meanTCUVal=ypt(10,1);
  elseif(itype==53)
    plot(xpt,ypt,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Semiconductor Capacity Utilization %','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    set(gca,'XLim',[0 110])
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    meanSemiVal=ypt(10,1);
 elseif(itype==54)
    plot(xpt,ypt,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Defense Capacity Utilization % wrt to 2017','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    set(gca,'XLim',[0 110])
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    meanDefenseVal=ypt(10,1);
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
    plot(xpt,ypt,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Producer Price Index wrt to 1982','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    set(gca,'XLim',[0 110]);
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    medianPPIVal=ypt(10,1);
 elseif(itype==58)
    plot(xpt,ypt,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Flex CPI','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    set(gca,'XLim',[0 110])
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    meanFCPIVal=ypt(10,1);
 elseif(itype==59)
    plot(xpt,ypt,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('House Completions-Thousands','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    set(gca,'XLim',[0 110])
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
      meanHCompVal=ypt(10);
 elseif(itype==60)
    plot(xpt,ypt/1E3,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Sales','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    set(gca,'XLim',[0 110])
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    meanSalesVal=ypt(10,1)/1E3;
 elseif(itype==61)
    plot(xpt,ypt/1E3,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('E Commerce Sales Billions USD','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    set(gca,'XLim',[0 110])
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    meanSalesVal=ypt(10,1)/1E3;
elseif(itype==62)
    plot(xpt,ypt,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Inventory To Sales','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    set(gca,'XLim',[0 110])
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    meanSRatioVal=ypt(10,1);
 elseif(itype==63)
    plot(xpt,ypt/1E3,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Retail Inventories','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    set(gca,'XLim',[0 110])
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    meanInventoryVal=ypt(10,1)/1E3;
 elseif(itype==64)
    plot(xpt,ypt/1E3,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Retail Used Car Sales','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    set(gca,'XLim',[0 110])
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    medianSalesVal=ypt(10,1)/1E3;
 elseif(itype==65)
    plot(xpt,ypt/1E3,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Restaurant Sales','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    set(gca,'XLim',[0 110])
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    meanRSalesVal=ypt(10,1)/1E3;
 elseif(itype==66)
    plot(xpt,ypt/1E3,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Furniture Sales-Billions USD','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    set(gca,'XLim',[0 110])
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    meanFSalesVal=ypt(10,1)/1E3;
elseif(itype==67)
    plot(xpt,ypt/1E6,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Sales-Trillions USD','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    set(gca,'XLim',[0 110])
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    medianMSalesVal=ypt(10)/1E6;
 elseif(itype==68)
    plot(xpt,ypt/1000,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Billions USD','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    set(gca,'XLim',[0 110])
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    meanSalesVal=ypt(10)/1E3;
 elseif(itype==69)
    plot(xpt,ypt/1000,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Sales-Billions USD','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    set(gca,'XLim',[0 110])
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    meanSalesVal=ypt(10)/1E3;
 elseif(itype==70)
    plot(xpt,ypt/1000,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Sales','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    set(gca,'XLim',[0 110])
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    meanGasSalesVal=ypt(10)/1E3;
 elseif(itype==71)
    plot(xpt,ypt/1000,'r','LineWidth',2);
    title(titlestr3)
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
    medianAutoPartsVal=ypt(10)/1E3;
elseif(itype==72)
    plot(xpt,ypt,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Sales','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    set(gca,'XLim',[0 110])
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    meanLIVal=ypt(10,1);
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
    plot(xpt,ypt,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('CoIncident Economic Indicator','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    set(gca,'XLim',[0 110])
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    meanIndicatorVal=ypt(10,1);
elseif(itype==75)
    plot(xpt,ypt/1E6,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Bank Balances Trillions USD','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    set(gca,'XLim',[0 110]);
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    meanBankAssetsVal=ypt(10,1)/1E6;
elseif(itype==76)
    plot(xpt,ypt/1E6,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Credit Card Debt Trillions USD','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    set(gca,'XLim',[0 110])
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    meanCreditCardDebtVal=ypt(10,1)/1E6;
  elseif(itype==77)
    plot(xpt,ypt,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Non Performing Loans %','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    set(gca,'XLim',[0 110])
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    meanLPerfVal=ypt(10,1);
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
    plot(xpt,ypt,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    set(gca,'XLim',[0 110]);
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    medianFERatioVal=ypt(10,1);
 elseif(itype==87)
    plot(xpt,ypt,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Nasdaq Volatility Index','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    set(gca,'XLim',[0 110]);
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    meanVolaVal=ypt(10,1);
 elseif(itype==88)
    plot(xpt,ypt,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Leading Indicators Index','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    medianLeadingVal=ypt(10,1);
elseif(itype==89)
    plot(xpt,ypt,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('3 Month Bond Rates','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    set(gca,'XLim',[0 110])
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    mean3MonthBondYieldVal=ypt(10,1);
elseif(itype==90)
    plot(xpt,ypt,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('HouseHold Debt % Income','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    meanTDSPVal=ypt(10,1);
  elseif(itype==91)
    plot(xpt,ypt,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Consumer Debt Payments As % Disp Income','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    set(gca,'XLim',[0 110])
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    meanCDSPVal=ypt(10,1);
 elseif(itype==92)
    plot(xpt,ypt/1E3,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Real Disposalble Income Billions USD','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    set(gca,'XLim',[0 110])
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    medianRDIncVal=ypt(10,1)/1E3;
 elseif(itype==93)
    plot(xpt,ypt/1E3,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Personal Disp Income Billions USD','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    medianPDIncVal=ypt(10,1)/1E3;
 elseif(itype==94)
    plot(xpt,ypt,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Domestic Auto Sales in Millions of Cars','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    set(gca,'XLim',[0 110])
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    medianSalesVal=FRObj.CurrentMedianValue;
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
    hl=legend('PriceIndex','Mean ','Median','FontSize',10,'FontWeight','bold');
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
    ylabel('Credit Card Balances','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
        InputTT.Date,InputTT.medianEquity/1000,'b--');
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
    hl=legend('Home Equity Loans','Mean ','Median','FontSize',10,'FontWeight','bold');
    set(hl,'Color',[1 1 1])
    set(hl,'TextColor',[0 0 0]);
    meanEquityVal=mean(InputTT.Assets/1000);
    medianEquityVal=median(InputTT.Assets/1000);
 elseif(itype==101)
    plot(xpt,ypt,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('USD To BP Conversion Rate','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    set(gca,'XLim',[0 110])
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    meanRate1=ypt(10,1);
 elseif(itype==102)
    plot(xpt,ypt,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Broad Currency Conversion Rate','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    set(gca,'XLim',[0 110])
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    meanRate2=ypt(10,1);
 elseif(itype==103)
    plot(xpt,ypt,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Japanese Currency Conversion Rate','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    set(gca,'XLim',[0 110])
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    meanRate3=ypt(10,1);
 elseif(itype==105)
    plot(xpt,ypt,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('CPI All Growth Rate','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    set(gca,'XLim',[0 110]);
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    meancpiRate=ypt(10,1);
  elseif(itype==107)
    plot(xpt,ypt,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Reg Gas Price-US Gallon','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    medianGasPriceVal=ypt(10,1);
  elseif(itype==108)
    plot(xpt,ypt,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Brent Oil Price USD/Barrel','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    medianBrentPriceVal=ypt(10,1);
  elseif(itype==109)
    plot(xpt,ypt,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Grade A Egg Prices USD/Dozen','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    maxval=7;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    medianEggPriceVal=ypt(10,1);
  elseif(itype==110)
    plot(xpt,ypt,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Ground Beef Prices USD/Pound','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    maxval=7;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    medianBeefPriceVal=ypt(10,1);
  elseif(itype==111)
    plot(xpt,ypt,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('ElectricityPrices-KwHr','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    maxval=.25;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    medianElectricityPriceVal=ypt(10,1);
  elseif(itype==112)
    plot(xpt,ypt,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('WTI Price USD/Barrel','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    medianWTIPriceVal=ypt(10,1);
  elseif(itype==113)
    plot(xpt,ypt,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Natural Gas Price','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    medianNatGasPriceVal=ypt(10,1);
  elseif(itype==114)
    plot(xpt,ypt/1000,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Copper Price','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    medianCopperVal=ypt(10,1)/1000;
elseif(itype==115)
    plot(xpt,ypt,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Diesel Price','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    maxval=8;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    medianDieselVal=ypt(10,1);
elseif(itype==116)
    plot(xpt,ypt,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Jet Fuel Price','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    maxval=5;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    medianJetVal=ypt(10,1);
elseif(itype==117)
    plot(xpt,ypt/1000,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Aluminum Price kUSD/Metric Ton','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    maxval=5;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    medianAlumVal=ypt(10,1);
elseif(itype==118)
    plot(xpt,ypt/1000,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Cocoa Price kUSD/Metric Ton','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    maxval=12;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    medianCocoaVal=ypt(10,1)/1000;
elseif(itype==119)
    plot(xpt,ypt,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Global Energy Index','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    medianEnergyIndexVal=ypt(10,1);
elseif(itype==120)
    plot(xpt,ypt,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Bread Price','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    maxval=3;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    medianBreadVal=ypt(10,1);
elseif(itype==121)
    plot(xpt,ypt,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Wheat Price USD/Ton','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    maxval=500;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    medianWheatVal=ypt(10,1);
elseif(itype==122)
    plot(xpt,ypt,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Uranium Price-USD/lb','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    medianU2Val=ypt(10,1);
elseif(itype==123)
    plot(xpt,ypt/1000,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Nickel Price kUSD/Ton','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    medianNickelVal=ypt(10,1);
elseif(itype==124)
    plot(xpt,ypt/100,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Rubber Price USD/lb','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    medianRubberVal=ypt(10,1)/100;
elseif(itype==125)
    plot(xpt,ypt/100,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Sugar Price USD/lb','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    medianSugarVal=ypt(10,1)/100;
elseif(itype==126)
    plot(xpt,ypt,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('UrbanHomeFoodPriceIndex','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    maxval=360;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    medianfoodVal=ypt(10,1);
 elseif(itype==127)
    plot(xpt,ypt,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('PPIFoodPriceIndex','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    minval=80;
    maxval=300;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    medianPPIFoodVal=ypt(10,1);
 elseif(itype==128)
    plot(xpt,ypt,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('PPIDieselPriceIndex','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    medianPPIDieselVal=ypt(10,1);
 elseif(itype==129)
    plot(xpt,ypt,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Bologna','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    medianBolognaVal=ypt(10,1);
 elseif(itype==130)
    plot(xpt,ypt,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Ham','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    minval=2;
    maxval=6;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    medianHamVal=ypt(10,1);
  elseif(itype==131)
    plot(xpt,ypt,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Chuck Roast','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    medianCroastVal=ypt(10,1);
  elseif(itype==132)
    plot(xpt,ypt,'r','LineWidth',2);
    title(titlestr3)
    xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
    ylabel('Bacon Price Per lb','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    medianBaconVal=ypt(10,1);
   elseif(itype==133)
     plot(xpt,ypt,'r','LineWidth',2);
     title(titlestr3)
     xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
     ylabel('Soybean Index wrt 1982','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    medianSoybeanVal=ypt(10,1);
   elseif(itype==134)
     plot(xpt,ypt,'r','LineWidth',2);
     title(titlestr3)
     xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
     ylabel('Flour Price USD/lb','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    maxval=1.0;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    medianFlourVal=ypt(10,1);
   elseif(itype==135)
     plot(xpt,ypt,'r','LineWidth',2);
     title(titlestr3)
     xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
     ylabel('Cooking Oil Index','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    maxval=500;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    medianCoilVal=ypt(10,1);
   elseif(itype==136)
     plot(xpt,ypt,'r','LineWidth',2);
     title(titlestr3)
     xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
     ylabel('Whole Chicken Price-USD/lb','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    maxval=3;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    medianWHChickVal=ypt(10,1);
   elseif(itype==137)
     plot(xpt,ypt,'r','LineWidth',2);
     title(titlestr3)
     xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
     ylabel('Farm PPI','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    maxval=300;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    medianFarmIndexVal=ypt(10,1);
  elseif(itype==138)
     plot(xpt,ypt,'r','LineWidth',2);
     title(titlestr3)
     xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
     ylabel('PPI cattle wrt 1982','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    maxval=450;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    medianCattleIndexVal=ypt(10,1);
 elseif(itype==139)
     plot(xpt,ypt,'r','LineWidth',2);
     title(titlestr3)
     xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
     ylabel('PPI Tomatoes wrt 1982','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    medianTomatoesIndexVal=ypt(10,1);
 elseif(itype==140)
     plot(xpt,ypt,'r','LineWidth',2);
     title(titlestr3)
     xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
     ylabel('PPI Corn wrt 1982','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    medianCornIndexVal=ypt(10,1);
 elseif(itype==141)
     plot(xpt,ypt,'r','LineWidth',2);
     title(titlestr3)
     xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
     ylabel('PPI Raw Milk wrt 1982','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    maxval=250;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    medianMilkIndexVal=ypt(10,1);
 elseif(itype==142)
     plot(xpt,ypt,'r','LineWidth',2);
     title(titlestr3)
     xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
     ylabel('PPI Fruit wrt 1982','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    medianFruitIndexVal=ypt(10,1);
 elseif(itype==143)
     plot(xpt,ypt,'r','LineWidth',2);
     title(titlestr3)
     xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
     ylabel('PPI Cabbage wrt 1982','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    maxval=500;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    medianCabbageIndexVal=ypt(10,1);
 elseif(itype==144)
     plot(xpt,ypt,'r','LineWidth',2);
     title(titlestr3)
     xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
     ylabel('PPI Rice wrt 2004','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    maxval=300;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    medianRiceIndexVal=ypt(10,1);
 elseif(itype==145)
     plot(xpt,ypt,'r','LineWidth',2);
     title(titlestr3)
     xlabel('Cumil Pct','FontWeight','bold','FontSize',12,'FontWeight','bold');
     ylabel('PPI Citrus Fruits wrt 1982','FontWeight','bold','FontSize',12,'FontWeight','bold');
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
    maxval=500;
    set(gca,'YLim',[minval maxval]);
    set(gca,'Color', [0.3 0.3 0.3]);
    set(gca,'XGrid','on','GridColor',[1 1 1]);
    set(gca,'YGrid','on','GridColor',[1 1 1]);
    medianCitrusIndexVal=ypt(10,1);
end
% Set up an axis for writing text at the bottom of the chart
newaxesh=axes('Position',[0 0 1 1]);
set(newaxesh,'XLim',[0 1],'YLim',[0 1]);
tx1=.10;
ty1=.05;
tx2=.10;
ty2=.02;
if(itype==1)
    txtstr1='Monthly Unemployment Rate-1948-2025';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Median Unemployment Rate %=',num2str(meanUnrate,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==2)
    txtstr1='Sticky CPI Data-1968-2025';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
     medianSCPI=3.38;
    txtstr2=strcat('Median CPI Rate %=',num2str(medianSCPI,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==3)
    txtstr1='Labor Force Participation Rate By Age Groups';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Mean Rate All=',num2str(meanPartAll,4),...
        '-Ages 25-54=',num2str(meanPart_25_54,4),...
        '-Ages 55+=',num2str(meanPart_55,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==4)
    txtstr1='Single Home Delinquency Rate-1991-2025';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Median Rate =',num2str(meanDelRate,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==5)
    txtstr1='Home Ownership Rate 1965-2025';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    txtstr2=strcat('Median Ownership Rate =',num2str(meanHomeOwnershipRate,4),'--%');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
    ab=1;
elseif(itype==6)
    txtstr1='Industrial Production with 2017 baseline';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    SG6=FRObj.SG6;
    txtstr2=strcat('Median Production =',num2str(meanProdRate,4),'-Scaled to 2017-Growth Rate-',num2str(SG6));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==7)
    txtstr1='Real Median Family Income in thousands of USD';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    SG7=FRObj.SG7;
    txtstr2=strcat('Median Income =',num2str(meanIncome,4),'-USD in thousands','-AnnualGrowthRate=',num2str(SG7),'-in pct');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
 elseif(itype==8)
    txtstr1='CBOE Volitility Index Cumil Distribution-1990-2025';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    txtstr2=strcat('Median Vix Index =',num2str(meanVix,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==9)
    txtstr1='Consumer Confidence-1978-2025';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    txtstr2=strcat('Median Consumer Confidence Index =',num2str(meanCC,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==10)
    txtstr1='Days On Market For House Sale 3016-2025';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    txtstr2=strcat('Median Days  =',num2str(meanDaysOnMarket,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==11)
    txtstr1='Median 10 Year Bond Yields % 1953-2025';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    txtstr2=strcat('Median Bond Yield =',num2str( mean10YearBondYield,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==12)
    txtstr1='Median U2 Rate %-1967-2025';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    medianU2=2.7;
    txtstr2=strcat('Median U2 Rate =',num2str(medianU2,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==13)
    txtstr1='Median GDP Trillion USD-1947-2025';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    SG13=FRObj.SG13;
    txtstr2=strcat('Median GDP =',num2str(meanGDP,4),'-Trillion USD','-AnnualGrowthRate=',num2str(SG13),'-in pct');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==14)
    txtstr1='Distribution Based on 1947-2025 data';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    SG14=FRObj.SG14;
    txtstr2=strcat('Median GDPPerCap =',num2str(meanGDPPerCap,4),'-Thousands USD','-AnnualGrowthRate=',num2str(SG14),'-in pct');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==15)
    txtstr1='Median 2 Year Bond Yields % - 1976-2025';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    txtstr2=strcat('Median Bond Yield =',num2str(mean2YearBondYield,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==16)
    txtstr1='Median Unemployment Claims 1967-2025';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    txtstr2=strcat('Median Initial Claims =',num2str(meanClaims,6),'-Millions');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==17)
    txtstr1='Median Continued Unemployment Claims %- 1967-2025';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Median Continued Claims =',num2str(meanClaims,8));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==18)
    txtstr1='Mean/Median Non Farm Job Openings in thousands';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Median =',num2str(meanNFJO,5));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==19)
    txtstr1='Median Construction Job Openings in thousands-2000-2025';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    % tx2=.10;
    % ty2=.03;
    txtstr2=strcat('Median =',num2str(meanCJ,5));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
    ab=1;
elseif(itype==20)
    txtstr1='Median Manufacturing Job Openings 2000-2025';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    % tx2=.10;
    % ty2=.03;
    txtstr2=strcat('Median =',num2str(meanMFacVal,6));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==21)
    txtstr1='Median Professional Job Openings 2000-2025';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    txtstr2=strcat('Median =',num2str(meanProfOpenVal,6));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==22)
    txtstr1='Median Health Care Job Openings 2000-2025';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    txtstr2=strcat('Median =',num2str(meanHCOpenVal,6));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==23)
    txtstr1='Median Government Job Openings 2000-2025 ';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    txtstr2=strcat('Median =',num2str(meanGovOpenVal,7));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==24)
    txtstr1='Mean/Median Personal Income in thousands';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    SG24=FRObj.SG24;
    txtstr2=strcat('Median =',num2str(meanRealPIncomeVal,6),...
        '-Median =',num2str(medianRealPIncomeVal,6),'-Annual Rise-',num2str(SG24));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==25)
    txtstr1='Median Bond Interest Rate Diff-1976-2025';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Median =',num2str(meanRateDiffVal,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==26)
    txtstr1='Mean/Median Visa Discretionary Spending Index';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    txtstr2=strcat('Mean =',num2str(meanDiscVal,4),...
        '-Median =',num2str(medianDiscVal,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==27)
    txtstr1='Median Shiller House Price Index 1987-2025';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    SG27=FRObj.SG27;
    txtstr2=strcat('Median =',num2str(medianCSVal,4),'-Annual CSI Increase-',num2str(SG27));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==28)
    txtstr1='Mean/Median Wage in 1982-1984 dollars';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    SG28=FRObj.SG28;
    txtstr2=strcat('Median =',num2str(medianWageVal,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==29)
    txtstr1='Fiscal Year US GDP In Billions USD';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    SG29=FRObj.SG29;
    txtstr2=strcat('Median GDP =',num2str(medianGDPVal,6),'-USD in Billions','-AnnualGrowthRate=',num2str(SG29),'-in pct');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==30)
    txtstr1='Mean/Median Debt Vs GDP For 1966-2025';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    SG30=FRObj.SG30;
    txtstr2=strcat('Mean =',num2str(medianDebtVal,6));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==31)
    txtstr1='Median US Budget Surplus-1980-2025';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    txtstr2=strcat('Median =',num2str(medianSurplusVal,4),'-Deficit Fraction =',num2str(FRObj.BudgetDeficitFraction));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==32)
    txtstr1='Median Fed Budget Surplus-1980-202';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    txtstr2=strcat('-Median =',num2str(medianOutlayVal,4));
    SG32=FRObj.SG32;
    txtstr2=strcat('Mean GDP =',num2str(meanOutlayVal,6),'-Pct GDP','-AnnualGrowthRate=',num2str(SG32),'-in pct');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==33)
    txtstr1='Mean/Median Fed Receipts As % GDP-';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    SG33=FRObj.SG33;
    txtstr2=strcat('Mean GDP =',num2str(meanReceiptVal,4),'-Pct GDP','-AnnualGrowthRate=',num2str(SG33),'-in pct');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==34)
    txtstr1='Mean/Median Federal Debt Held By Public';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    SG34=FRObj.SG34;
    txtstr2=strcat('Mean GDP =',num2str(meanDebtVal,6),'-Time Period 1970-2025');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==35)
    txtstr1='Mean/Median Interest On Federal Dept';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    SG35=FRObj.SG35;
    txtstr2=strcat('Mean GDP =',num2str(meanInterestVal,4),'-Pct Debt','-AnnualGrowthRate=',num2str(SG35),'-in pct');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==36)
    txtstr1='Mean/Median Market Value-Trillion USD';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    SG36=FRObj.SG36;
    medianTDebtVal=FRObj.CurrentMedianValue;
    txtstr2=strcat('Mean GDP =',num2str(meanTDebtVal,4),'-Median=',num2str(medianTDebtVal,4),...
        '-Time Period 1942-2025');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==37)
    txtstr1='Median -Auto Inventory during period 1993-2025';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    SG37=FRObj.GrowthRateAll(37);
    medianInventoryVal=FRObj.CurrentMedianValue;
    txtstr2=strcat('Median =',num2str(meanInventoryVal,6));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==38)
    txtstr1='Median Foreign Auto Sales';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    SG38=FRObj.GrowthRateAll(38);
    medianFSalesVal=FRObj.CurrentMedianValue;
    txtstr2=strcat('Mean =',num2str(medianFSalesVal,6),'-for the period 1967-2025');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
    ab=1;
elseif(itype==39)
    txtstr1='Median Total Vehicle Sales-1976-2025';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    SG39=FRObj.GrowthRateAll(39);
    medianTSalesVal=FRObj.CurrentMedianValue;
    txtstr2=strcat('Median =',num2str(medianTSalesVal,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==40)
    txtstr1='Median Domestic Auto Production-1993-2025';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    SG40=FRObj.GrowthRateAll(40);
    txtstr2=strcat('Median =',num2str(meanDomProdVal,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==41)
    txtstr1='Median US Auto Exports';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    SG41=FRObj.GrowthRateAll(41);
    txtstr2=strcat('Mean =',num2str(meanAutoExportsVal,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==42)
    txtstr1='Mean/Median Vehicle Miles Travelled';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    SG42=FRObj.SG42;
    txtstr2=strcat('Median Vehicle Miles =',num2str(medianVehMilesVal,6),'-AnnualGrowthRate=',num2str(SG42),'-in pct');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==43)
    txtstr1='Mean/Median FTI-Base Year is 2000 Index is set 100';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    txtstr2=strcat('Median =',num2str(medianFTIVal,5));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==44)
    txtstr1='Mean/Median Rail Car Loads';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    SG44=FRObj.SG44;
    txtstr2=strcat('Median Loads =',num2str(medianRailCarVal,5),'-AnnualGrowthRate=',num2str(SG44),'-in pct');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==45)
    txtstr1='Mean/Median Airline Load Factors';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    SG45=FRObj.SG45;
    txtstr2=strcat('Median Air Load Factor =',num2str(medianAirLoadVal,5));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==46)
    txtstr1='Mean/Median Available Seat Milles in Millions';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    SG46=FRObj.SG46;
    txtstr2=strcat('Median Seat Miles Load Factor =',num2str(medianASMVal,5),'-AnnualGrowthRate=',num2str(SG46),'-in pct');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==47)
    txtstr1='Mean/Median Barrels Of Petrol-In Billions';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    txtstr2=strcat('Median =',num2str(medianPetrolVal,5));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==48)
    txtstr1='Median House Starts-Thousands-1958-2025';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    SG48=FRObj.SG48;
    txtstr2=strcat('Median =',num2str(meanHouseVal,5));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==49)
    txtstr1='Median Debt Service Payments %  1980-2025';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    txtstr2=strcat('Median =',num2str(meanMDSPVal,5));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==50)
    txtstr1='Mean/Median Vacant Unit in Millions';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    txtstr2=strcat('Mean =',num2str(meanVacantVal,5),...
        '-Median =',num2str(medianVacantVal,5));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==51)
    txtstr1='Mean/Median US Patents in Thousands';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    SG51=FRObj.GrowthRateAll(51);
    txtstr2=strcat('Mean =',num2str(meanPatentsVal,4),...
        '-Median =',num2str(medianPatentsVal,4),'-Increase in Patents-',num2str(SG51),'-%');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==52)
    txtstr1='Median Capacity Utilization-1967-2025';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    medianTCUValVal=FRObj.CurrentMedianValue;
    txtstr2=strcat('Median =',num2str(medianTCUValVal,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==53)
    txtstr1='Median Semiconductor Capacity Utilization-1972-2025';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    SG53=FRObj.GrowthRateAll(53);
    medianSemiVal=FRObj.CurrentMedianValue;
    txtstr2=strcat('Median =',num2str(medianSemiVal,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==54)
    txtstr1='Median Defense Capacity Utilization-1947-2025';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    SG54=FRObj.GrowthRateAll(54);
    medianDefenseVal=FRObj.CurrentMedianValue;
    txtstr2=strcat('Median =',num2str(medianDefenseVal,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==55)
    txtstr1='Mean/Median Total Revenue All Hospitals Billions USD';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    SG55=FRObj.GrowthRateAll(55);
    txtstr2=strcat('Mean =',num2str(meanTotRevenueVal,4),...
        '-Median =',num2str(medianTotRevenueVal,4),'-Growth Rate=',num2str(SG55),'-%');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==56)
    txtstr1='Mean/Median Pharma Price Index';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    txtstr2=strcat('Mean =',num2str(meanPriceVal,5),...
        '-Median =',num2str(medianPriceVal,5));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==57)
    txtstr1='Median Producer Price Index-1913-2026';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    txtstr2=strcat('Median =',num2str(medianPPIVal,5));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==58)
    txtstr1='Median Flex CPI Value-1968-2025';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    txtstr2=strcat('Median =',num2str(meanFCPIVal));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==59)
    txtstr1='Median Housing Completions In Thousands-1968-2025';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    SG59=FRObj.SG59;
    txtstr2=strcat('Median =',num2str(meanHCompVal));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==60)
    txtstr1='Mean/Median Retails Sales In Billions USD';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    txtstr2=strcat('Mean =',num2str(meanSalesVal,5));
    SG60=FRObj.SG60;
    txtstr2=strcat('Mean Sales =',num2str(meanSalesVal,5),'-Retail Sales','-AnnualGrowthRate=',num2str(SG60),'-in pct');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==61)
    txtstr1='Mean/Median E Commerce Retails Sales In Billions USD';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    SG61=FRObj.SG61;
    txtstr2=strcat('Mean Sales =',num2str(meanSalesVal,5),'-Retail Sales','-AnnualGrowthRate=',num2str(SG61),'-in pct');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==62)
    txtstr1='Inventory To Sales Ratio-1992-2025';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    txtstr2=strcat('Mean =',num2str(meanSRatioVal,5));
    SG62x=FRObj.SG62x;
    txtstr2=strcat('Mean Ratio =',num2str(meanSRatioVal,5),'-','-Inventory/Sales=',num2str(SG62x),'-in pct');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==63)
    txtstr1='Median Retail Inventories Billions of USD';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    SG63=FRObj.SG63;
    txtstr2=strcat('Median Inventory =',num2str(meanInventoryVal,5),'-USD','-AnnualGrowthRate=',num2str(SG63),'-in pct');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==64)
    txtstr1='Mean/Median Retail Used Car Sales Billions of USD';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    SG64=FRObj.SG64;
    txtstr2=strcat('Median Sales=',num2str(medianSalesVal,5),'-USD','-AnnualGrowthRate=',num2str(SG64),'-in pct');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==65)
    txtstr1='Mean/Median Restaurant Sales Billions of USD';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    SG65=FRObj.SG65;
    txtstr2=strcat('Mean =',num2str(meanRSalesVal,5),'-Annual Rate Of Change-',num2str(SG65),'-%');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==66)
    txtstr1='Mean/Median Furniture Sales Billions of USD';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    SG66=FRObj.SG66;
    txtstr2=strcat('Mean Sales=',num2str(meanFSalesVal,5),'-Annual Rate Of Change-',num2str(SG66),'-%');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==67)
    txtstr1='Mean/Median Manufacturing Sales Trillions of USD';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    SG67=FRObj.SG67;
    txtstr2=strcat('Mean Sales=',num2str(medianMSalesVal,5),...
         '--Yearly Rate of Change-',num2str(SG67),'-%');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==68)
    txtstr1='Mean/Median Dealer New Car Sales Billions of USD';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    SG68=FRObj.SG68;
    txtstr2=strcat('Mean =',num2str(meanSalesVal,5), '--Yearly Rate of Change-',num2str(SG68),'-%');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==69)
    txtstr1='Mean/Median Full Serve Restaurant Sales Billions of USD';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    SG69=FRObj.SG69;
    txtstr2=strcat('Mean =',num2str(meanSalesVal,5),' Yearly Rate of Change-',num2str(SG69),'-%');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==70)
    txtstr1='Mean/Median Retail Gas Sales Billions of USD';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    SG70=FRObj.SG70;
    txtstr2=strcat('Mean =',num2str(meanGasSalesVal,5),'Yearly Rate of Change-',num2str(SG70),'-%');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==71)
    txtstr1='Mean/Median Auto Parts Saled Billions of USD';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    SG71=FRObj.SG71;
    txtstr2=strcat('-Median =',num2str(medianAutoPartsVal,5),' Yearly Rate of Change-',num2str(SG71),'-%');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==72)
    txtstr1='Mean/Median Lead Index Pct';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    txtstr2=strcat('Mean =',num2str(meanLIVal,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==73)
    txtstr1='Mean/Median Recession Flag';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    txtstr2=strcat('Mean =',num2str(meanRflagVal,4),...
        '-Median =',num2str(medianRflagVal,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==74)
    txtstr1='Mean/Median Economic Indicator wrt 2007';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    txtstr2=strcat('Mean =',num2str(meanIndicatorVal));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==75)
    txtstr1='Mean/Median Bank Assets in Trillions Of USD';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    SG75=FRObj.SG75;
    txtstr2=strcat('Mean =',num2str(meanBankAssetsVal,5));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==76)
    txtstr1='Mean/Median Credit Card Debt in Trillions Of USD';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    SG76=FRObj.SG76;  
    txtstr2=strcat('Mean =',num2str(meanCreditCardDebtVal,5));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==77)
    txtstr1='Mean/Median % Non Performing Loans';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    txtstr2=strcat('Mean =',num2str(meanLPerfVal,5));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==78)
    txtstr1='Mean/Median US Population';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    SG78=FRObj.SG78;
    txtstr2=strcat('Mean =',num2str(meanPopVal,5),...
        '-Median =',num2str(medianPopVal,5),'-Avg Annual Growth Rate-',num2str(SG78),'-in %');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==79)
    txtstr1='Mean/Median US Households in Millions';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    txtstr2=strcat('Mean =',num2str(meanHHVal,5),...
        '-Median =',num2str(medianHHVal,5));
    SG79=FRObj.SG79;
    txtstr2=strcat('Mean =',num2str(meanHHVal,5),...
        '-Median =',num2str(medianHHVal,5),'-Avg Annual Growth Rate-',num2str(SG79),'-in %');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==80)
    txtstr1='Mean/Median US Pop Over 55';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    SG80=FRObj.SG80;
    txtstr2=strcat('Mean =',num2str(meanP55Val,5),...
        '-Median =',num2str(medianP55Val,5),'-Avg Annual Growth Rate-',num2str(SG80),'-in %');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==81)
    txtstr1='Mean/Median US Pop Between 25 and 54';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    SG81=FRObj.SG81;
    txtstr2=strcat('Mean =',num2str(meanP2554Val,5),...
        '-Median =',num2str(medianP2554Val,5),'-Annual Growth Rate-',num2str(SG81),'-%');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==82)
    txtstr1='Mean/Median US Families With Children Under 18';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    SG82=FRObj.SG82;
    txtstr2=strcat('Mean =',num2str(meanChildVal,5),...
        '-Median =',num2str(medianChildVal,5),'-Annual Rate of Change-',num2str(SG82),'-%');    
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==83)
    txtstr1='Mean/Median Black Population';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    SG83=FRObj.SG83;
    txtstr2=strcat('Mean =',num2str(meanBlackVal,5),...
        '-Median =',num2str(medianBlackVal,5),'-Annual Growth Black Pop-',num2str(SG83),'-%');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==84)
    txtstr1='Mean/Median White Population';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    SG84=FRObj.SG84;
    txtstr2=strcat('Mean =',num2str(meanWhiteVal,5),...
        '-Median =',num2str(medianWhiteVal,5),'-Annual Growth White Pop-',num2str(SG84),'-%');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==85)
    txtstr1='Mean/Median Hispanic Population';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    SG85=FRObj.SG85;
    txtstr2=strcat('Mean =',num2str(meanHispVal,5),...
        '-Median =',num2str(medianHispVal,5),'-Annual Growth Hispanic Pop-',num2str(SG85),'-%');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==86)
    txtstr1='Mean/Median Female Employment Ratio';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    SG86=FRObj.SG86;
    txtstr2=strcat('Median =',num2str(medianFERatioVal,5));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==87)
    txtstr1='Median Nasdaq Volatility-2001-2025';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    txtstr2=strcat('Median =',num2str(meanVolaVal,5));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==88)
    txtstr1='Median US Leading Indicators-1982-2020';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    txtstr2=strcat('Median =',num2str(medianLeadingVal,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==89)
    txtstr1='Median Fed 3 month Bond Yields- 1981-2025';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    txtstr2=strcat('Median =',num2str(mean3MonthBondYieldVal,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==90)
    txtstr1='Median TDSP-1980-2025';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    txtstr2=strcat('Mean =',num2str(meanTDSPVal,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==91)
    txtstr1='Median CDSP - 1980-2025';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    txtstr2=strcat('Median =',num2str(meanCDSPVal,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==92)
    txtstr1='Median Consumer Disp Income-1959-2025';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    SG92=FRObj.SG92;
    txtstr2=strcat('Median =',num2str(medianRDIncVal,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==93)
    txtstr1='Median Personal Consumption-1959-2025';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    SG93=FRObj.SG93;
    txtstr2=strcat('Median =',num2str(medianPDIncVal,4),'-Annual Increase Personal Comsumption=',num2str(SG93),'%');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==94)
    txtstr1='Median Auto Sales-1967-2025';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    SG94=100*GrowthRateAll(94,1);
    txtstr2=strcat('Median =',num2str(medianSalesVal,4),'Annual Growth Rate--',num2str(SG94),'-%');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==95)
    txtstr1='Mean/Median House Price Index';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    SG95=100*GrowthRateAll(95,1);
    txtstr2=strcat('Mean =',num2str(meanPriceVal,4),...
        '-Median =',num2str(medianPriceVal,4),'Annual Growth Rate--',num2str(SG95),'-%');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==96)
    txtstr1='Median Credit Card Balance-2012-2025';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    SG96=100*GrowthRateAll(96,1);
    txtstr2=strcat('Mean =',num2str(meanBalanceVal,4),...
        '-Median =',num2str(medianBalanceVal,4),'-Credit Rate Of Growth-',num2str(SG96),'-%');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==97)
    txtstr1='Median Sum New Mortgages';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    SG97=100*GrowthRateAll(97,1);
    txtstr2=strcat('-Median =',num2str(medianSumVal,4),'-Mortgage Rate Of Growth-',num2str(SG97),'-%');
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==98)
    txtstr1='Median Past Due Loans';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    txtstr2=strcat('-Median =',num2str(medianPastDueVal,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==99)
    txtstr1='Mean/Median Credit Score';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    txtstr2=strcat('Mean =',num2str(meanScoreVal,4),...
        '-Median =',num2str(medianScoreVal,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==100)
    txtstr1='Mean/Median HomeEquity Loans';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    txtstr2=strcat('Mean =',num2str(meanEquityVal/1000,4),...
        '-Median =',num2str(medianEquityVal/1000,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==101)
    txtstr1='Median USD To BP Conversion Rate-1971-2025';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    txtstr2=strcat('Median =',num2str(meanRate1,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==102)
    txtstr1='Median USD To Broad Conversion Rate-';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    medval='105.1';
    txtstr2=strcat('Median =',num2str(medval));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==103)
    txtstr1='Median USD Japanese Yen Conversion Rate';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    txtstr2=strcat('Median =',num2str(meanRate3,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==105)
    txtstr1='Mean/Median USD CPI All Growth Rate';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    tx2=.10;
    ty2=.03;
    txtstr2=strcat('Mean =',num2str(meancpiRate,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==107)
    txtstr1='Median Gas Price - 1990-2025';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Median =',num2str(medianGasPriceVal,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==108)
    txtstr1='Median Brent Oil Price USD - 1987-2025';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Median =',num2str(medianBrentPriceVal,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==109)
    txtstr1='Median Egg Price USD - 1980-2025';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Median =',num2str( medianEggPriceVal,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==110)
    txtstr1='Median Ground Beef Price USD - 1984-2025';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Median =',num2str(medianBeefPriceVal,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==111)
    txtstr1='Median Electricity Price - 1978-2025';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Median =',num2str(medianElectricityPriceVal,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==112)
    txtstr1='Median WTI Price - 1946-2025';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Median =',num2str(medianWTIPriceVal,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==113)
    txtstr1='Median Natural Gas Price - 1997-2025';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Median =',num2str(medianNatGasPriceVal,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==114)
    txtstr1='Median Copper Price - 1992-2025';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Median =',num2str(medianCopperVal,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==115)
    txtstr1='Median Diesel Price - 1994-2025';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Median =',num2str(medianDieselVal,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==116)
    txtstr1='Median Jet Fuel Price - 1990-2025';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Median =',num2str(medianJetVal,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==117)
    txtstr1='Median Aluminum Price - 1992-2025';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Median =',num2str(medianAlumVal,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==118)
    txtstr1='Median Cocoa Price - 1992-2025';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Median =',num2str(medianCocoaVal,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==119)
    txtstr1='Median Energy Index - 1992-2025';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Median =',num2str(medianEnergyIndexVal,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==120)
    txtstr1='Median Bread Price - 1980-2025';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Median =',num2str(medianBreadVal,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==121)
    txtstr1='Median Wheat Price USD/Ton - 1992-2025';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Median =',num2str(medianWheatVal,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==122)
    txtstr1='Median Uranium Price USD/lb - 1992-2025';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Median =',num2str(medianU2Val,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==123)
    txtstr1='Median Nickel Price - 1992-2025';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Median =',num2str(medianNickelVal/1000,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==124)
    txtstr1='Median Rubber Price - 1992-2025';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Median =',num2str(medianRubberVal,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==125)
    txtstr1='Median Sugar Price - 1992-2025';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Median =',num2str(medianSugarVal,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==126)
    txtstr1='Urban Home Food Price Index - 1952-2025';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Median =',num2str(medianfoodVal,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==127)
    txtstr1='PPI Food Index - 1984-2025';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Median =',num2str(medianPPIFoodVal,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==128)
    txtstr1='PPI Diesel Index - 1973-2026';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Median =',num2str(medianPPIDieselVal,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==129)
    txtstr1='Bologna Prices - 1980-2019';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Median =',num2str(medianBolognaVal,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==130)
    txtstr1='Boneless Ham Prices - 1991-2025';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Median =',num2str(medianHamVal,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==131)
    txtstr1='Chuck Roast Prices - 1989-2025';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Median =',num2str(medianCroastVal,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==132)
    txtstr1='Bacon Prices - 1980-2025';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Median =',num2str(medianBaconVal,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==133)
    txtstr1='Soybean Index - 1947-2025';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Median =',num2str(medianSoybeanVal,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==134)
    txtstr1='Flour Prices - 1980-2025';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Median =',num2str(medianFlourVal,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==135)
    txtstr1='Cooking Oil Index - 1947-2025';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Median =',num2str(medianCoilVal,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==136)
    txtstr1='Whole Chicken Prices - 1980-2025';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Median =',num2str(medianWHChickVal,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==137)
    txtstr1='PPI Farm - 1913-2025';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Median =',num2str(medianFarmIndexVal,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==138)
    txtstr1='PPI Cattle - 1947-2025';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Median =',num2str(medianCattleIndexVal,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==139)
    txtstr1='PPI Tomatoes - 1947-2025';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Median =',num2str(medianTomatoesIndexVal,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==140)
    txtstr1='PPI Corn - 1947-2025';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Median =',num2str(medianCornIndexVal,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==141)
    txtstr1='PPI Raw Milk - 1973-2025';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Median =',num2str(medianMilkIndexVal,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==142)
    txtstr1='PPI Fruit - 1926-2025';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Median =',num2str(medianFruitIndexVal,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==143)
    txtstr1='PPI Cabbage - 1947-2025';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Median =',num2str(medianCabbageIndexVal,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==144)
    txtstr1='PPI Rice - 2004-2025';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Median =',num2str(medianRiceIndexVal,4));
    txt2=text(tx2,ty2,txtstr2,'FontWeight','bold','FontSize',12);
elseif(itype==145)
    txtstr1='PPI Citrus Fruits -1982-2025';
    txt1=text(tx1,ty1,txtstr1,'FontWeight','bold','FontSize',12);
    txtstr2=strcat('Median =',num2str(medianCitrusIndexVal,4));
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
titlestr=char(titlestr3);
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
if(itype==4)
    ab=1;
elseif(itype==145)
    ab=2;
end
close('all')
%% Save the name of the image file created

end