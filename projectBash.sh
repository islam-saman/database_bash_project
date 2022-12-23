#!/usr/bin/bash 
export LC_COLLATE=C
shopt -s extglob


if [ -d ./DataBases ]
    then 
     echo; echo
     cd ./DataBases
     echo "I'm in the database directory now"
     echo; echo

else
     mkdir ./DataBases
     echo; echo
     echo "I'm creating a database directory now"
     cd ./DataBases
     echo; echo
     echo "I'm in the database directory now"
     echo; echo
fi

