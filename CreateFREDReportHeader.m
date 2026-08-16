function [PStatsObj,TSeries1Hdrs,TSeries1Table]=CreateFREDReportHeader(PStatsObj)
% This function will create the initial "boilerplate" header info
% for the Import of the FRED Data
% Written By: Stephen Forczyk
% Created: Jul 11,2025
% Revised: Aug 15,2026 deleted references to globals and 
% listed all 152 datasets used
% Classification: Unclassified

iCreatePDFReport=PStatsObj.iCreatePDFReport;
RptGenPresent=PStatsObj.RptGenPresent;
govjpegpath=PStatsObj.govjpegpath;
rpt=PStatsObj.rpt;
tocc= PStatsObj.tocc;
chapter=PStatsObj.chapter;
pdffilename=PStatsObj.pdffilename;
fid=PStatsObj.fid;
pdfpath=PStatsObj.pdfpath;
jpegpath=PStatsObj.jpegpath;
logfilepath=PStatsObj.logfilepath;
% Set Up some tables
TSeries1Hdrs=cell(1,3);
TSeries1Hdrs{1,1}='Function Name';
TSeries1Hdrs{1,2}='Description';
TSeries1Hdrs{1,3}='Used In Script';
TSeries1Table{1,1}='adosc';
TSeries1Table{1,2}='Accumulation/Distribution oscillator';
TSeries1Table{1,3}='Yes';
TSeries1Table{2,1}='chaikosc';
TSeries1Table{2,2}='Chaikin oscillator';
TSeries1Table{2,3}='Yes';
TSeries1Table{3,1}='macd';
TSeries1Table{3,2}='Moving Average Convergence/Divergence (MACD)';
TSeries1Table{3,3}='Yes';
TSeries1Table{4,1}='stochosc';
TSeries1Table{4,2}='Stochastic oscillator';
TSeries1Table{4,3}='No';
TSeries1Table{5,1}='tsaccel';
TSeries1Table{5,2}='Acceleration between times';
TSeries1Table{5,3}='No';
TSeries1Table{6,1}='tsaccel';
TSeries1Table{6,2}='tsmom';
TSeries1Table{6,3}='Yes';
dataYear=PStatsObj.dataYear;
% Set some flags
JpegCounter=PStatsObj.JpegCounter;
import mlreportgen.dom.*;
import mlreportgen.report.*;
import mlreportgen.utils.*

% Create the report
    eval(['cd ' pdfpath(1:length(pdfpath)-1)]);
    rpt = Report(pdffilename,"pdf");
    open(rpt);
    PStatsObj.rpt=rpt;
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
    tp.Title = 'FRED-Data-Import';
    tp.Subtitle = strcat('User Selected Data Year-',num2str(dataYear));
   % tp.Image = which('GOES-Logo.jpg');
    tp.Author = 'Stephen Forczyk';
    tp.Publisher = 'FRC';
    tp.PubDate = date();
%    tp.PubDate = datetime('today');
    add(rpt,tp);
% add a table of contents
    tocc = TableOfContents;
    tocc.Title = Text('Table of Contents');
    tocc.Title.Color = 'blue';
    tocc.TOCObj.NumberOfLevels = 2; 
    PStatsObj.tocc=tocc;
    add(rpt,tocc);
% Create Chapter 1 with general program information
    chapter = Chapter("Title", "Federal Reserve Data");
    chapter.Layout.Landscape = true;
    PStatsObj.chapter=chapter;
    add(chapter,Section('Data Source'));
    parastr1='The executive routine from acquiring data from the Federal Reserve is ImportFred Data.';
    parastr2=' There a number of Federal Reserve Banks-the specific site the data originated from the the St Louis Branch of the Fed.';
    parastr3=' A user can access this data freely with proper attribution and a personal account can be set up.';
    parastr4=' For this script the data was downloaded in Excel format for easy one time import into Matlab.';
    parastr5=' Virtually all the data was first downloaded into an excel spreadsheet and then imported into Matlab as a Time Table.';
    parastr9=strcat(parastr1,parastr2,parastr3,parastr4,parastr5);
    p1 = Paragraph(parastr9);
    p1.Style = {OuterMargin("0pt", "0pt","50pt","10pt")};
    add(chapter,p1);
    % Load the image of the login screen
    imdata = imread('FredStartPage.jpg');
    [nhigh,nwid,~]=size(imdata);
    image = mlreportgen.report.FormalImage();
    image.Image = which('FredStartPage.jpg');
    text = Text('Fred Website Home Page');
    text.Color = 'red';
    image.Caption = text;
    heightstr=strcat(num2str(nhigh/2),'px');
    widthstr=strcat(num2str(nwid/2),'px');
    image.Height = heightstr;
    image.Width = widthstr;
    image.ScaleToFit=0;
    add(chapter,image); 
