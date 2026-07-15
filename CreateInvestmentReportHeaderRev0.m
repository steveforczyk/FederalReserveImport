function CreateInvestmentReportHeaderRev0
% This function will create the initial "boilerplate" header info
% for the stock investment report header
% Written By: Stephen Forczyk
% Created: Feb 1-,2025
% Revised: 
% Classification: Unclassified

global ActivityFile1 ActivityFile2 ActivityFile3;

global total_comissions divsum dataYear;
global RCoeff RCoeffNames;
global IRAStockList2024 TableList TableFileName BollingerList;
global EquityAAPL EquityABBV EquityALB EquityAMD EquityAMZN EquityCAT;
global EquityCCL EquityCDNS EquityCMI EquityDBX EquityDELL EquityDOCU;
global EquityENB EquityET EquityGE EquityGOOG EquityGSL EquityHII;
global EquityHWM EquityLMT EquityMSFT EquityNVDA EquityNVO EquityOC;
global EquityPAGP EquityPFE EquityPHM EquityPLTR EquityRCL EquityRIO;
global EquitySMCI EquityTHC EquityTOL EquityVZ EquityXOM EquityYOU;
global EquityAAPLTT EquityABBVTT EquityALBTT EquityAMDTT EquityAMZNTT EquityCATTT;
global EquityCCLTT EquityCDNSTT EquityCMITT EquityDBXTT EquityDELLTT EquityDOCUTT;
global EquityENBTT EquityETTT EquityGETT EquityGOOGTT EquityGSLTT EquityHIITT;
global EquityHWMTT EquityLMTTT EquityMSFTTT EquityNVDATT EquityNVOTT EquityOCTT;
global EquityPAGPTT EquityPFETT EquityPHMTT EquityPLTRTT EquityRCLTT EquityRIOTT;
global EquitySMCITT EquityTHCTT EquityTOLTT EquityVZTT EquityXOMTT EquityYOUTT;
global WorkBollTT BollAAPLTT BollABBVTT BollALBTT BollAMDTT BollAMZNTT;
global BollCATTT BollCCLTT BollCDNSTT BollCMITT BollDBXTT BollDELLTT BollDOCUTT;
global BollENBTT BollETTT BollGETT BollGOOGTT BollGSLTT BollHIITT BollNVOTT;
global BollHWMTT BollLMTTT BollMSFTTT BollNVDATT BollOCTT BollPAGPTT;
global BollPFETT BollPHMTT BollPLTRTT BollRCLTT BollRIOTT BollSMCITT;
global BollTHCTT BollTOLTT BollVZTT BollXOMTT BollYOUTT;
global RSIStats RSILowLimit RSIHighLimit;
global RSIAAPLTT RSIABBVTT RSIALBTT RSIAMDTT RSIAMZNTT RSICATTT RSICCLTT;
global RSICDNSTT RSICMITT RSIDBXTT RSIDELLTT RSIDOCUTT RSIENBTT RSIETTT;
global RSIGETT RSIGOOGTT RSIGSLTT RSIHIITT RSIHWMTT RSILMTTT ;
global RSIMSFTTT RSINVDATT RSINVOTT RSIOCTT RSIPAGPTT RSIPFETT;
global RSIPHMTT RSIPLTRTT RSIRCLTT RSIRIOTT RSISMCITT RSITHCTT;
global RSITOLTT RSIVZTT RSIXOMTT RSIYOUTT;
global RMonthAAPL RMonthABBV RMonthALB RMonthAMD RMonthAMZN RMonthCAT;
global RMonthCCL RMonthCDNS RMonthCMI RMonthDBX RMonthDELL RMonthDOCU;
global RMonthENB RMonthET RMonthGE RMonthGOOG RMonthGSL RMonthHII RMonthHWM;
global RMonthLMT RMonthMSFT RMonthNVDA RMonthNVO RMonthOC  RMonthPAGP;
global RMonthPFE RMonthPHM RMonthPLTR RMonthRCL RMonthRIO RMonthSMCI;
global RMonthTHC RMonthTOL RMonthVZ RMonthXOM RMonthYOU;
global StockStats StockHdrs SheetRecords sheets StockList StockSymbols;
global StockTable MeasurementDate StockNames RCoeff1D StockCorrTable SortedStockTable;
global Months HeatMapTable XCenters YCenters;


