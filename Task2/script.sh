#!/bin/bash

username="JohnZZ"
lastname="Doe"
filepath=$1

if [[ ! -f $1  ]]; then
  echo "Error: file $1 does not exist";
  exit 1;
elif [[ ( $2 == "-F"  &&  $3 != "" ) && ( $4 == "-L" && $5 != "" ) ]]; then
  username=$3
  lastname=$5
elif [[ ( $2 == "-F"  &&  $3 != "" ) || ( $4 == "-L" && $5 != "" ) ]]; then
  echo "Error: usage is script.sh <filepath> -F <first name> -L <last name>";
  exit 1;
fi

sed "s/{{hostname}}/$(hostname)/g" ${filepath} > output.yml
#TODO change wlp3s0 to eth in case
sed "s/{{ip}}/$(ip addr show wlp3s0 | grep 'inet\b' | awk '{print $2}' | cut -d/ -f1)/g" output.yml > output.yml.tmp; cp output.yml.tmp output.yml
sed "s/{{current_date}}/$(date)/g" output.yml > output.yml.tmp; cp output.yml.tmp output.yml
#TODO dirty
sed "s/{{home_folder}}/$(echo $HOME | sed 's/\//\\\//g')/g" output.yml > output.yml.tmp; cp output.yml.tmp output.yml
sed "s/{{username}}/$(whoami)/g" output.yml > output.yml.tmp; cp output.yml.tmp output.yml
sed "s/{{firts_name}}/${username}/g" output.yml > output.yml.tmp; cp output.yml.tmp output.yml
sed "s/{{last_name}}/${lastname}/g" output.yml > output.yml.tmp; cp output.yml.tmp output.yml
