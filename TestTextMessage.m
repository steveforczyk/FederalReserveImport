% This is a test script to see if I can send a text message to my iPhone at
% the conclusion of a run


% Create a vector of random numbers
Data=rand(5);
params.domain='uchicago.edu';
params.smtp ='smtp.uchicago.edu';
params.phoneNumber='2565130415';
params.provider='att';
params.fromAddr='myname@uchicago.edu';
msg='Help me';
status = sendTxt(params,msg);

%send_text_message('256-513-0415','AT&T','Run Test Script','Run Complete')