global RptGenPresent iCreatePDFReport pdffilename rpt chapter tocc;
global JpegCounter JpegFileList;


global fid;
global widd2 lend2;
global initialtimestr igrid ijpeg ilog imovie;
global vert1 hor1 widd lend;
global vert2 hor2 machine;
global chart_time;
global Fz1 Fz2;
global idirector mov izoom iwindow;
global matpath GOES16path;
global jpegpath tiffpath;
global smhrpath excelpath ascpath;
global ipowerpoint PowerPointFile scaling stretching padding;
global ichartnum;
global ColorList RGBVals ColorList2 xkcdVals LandColors;
global orange bubblegum brown brightblue;
% additional paths needed for mapping
global matpath1 mappath matlabpath pdfpath;
global jpegpath northamericalakespath logpath pdfpath govjpegpath;

global mappath gridpath countyshapepath nationalshapepath summarypath;
global DayMonthNonLeapYear DayMonthLeapYear CalendarFileName;


% Set some flags
JpegCounter=0;
import mlreportgen.dom.*;
import mlreportgen.report.*;
import mlreportgen.utils.*
% Create the report
    eval(['cd ' pdfpath(1:length(pdfpath)-1)]);
    rpt = Report(pdffilename,"pdf");
    open(rpt);
    rptstr1=strcat('////PDF file created for this run is-',pdffilename,'.pdf ////');
    fprintf(fid,'%s\n',rptstr1);
    rptstr2=strcat('PDF report can be found at-',pdfpath);
    fprintf(fid,'%s\n',rptstr2);
    rpt.Layout.Landscape = true;
    pageLayoutObj = PDFPageLayout;
    pageLayoutObj.PageSize.Orientation = "landscape";
    pageLayoutObj.PageSize.Height = "8.5in";
    pageLayoutObj.PageSize.Width = "11in";
    pageLayoutObj.PageMargins.Top = "0.5in";
    pageLayoutObj.PageMargins.Bottom = "0.5in";
    pageLayoutObj.PageMargins.Left = "0.5in";
    pageLayoutObj.PageMargins.Right = "0.5in";
    pageLayoutObj.PageMargins.Header = "0.3in";
    pageLayoutObj.PageMargins.Footer = "0.3in";
    add(rpt,pageLayoutObj)
    eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
% add a title page
    tp = TitlePage();
    tp.Title = 'PortfolioAnnualAnalysisReport';
    tp.Subtitle = strcat('User Selected Data Year-',num2str(dataYear));
   % tp.Image = which('GOES-Logo.jpg');
    tp.Author = 'Stephen Forczyk';
    tp.Publisher = 'FRC';
    tp.PubDate = date();
    add(rpt,tp);
% add a table of contents
    tocc = TableOfContents;
    tocc.Title = Text('Table of Contents');
    tocc.Title.Color = 'blue';
    tocc.TOCObj.NumberOfLevels = 2; 
    add(rpt,tocc);
