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
        while true
        do
            read -p "Enter Name of your Database : " name
            if [[ ${name} =~ $regex ]]
                then
                    if [ -e $name ] ;then
                        echo "Database Already Exits "
                        read -p "Do you want to Enter the name Again(yes or no)" user_input

                        if [[ $user_input == "yes" ]]
                            then 
                                continue
                        else
                            break
                        fi
                    else 
                        mkdir $name
                        break
                    fi             	    
             else
	            echo "The name is wrong, the name don't have to start with numbers or special character and not contain spaces or special character"
            fi
        done
        ;;

        ListDatabases ) 
        ls -F | grep "/" | cut -d/ -f1

        ;;

        ConnectToDatabases ) 
            echo "Will work on it latter"
        ;;

        DropDatabase ) 
        while true
        do
            read -p "Enter Name of a Database to remove : " name
            if [[ ${name} =~ $regex ]]
                then
                    if [ -d $name ]
                        then
                            rm -r $name
                            echo "Your database has been removed"
                            break
                    else 
                        echo "There is no databae with this name"
                        read -p "Do you want to search again(yes or no)" user_input

                        if [[ $user_input == "yes" ]]
                            then 
                                continue
                        else
                            break
                        fi 
                    fi             	    
             else
	            echo "The name is wrong, the name don't have to start with numbers or special character and not contain spaces or special character"
            fi
        done            
        ;;

     esac
done
