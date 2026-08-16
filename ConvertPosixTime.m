% This is a test of converting posix time

t = 1718195288;
dt = datetime(t,'ConvertFrom','posixtime','TimeZone','America/New_York','Format','M-d-y')

ds=string(dt)