% Create Chapter 1 with general program information
    chapter = Chapter("Title", "Investment Report Basics");
    chapter.Layout.Landscape = true;
    add(chapter,Section('Purpose'));
    parastr1='Matlab and the Finanacial toolbox were used to create a the first of a series of tools to analayze,plot stock market data';
    parastr2=' The primary source of data was historical stock market quotes and other financial data downloaded from Yahoo/Finance.';
    parastr3=' In order to download most of the data the user is required to have a paid subscription to this service';
    parastr4=' The software scripts that perform this analysis is meant to use downloaded historical data along with.';
    parastr5=' functions drawn from the Matlab Fiancial Tooxbox to perform a variety of tasks relating to the selected investment portfolio.';
    parastr6=' This series of scripts in not intended to be a finished package-instead it is a testbed for future concepts';
    parastr7=strcat(parastr1,parastr2,parastr3,parastr4,parastr5,parastr6);
    p1 = Paragraph(parastr7);
    p1.Style = {OuterMargin("0pt", "0pt","50pt","10pt")};
    add(chapter,p1);
    add(chapter,Section('Example Use of Yahoo Finance Website'));
    parastr11='A series of images follow which will provide the user with an initial idea how to use the Yahoo Finance Website';
    parastr12=' The user can try some of the feature out with a free account.';
    parastr13=' Note that if the user is desiring to obtain and download serious data a paid up Gold account is required';
    parastr14=' Matabl Central provides some scripts to call other datasites but in general these no longer work.';
    parastr15=' This is because most of these sites now require a paid subscription.';
    parastr16=' The first chart will show the login process for Yahoo Finance';
    parastr17=strcat(parastr11,parastr12,parastr13,parastr14,parastr15,parastr16);
    % Start with the Yahoo login screen
    p2 = Paragraph(parastr17);
    p2.Style = {OuterMargin("0pt", "0pt","10pt","10pt")};
    add(chapter,p2); %changed Mar 9,7 PM
    eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
    % Load the image of the login screen
    imdata = imread('YahooLoginScreen.jpg');
    [nhigh,nwid,ndepth]=size(imdata);
    image = mlreportgen.report.FormalImage();
    image.Image = which('YahooLoginScreen.jpg');
    text = Text('Yahoo Login Screen');
    text.Color = 'red';
    image.Caption = text;
    heightstr=strcat(num2str(nhigh/2),'px');
    widthstr=strcat(num2str(nwid/2),'px');
    image.Height = heightstr;
    image.Width = widthstr;
    image.ScaleToFit=0;
    add(chapter,image); 
    % Now display the opening page of the Yahoo Site
    parastr21='The following chart shows a typical opening page of the Yahoo finance site';
    parastr22=' Tabs at the top of the page show the subject areas which can be selected on them.';
    parastr23=' In order to get to the desired finanlcial data for stock the use must type in a stock code in a window at the extreme upper right edge.';
    parastr24=strcat(parastr21,parastr22,parastr23);
    p3 = Paragraph(parastr24);
    p3.Style = {OuterMargin("0pt", "0pt","50pt","10pt")};
    add(chapter,p3); %changed Mar 9,7 PM
    br = PageBreak();
    add(chapter,br);
    % Proceed to enter a stock symbol 
    imdata = imread('XOMDataLookup.jpg');
    [nhigh,nwid,~]=size(imdata);
    image = mlreportgen.report.FormalImage();
    image.Image = which('XOMDataLookup.jpg');
    text = Text('Stock Symbol Insertion');
    text.Color = 'red';
    image.Caption = text;
    heightstr=strcat(num2str(round(nhigh/2)),'px');
    widthstr=strcat(num2str(round(nwid/2)),'px');
    image.Height = heightstr;
    image.Width = widthstr;
    image.ScaleToFit=0;
    add(chapter,image);
    % Show stock Front Page
    imdata = imread('XOMStockFrontPageRev2.jpg');
    [nhigh,nwid,~]=size(imdata);
    image = mlreportgen.report.FormalImage();
    image.Image = which('XOMStockFrontPageRev2.jpg');
    text = Text('Intial View Of XOM Stock Data');
    text.Color = 'red';
    image.Caption = text;
    heightstr=strcat(num2str(nhigh/2),'px');
    widthstr=strcat(num2str(nwid/2),'px');
    image.Height = heightstr;
    image.Width = widthstr;
    image.ScaleToFit=0;
    add(chapter,image); 
    % Now display the opening page of the add a paragraph to explain the
    % graphic
    parastr31='In this example the symbol for XOM or Exxon Mobil was inserted to the search box';
    parastr32=' The image shows to the typical page display on Yahoo when this is done.';
    parastr33=' A green arrow on the left side points out where the majority of data is stored.';
    parastr34=' The historical data is a good start point to view detailed data over a selected time period for the selected security.';
    parastr35=strcat(parastr31,parastr32,parastr33,parastr34);
    p4 = Paragraph(parastr35);
    p4.Style = {OuterMargin("0pt", "0pt","10pt","10pt")};  
    add(chapter,p4); % added Mar 9,2025 9 7PM
