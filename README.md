NOTE: THIS IS A TEST SCRIPT SIMULATING MALWARE.
Only run this script inside of test systems. Only run it with administrator approval. Do not use this script to cause harm to production systems.  
This script exists as a proof of concept for education purposes only. It highlights the importance of using externally provided tools instead of built in system binaries during forensics activities.

#usage: supertrojan <netstat> <ps> <ls> <yyyymmddhhmm>  
#example: Imagine you have a backdoor on a computer. the backdoor displays in the file list as "Malware.file", in the process list as "malware.process", and can be seen in the netstat on port 1337.  
#you don't want the network administrators to find this backdoor and bust you, so you use supertrojan to hide the backdoor.  
#you would run this command:  
  ##supertrojan 1337 malware.process malware.file 202001010000  
##this will hide your backdoor from ls, ps, and netstat.
##timestamp in format of yyyymmddhhmm  

##this script does a few things  
##first it moves ps, ls, and netstat to /opt  
##then it makes scripts replacing ps,ls,and netstat. these scripts call the real binaries, but grep -v out whatever argument is passed to supertrojan.  
##finally, it makes said binaries executable. with Chmod and timestampts them to the provided timestamp to assist in obfuscation  
