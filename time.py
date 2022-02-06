import time
import os
import sys

#https://stackoverflow.com/a/50284916
commandstring = '';  

for arg in sys.argv[1:]:          # skip sys.argv[0] since the question didn't ask for it
    if ' ' in arg:
        commandstring+= '"{}"  '.format(arg) ;   # Put the quotes back in
    else:
        commandstring+="{}  ".format(arg) ;      # Assume no space => no quotes



start = time.monotonic()
os.system(commandstring)
end = time.monotonic()
f = open("data.csv", "a")
f.write(str(end-start))
f.close()