%   Show Historical XOM stock data
    imdata = imread('XOMHistoricalDataRev1.jpg');
    [nhigh,nwid,~]=size(imdata);
    image = mlreportgen.report.FormalImage();
    image.Image = which('XOMHistoricalDataRev1.jpg');
    text = Text('Small Sample of Daily Stock Vales For XOM');
    text.Color = 'red';
    image.Caption = text;
    heightstr=strcat(num2str(nhigh/2),'px');
    widthstr=strcat(num2str(nwid/2),'px');
    image.Height = heightstr;
    image.Width = widthstr;
    image.ScaleToFit=0;
    add(chapter,image); 
 %   Now display the opening page of the add a paragraph to explain the
 %   graphic
    parastr41='The graphic above shows a small slice of XOM closing prices over the Jan 1990 to Dec 2024';
    parastr42=' On the right side of the display is a download button-only available on Gold plans.';
    parastr43=' Pressing this button will download a CSV file that can be easily imported in Excel.';
    parastr44=' The columns available provided are useful in calculating technical indicators for stocks.';
    parastr45=' Before the data will be used they will be imported in Excels native format and imported then into Matlab';
    parastr46=strcat(parastr41,parastr42,parastr43,parastr44,parastr45);
    p5 = Paragraph(parastr46);
    p5.Style = {OuterMargin("0pt", "0pt","50pt","10pt")}; 
    add(chapter,p5);
% Now show a blowup of the XOM Daily Prices
    imdata = imread('XOMDailyPrices.jpg');
    [nhigh,nwid,~]=size(imdata);
    image = mlreportgen.report.FormalImage();
    image.Image = which('XOMDailyPrices.jpg');
    text = Text('Download Options');
    text.Color = 'red';
    image.Caption = text;
    heightstr=strcat(num2str(nhigh/2),'px');
    widthstr=strcat(num2str(nwid/2),'px');
    image.Height = heightstr;
    image.Width = widthstr;
    image.ScaleToFit=0;
    add(chapter,image); 
 %   Now describe the graphic
    parastr51='Shown above is a blowup of just a few days worth of XOM stock prices.';
    parastr52=' Red arrows highlight 3 settings that need to be made prior to any download.';
    parastr53=' The left most arrow is used to select the date range-in this case covering a span of 35 years.';
    parastr54='Clicking on this element will bring up a calender time GUI element to select the star and end dates.';
    parastr55=' The middle arrow is used to select a few items-the default choice is sat to stock prices.';
    parastr56=' The right arrow array selects the reporting interval which by default is det to days.';
    parastr57=' Once the proper selections are made Gold member account holders can click the download symbol at the right.';
    parastr58=' It is possible without a Gold level member to selelect the data manually and paste intp Excel but this is tedious.';
    parastr59=strcat(parastr51,parastr52,parastr53,parastr54,parastr55,parastr56,parastr57,parastr58);
    p6 = Paragraph(parastr59);
    p6.Style = {OuterMargin("0pt", "0pt","50pt","10pt")}; 
    add(chapter,p6);
    add(rpt, chapter);
    %% Add new section to this chapter
    % add(chapter,Section('Key tasks'));
    % imdata = imread('GOES-DataProducts.jpg');
    % [nhigh,nwid,~]=size(imdata);
    % image = mlreportgen.report.FormalImage();
    % image.Image = which('GOES-DataProducts.jpg');
    % text = Text('GOES-16/17 Satellite Data Products');
    % text.Color = 'red';
    % image.Caption = text;
    % heightstr=strcat(num2str(nhigh/2),'px');
    % widthstr=strcat(num2str(nwid/2),'px');
    % image.Height = heightstr;
    % image.Width = widthstr;
    % image.ScaleToFit=0;
    % add(chapter,image); 