% Add a section to show the FRED site can be used
    add(chapter,Section('Example Use of FRED Website'));
    parastr11='As of this writing the FRED website has over 800K datasets-this example importer pulls 152 datasets fom the archive.';
    parastr12=' The data is available at no cost and covers all manner of economic data.';
    parastr13=' A free account can be set up but is generally not required-it is very easy to do';
    parastr14=' Most of the functionality is available even if not logged in.';
    parastr15=' This is because most of these sites now require a paid subscription.';
    parastr16=' The first chart will show the login process for Yahoo Finance';
    parastr17=strcat(parastr11,parastr12,parastr13,parastr14,parastr15,parastr16);
    eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
    % Continue with selecting an example dataset
    % Select an Example Dataset-Unemployment Rate
    imdata = imread('GetUnEmploymentRateData.jpg');
    [nhigh,nwid,ndepth]=size(imdata);
    image = mlreportgen.report.FormalImage();
    image.Image = which('GetUnEmploymentRateData.jpg');
    text = Text('Unemployment Data sets');
    text.Color = 'red';
    image.Caption = text;
    heightstr=strcat(num2str(nhigh/2),'px');
    widthstr=strcat(num2str(nwid/2),'px');
    image.Height = heightstr;
    image.Width = widthstr;
    image.ScaleToFit=0;
    add(chapter,image); 
    parastr21='There are currently more than 30000 datasets available for unemployment rates';
    parastr22=' These cover all aspects of unemployment such as different measures of unemployment.';
    parastr23=' Other datsets cover different time periods,geographic areas or population groups.';
    parastr24=' For this example,the first first dataset is desired so the upper most item should be chosen.';
    parastr25=' To do this the user should click on the unemployment rate link.';
    parastr29=strcat(parastr21,parastr22,parastr23,parastr24,parastr25);
    p3 = Paragraph(parastr29);
    p3.Style = {OuterMargin("0pt", "0pt","50pt","10pt")};
    add(chapter,p3); 
    br = PageBreak();
    add(chapter,br);
   
    % Continue with the download
    imdata = imread('UnemploymentRate.jpg');
    [nhigh,nwid,ndepth]=size(imdata);
    image = mlreportgen.report.FormalImage();
    image.Image = which('UnemploymentRate.jpg');
    text = Text('Unemployment From 1948 to Present');
    text.Color = 'red';
    image.Caption = text;
    heightstr=strcat(num2str(nhigh/2),'px');
    widthstr=strcat(num2str(nwid/2),'px');
    image.Height = heightstr;
    image.Width = widthstr;
    image.ScaleToFit=0;
    add(chapter,image); 
    parastr31='There are currently more than 30000 datasets available for unemployment rates';
    parastr32=' These cover all aspects of unemployment such as different measures of unemployment.';
    parastr33=' Other datsets cover different time periods,geographic areas or population groups.';
    parastr34=' For this example,the first dataset is desired which is also known as the U-3 rate.';
    parastr35=' At the upper right hand corner of this page there is a download button-this should be pressed.';
    parastr36=' To the left of the download button valuable data is providing regarding the data to be downloaded.';
    parastr37=' Note that the user can select arbitrary time periods for the download ranging from 1948 to the present time.';
    parastr38=' The best procedure is to download all the available data and trim the dataset down if desirable.';
    parastr39=strcat(parastr31,parastr32,parastr33,parastr34,parastr35,parastr36,parastr37,parastr38);
    p4 = Paragraph(parastr39);
    p4.Style = {OuterMargin("0pt", "0pt","50pt","10pt")};
    add(chapter,p4); 
    br = PageBreak();
    add(chapter,br);
 % Select download format
    imdata = imread('SelectDownloadType.jpg');
    [nhigh,nwid,ndepth]=size(imdata);
    image = mlreportgen.report.FormalImage();
    image.Image = which('SelectDownloadType.jpg');
    text = Text('Choosing Download Format');
    text.Color = 'red';
    image.Caption = text;
    heightstr=strcat(num2str(nhigh/2),'px');
    widthstr=strcat(num2str(nwid/2),'px');
    image.Height = heightstr;
    image.Width = widthstr;
    image.ScaleToFit=0;
    add(chapter,image); 
    parastr41='This graphic is a blowup of the previous chart taken when the download button is pressed.';
    parastr42=' Once the download button is pressed the user can select 1 of 4 download types.';
    parastr43=' The user must select the Excel Data type or item 2 on the list.';
    parastr44=' The ImportFredData script will load this into a table and ultimately produce a Time series object.';
    parastr45=' All operations will be carried on on the time series object which always end in a name XXXTT.';
    parastr46=' Note that the site sometimes responds slowly before the download begins.';
    parastr47=' It is a good idea to select the download folder prior to downloading these files.';
    parastr49=strcat(parastr41,parastr42,parastr43,parastr44,parastr45,parastr46,parastr47);
    p5 = Paragraph(parastr49);
    p5.Style = {OuterMargin("0pt", "0pt","50pt","10pt")};
    add(chapter,p5); 
    br = PageBreak();
    add(chapter,br);
