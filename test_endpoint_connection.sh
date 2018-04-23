#!/bin/bash
#author: aka
#date: 17 April 2018

echo "Starting AEM to Internet connectivity tests"
echo "The output of the tests will be in a file called 'output' in the current folder"
echo ""
if [ -z "$1" ]
  then
    echo "No endpoint file supplied. Usage test_endpoint_conn.sh {file_containing_endpoints}"
    exit 1
fi


IFS=$'\n' read -d '' -r -a endpoints  < $1

# remove any old output files
rm ./output

for i in "${endpoints[@]}"
do
        echo "***********************************************"
        echo "Checking connectivity for endpoint $i"
        echo "==============================================="
        output=$(curl -v --silent  http://$i 2>&1)
        echo "aka $output"
        if [[ $output = *"Connected"* ]];
                then
                        echo "$i connection success" >> output
                else
                        echo "$i connection FAILED" >> output
        fi

        echo "***********************************************"
        echo ""
        echo ""

done