%    add(rpt, chapter);
% Create chapter 2 with more specific data on GOES sensors
    chapter = Chapter("Title", "GOES-16 Detailed Description");
    chapter.Layout.Landscape = true;
    add(chapter,Section('GOES Details'));
    imdata = imread('GOES-16.jpg');
    [nhigh,nwid,ndepth]=size(imdata);
    image = mlreportgen.report.FormalImage();
    image.Image = which('GOES-16.jpg');
    text = Text('GOES-16 Satellite Image');
    text.Color = 'red';
    image.Caption = text;
    heightstr=strcat(num2str(nhigh/2),'px');
    widthstr=strcat(num2str(nwid/2),'px');
    image.Height = heightstr;
    image.Width = widthstr;
    image.ScaleToFit=0;
    add(chapter,image); 
    imdata = imread('ABI-Description.jpg');
    [nhigh,nwid,ndepth]=size(imdata);
    image = mlreportgen.report.FormalImage();
    image.Image = which('ABI-Description.jpg');
    text = Text('GOES-16 ABI Basic Description');
    text.Color = 'red';
    image.Caption = text;
    heightstr=strcat(num2str(nhigh/2),'px');
    widthstr=strcat(num2str(nwid/2),'px');
    image.Height = heightstr;
    image.Width = widthstr;
    image.ScaleToFit=0;
    add(chapter,image); 
    add(rpt,chapter);
    br = PageBreak();
