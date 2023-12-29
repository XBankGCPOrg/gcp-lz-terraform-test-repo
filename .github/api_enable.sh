#!/bin/bash

#get the list of project spec yaml files
files=$(find . -iname "*.yaml")

api_added="false"

#install yq
sudo wget https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 &> /dev/null -O /usr/bin/yq && sudo chmod +x /usr/bin/yq &> /dev/null

#default api that needs to be enabled in all the projects 
enable_apis="""
compute.googleapis.com
run.googleapis.com
cloudrun.googleapis.com
"""

for file in $files;
do
        api_list=$(yq -o t '.spec.service' $file)
        for api in $enable_apis;
        do
                if [ $(echo $api_list | grep $api | wc -l) == 0 ]
                then
                        api="$api" yq -i '.spec.service += env(api)' $file
                        api_added="true"
                fi
        done
done

if [ $api_added == "true" ]
then
        echo "api_added=true"
else
        echo "api_added=false"
fi