% Add a new section
    add(chapter,Section('Modifying The Excel Download'));
    parastr51='This section shows the modifications that should be made to a downloaded dataset prior to import into Matlab.';
    parastr52=' Only a few changes are needed but they are important in creating a TimeTable object.';
    parastr53=' The files downloaded from FRED generally consist of just two tabs.';
    parastr54=' The first tab is always called README which contains useful info about the data.';
    parastr55=' A second tab which is labelled by the data frequency is the actual data.';
    parastr56=' Note that Column A row 8 contains a pnemonic ID of this quantity and a tile in ColumnB.';
    parastr59=strcat(parastr51,parastr52,parastr53,parastr54,parastr55,parastr56);
    p6 = Paragraph(parastr59);
    p6.Style = {OuterMargin("0pt", "0pt","50pt","10pt")};
    add(chapter,p6); 

 % Display the image for tab 1 of the Excel file
    imdata = imread('PharmaceuticalPriceIndexTab1.jpg');
    [nhigh,nwid,ndepth]=size(imdata);
    image = mlreportgen.report.FormalImage();
    image.Image = which('PharmaceuticalPriceIndexTab1.jpg');
    text = Text('The README Tab');
    text.Color = 'red';
    image.Caption = text;
    heightstr=strcat(num2str(nhigh/2),'px');
    widthstr=strcat(num2str(nwid/2),'px');
    image.Height = heightstr;
    image.Width = widthstr;
    image.ScaleToFit=0;
    add(chapter,image); 
% Describe Tab 2
    parastr61='The Tab called Annual contains the actual data in two columns.';
    parastr62=' Since this tab is called annual-this is an indicator that the data is taken once a year.';
    parastr63=' On this table the first column is usually called observation_date-THIS MUST BE CHANGED.';
    parastr64=' Column 2 will have different names but as will be the column header in the TimeTable.';
    parastr65=' The name will be changed the PharmaIndex-column names should not contain empty spaces.';
    parastr69=strcat(parastr61,parastr62,parastr63,parastr64,parastr65);
    p7 = Paragraph(parastr69);
    p7.Style = {OuterMargin("0pt", "0pt","50pt","10pt")};
    add(chapter,p7); 
% Display the image for tab 2 of the Excel file
    imdata = imread('PharmaceuticalPriceIndexTab2.jpg');
    [nhigh,nwid,ndepth]=size(imdata);
    image = mlreportgen.report.FormalImage();
    image.Image = which('PharmaceuticalPriceIndexTab2.jpg');
    text = Text('The Annual Tab');
    text.Color = 'red';
    image.Caption = text;
    heightstr=strcat(num2str(nhigh/2),'px');
    widthstr=strcat(num2str(nwid/2),'px');
    image.Height = heightstr;
    image.Width = widthstr;
    image.ScaleToFit=0;
    add(chapter,image); 
% Describe How to change the time into the correct format
    parastr71='This next step is critical in order to put the times into the proper format for the TimeTable.';
    parastr72=' Since this tab is called annual-this is an indicator that the data is taken once a year.';
    parastr73=' In order to change the times to the proper format Column 1 minus the header must be selected.';
    parastr74=' The user then will reformat the time as shown in the popup-see the next graphic.';
    parastr79=strcat(parastr71,parastr72,parastr73,parastr74);
    p8 = Paragraph(parastr79);
    p8.Style = {OuterMargin("0pt", "0pt","50pt","10pt")};
    add(chapter,p8); 