%     add(chapter,br);
%     add(chapter,Section('GOES ABI Wavebands'));
%     tbl_data2=(GoesWaveBandTable);
%     tbl=Table(tbl_data2);
%     tbl.TableEntriesStyle = {BackgroundColor('white')};
%     tbl.Style = [tbl.Style {Border('solid','black','3px')}];
%     tbl.ColSep = 'single';
%     tbl.RowSep = 'single';
%     tbl.HAlign='center';
%     r = row(tbl,1);
%     r.Style = [r.Style {Color('red'),Bold(true)}];
%     bt = BaseTable(tbl);
%     tabletitle = Text('GOES Waveband Table');
%     tabletitle.Bold = false;
%     bt.Title=tabletitle;
%     bt.TableWidth="7in";
%     add(chapter,bt);
%     parastr1='The table above shows the 16 wavebands that are used by the GOES-16 ABI Imager';
%     parastr2a='The Advanced Baseline Imager, manufactured by Harris Corporation, is a multi-spectral imaging'; 
%     parastr2b=' radiometer  for  the  GOES-R  series  of  satellites.  It  provides  nearly  continuous  imagery';
%     parastr2c=' of  the Western  Hemisphere from  geostationary  orbit  for  weather  prediction  and  other  Earth';
%     parastr2d=' science applications. ABI measures Earth’s radiance in 16 spectral channels ranging from visible (0.47µm)';
%     parastr2e=' to longwave infrared (13.3 µm).';
%     parastr2=strcat(parastr2a,parastr2b,parastr2c,parastr2d,parastr2e);
%     %p1 = Paragraph("This is a paragraph with a bottom outer margin of 50pt.");
%     p1 = Paragraph(parastr2);
%     p1.Style = {OuterMargin("0pt", "0pt","50pt","10pt")};
%     add(chapter,p1);
%     add(chapter,Section('GOES ABI Coverage'));
%     imdata = imread('GOES-16-ABI-Coverage.jpg');
%     [nhigh,nwid,ndepth]=size(imdata);
%     image = mlreportgen.report.FormalImage();
%     image.Image = which('GOES-16-ABI-Coverage.jpg');
%     text = Text('GOES-16 ABI Full Disk/Conus/Meso Coverage Areas');
%     text.Color = 'red';
%     image.Caption = text;
%     heightstr=strcat(num2str(nhigh/2),'px');
%     widthstr=strcat(num2str(nwid/2),'px');
%     image.Height = heightstr;
%     image.Width = widthstr;
%     image.ScaleToFit=0;
%     add(chapter,image); 
%     parastr1='The ABI imager can operate in 3 modes-Full Disk/Conus/Meso. The first mode covers nearly one hemisphere,the second is';
%     parastr2=' focussed on the US and the Meso mode covers about a 1000x1000 Km box. The Full Disk mode is the most resource intensive,';
%     parastr3=' while the Conus mode is most useful and the Meso mode is intended to focus on areas of interest.';
%     parastr4=' Note that the pixel footprint on the earth increases with distance from the GOES platform nadir point-thus resolution is worse';
%     parastr5=' near the edges of any image. In general the resolution is poor above/below 54 Latitude.';
%     parastr6=strcat(parastr1,parastr2,parastr3,parastr4,parastr5);
%     p1 = Paragraph(parastr6);
%     p1.Style = {OuterMargin("0pt", "0pt","50pt","10pt")};
%     add(chapter,p1);
% % Add data on the GLM sensor
%     add(chapter,Section('GOES GLM Sensor'));
%     imdata = imread('GLM-Description.jpg');
%     [nhigh,nwid,ndepth]=size(imdata);
%     image = mlreportgen.report.FormalImage();
%     image.Image = which('GLM-Description.jpg');
%     text = Text('Basic Data on the GLM Sensors');
%     text.Color = 'red';
%     image.Caption = text;
%     heightstr=strcat(num2str(nhigh/1.5),'px');
%     widthstr=strcat(num2str(nwid/1.5),'px');
%     image.Height = heightstr;
%     image.Width = widthstr;
%     image.ScaleToFit=0;
%     add(chapter,image);
% % Add data on Space Weather Instruments
%     add(chapter,Section('GOES Space Weather Instruments'));
%     imdata = imread('SpaceWeatherInstruments.jpg');
%     [nhigh,nwid,ndepth]=size(imdata);
%     image = mlreportgen.report.FormalImage();
%     image.Image = which('SpaceWeatherInstruments.jpg');
%     text = Text('Basic Data On Space Weather Instruments');
%     text.Color = 'red';
%     image.Caption = text;
%     heightstr=strcat(num2str(nhigh/1.5),'px');
%     widthstr=strcat(num2str(nwid/1.5),'px');
%     image.Height = heightstr;
%     image.Width = widthstr;
%     image.ScaleToFit=0;
%     add(chapter,image);
% % add chapter to report
%     add(rpt, chapter);
% % Create a chapter to describe the Derived Winds Calculation Process
%     chapter = Chapter("Title", "Derived Winds Calculation");
%     chapter.Layout.Landscape = true;
%     add(chapter,Section('Derived Winds General Facts'));
%     parastr1='A key capability of the GOES series satellites is the ability to derive wind velocities.';
%     parastr2=strcat('In order to perform this calculation,data from the ABI imager is used with 3 consecutive image frames',...
%         ' along with a feature tracking procedure to calculate the wind velocity and direction and an altitude estimate.');
%     parastr10=strcat(parastr1,parastr2);
%     p10 = Paragraph(parastr10);
%     p10.Style = {OuterMargin("0pt", "0pt","10pt","10pt")};
%     add(chapter,p10);
%     br = PageBreak();
%     add(chapter,br);
%     tbl_header = {'Item' 'Run Time-sec'};
%     T4=[DMWDHdrs;DMWDTable1];
%     tbl4=Table(T4);
%     tbl4.Style = [tbl4.Style {Border('solid','black','3px')}];
%     tbl4.TableEntriesHAlign = 'center';
%     tbl4.HAlign='center';
%     tbl4.ColSep = 'single';
%     tbl4.RowSep = 'single';
%     tb14.TableEntriesHAlign='middle';
%     r = row(tbl4,1);
%     r.Style = [r.Style {Color('red'),Bold(true)}];
%     bt4 = BaseTable(tbl4);
%     tabletitle = Text('GOES Bands Applicable To Derived Motion Winds');
%     tabletitle.Bold = false;
%     bt4.Title = tabletitle;
%     bt4.TableWidth="7in";
%     add(chapter,bt4);
%     add(chapter,Section('Derived Winds Specification'));
%     br = PageBreak();
%     add(chapter,br);
%     tbl_header = {'Item' 'Run Time-sec'};
%     T5=[FPSHdrs;FPSReq];
%     tbl5=Table(T5);
%     tbl5.Style = [tbl5.Style {Border('solid','black','3px')}];
%     tbl5.TableEntriesHAlign = 'center';
%     tbl5.HAlign='center';
%     tbl5.ColSep = 'single';
%     tbl5.RowSep = 'single';
%     r = row(tbl5,1);
%     r.Style = [r.Style {Color('red'),Bold(true)}];
%     bt5 = BaseTable(tbl5);
%     tabletitle = Text('Derived Motion Winds Algorithm Specification');
%     tabletitle.Bold = false;
%     bt5.Title = tabletitle;
%     bt5.TableWidth="7in";
%     add(chapter,bt5);
%     add(rpt,chapter);
%     ab=2;
end

