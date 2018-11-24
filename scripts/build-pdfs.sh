#!/bin/bash
for DIR in $(ls -d */ | grep ''); do
    echo "Moving to $DIR and compiling all .tex"
    cd "$DIR"
    for FI in $(ls | grep --regexp="\.tex$"); do
        echo "$FI"
        latexmk -pdf -interaction=nonstopmode "$FI" > output.txt 2>&1
        EXITCODE="$?"
	echo "Exitcode is $EXITCODE"
        if [ $EXITCODE -gt 0 ]; then
            echo "$(<output.txt)"
	    # LOGFILE="${FI//.tex}.log"
	    # echo "$(<$LOGFILE)"
        fi
        echo "$EXITCODE" >> ../exit-codes.txt
        echo "$FI $EXITCODE" >> ../exit-codes-with-filenames.txt
    done
    cd ..
    echo "Left $DIR"
done
# Look for non-zero return codes
RETCODE=0
for CODE in $(cat exit-codes.txt); do
    RETCODE=$(($RETCODE|$CODE))
done
cat exit-codes-with-filenames.txt
exit $RETCODE
