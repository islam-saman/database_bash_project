#!/usr/bin/bash 
export LC_COLLATE=C
shopt -s extglob
regex='^[A-Z | a-z][A-Za-z0-9]+$'

if [ -d ./DataBases ]
    then 
     echo
     cd ./DataBases
     echo "I'm in the database directory now"
     echo; echo

else
     mkdir ./DataBases
     echo
     echo "I'm creating a database directory now"
     cd ./DataBases
     echo; echo
     echo "I'm in the database directory now"
     echo; echo
fi

select choice in CreateDatabase ListDatabases ConnectToDatabases DropDatabase
do 

echo $choice

    case $choice in 
        CreateDatabase )
            read -p "Enter Name of your Database : " name
            if [[ ${name} =~ $regex ]]
                then
                    if [ -e $name ] ;then
                        echo "Database Already Exits : "
                    else 
                        mkdir $name
                    fi             	    
             else
	            echo "The name is wrong, the name don't have to start with numbers or special character and not contain spaces or special character"
            fi
        ;; 

     esac
done