% Start reformating the time data
    imdata = imread('ReformatTimePartA.jpg');
    [nhigh,nwid,ndepth]=size(imdata);
    image = mlreportgen.report.FormalImage();
    image.Image = which('ReformatTimePartA.jpg');
    text = Text('Time Data Reformat-Start');
    text.Color = 'red';
    image.Caption = text;
    heightstr=strcat(num2str(nhigh/2),'px');
    widthstr=strcat(num2str(nwid/2),'px');
    image.Height = heightstr;
    image.Width = widthstr;
    image.ScaleToFit=0;
    add(chapter,image); 
 % Finish reforting the time data
    parastr81='At this point the user presses the button on the popup to reformat the time.';
    parastr82=' The final result is shown on the next chart.';
    parastr89=strcat(parastr81,parastr82);
    p9 = Paragraph(parastr89);
    p9.Style = {OuterMargin("0pt", "0pt","30pt","10pt")};
    add(chapter,p9); 
    br = PageBreak();
    add(chapter,br);
 % Finish reformating the time data
    imdata = imread('ReformatTimePartB.jpg');
    [nhigh,nwid,ndepth]=size(imdata);
    image = mlreportgen.report.FormalImage();
    image.Image = which('ReformatTimePartB.jpg');
    text = Text('Time Data Reformat-Complete');
    text.Color = 'red';
    image.Caption = text;
    heightstr=strcat(num2str(nhigh/2),'px');
    widthstr=strcat(num2str(nwid/2),'px');
    image.Height = heightstr;
    image.Width = widthstr;
    image.ScaleToFit=0;
    add(chapter,image); 
    add(rpt,chapter)
 % Create Chapter 2 UsingFredData
    chapter = Chapter("Title", "Using FRED Data");
    chapter.Layout.Landscape = true;
    add(chapter,Section('Import to Matlab'));
    PStatsObj.chapter=chapter;
    parastr1='The data available from the Federal Reserve is intended to be used in conjunction with stock market data.';
    parastr2=' Another script,currently under development called "ProcessImportedStockData" will use this data.';
    parastr3=' Stock market pricing data along with other financial measures will be imported from Yahoo.';
    parastr4=' This process will be accomplished using yet another script called "HarvestStockData".';
    parastr5=' Stock market analysis and prediction will be accomplished using these tools in serial fashion.';
    parastr6=' The chart below will show this process schematically.';
    parastr9=strcat(parastr1,parastr2,parastr3,parastr4,parastr5,parastr6);
    p1 = Paragraph(parastr9);
    p1.Style = {OuterMargin("0pt", "0pt","50pt","10pt")};
    add(chapter,p1);
    eval(['cd ' govjpegpath(1:length(govjpegpath)-1)]);
  % Show Fred Data Proceesing Flow
    imdata = imread('FlowChart4.jpg');
    [nhigh,nwid,ndepth]=size(imdata);
    nhigh=2*floor(nhigh/2);
    nwid=2*floor(nwid/2);
    image = mlreportgen.report.FormalImage();
    image.Image = which('FlowChart4.jpg');
    text = Text('Fred Data Flow Schematic');
    text.Color = 'red';
    image.Caption = text;
    heightstr=strcat(num2str(nhigh/2),'px');
    widthstr=strcat(num2str(nwid/2),'px');
    image.Height = heightstr;
    image.Width = widthstr;
    image.ScaleToFit=0;
    add(chapter,image); 
    br = PageBreak();
    add(chapter,br);
    parastr11='The chart above shows how the current executive program "ImportFredData" fits into the process.';
    parastr12=' The Federal Reserve site based in Saint Louis, MO is the ultimate source for the econmic data used.';
    parastr13=' This data can provide importanrt context to stock market behavior.';
    parastr14=' For example interest rate sensitive stocks will respond to rate changes by the Fed.';
    parastr15=' Prime examples of such stock are homebuilders and auto makers.';
    parastr16=' Government data on the import and export volumes have predictive capabilities on durable goods makers.';
    parastr17=' With this nformation in mind, addition of FRED data to raw stock market data can influence decision making.';
    parastr18=' The "ImportFredData" block is in red to highlight that this is the executive program for gathering FRED data.';
    parastr19=strcat(parastr11,parastr12,parastr13,parastr14,parastr15,parastr16,parastr17,parastr18);
    p2 = Paragraph(parastr19);
    p2.Style = {OuterMargin("0pt", "0pt","50pt","10pt")};
    add(chapter,p2);
    parastr21='This code is written using OOP techniques.';
    parastr22=' The other code blocks in green are mostly created using non OOP (aka Procdural) model.';
    parastr23=' Later versions of these set of tools will be most likely creating the OOP model.';
    parastr24=' So that the reader be clear the purpose of this code is to read FRED data and prepare it for Matlab import.';
    parastr25=' The output of the Fred Data will be stored in a single object called "FRObj" for FredObject.';
    parastr29=strcat(parastr21,parastr22,parastr23,parastr24,parastr25);
    p3 = Paragraph(parastr29);
    p3.Style = {OuterMargin("0pt", "0pt","20pt","10pt")};
    add(chapter,p3);
    add(rpt,chapter)






end

