#!/usr/bin/bash 
export LC_COLLATE=C
shopt -s extglob
regex='^[A-Z | a-z][A-Za-z0-9]+$'


select choice in CreateTable ListTables DropTable InsertIntoTable SelectFromTable DeleteFromTable UpdateTable
do 

echo $choice

    case $choice in 
        CreateTable )
        while true
        do
            read -p "Enter Name of your Table : " name
            if [[ ${name} =~ $regex ]]
                then
                    if [ -e $name ] 
                        then
                            echo "Table Already Exits "
                            read -p "Do you want to Enter the name Again(yes or no)" user_input

                        if [[ $user_input == "yes" ]]
                            then 
                                continue
                        else
                            break
                        fi
                    else 
                        touch $name
                        break
                    fi             	    
             else
	            echo "The name is wrong, the name don't have to start with numbers or special character and not contain spaces or special character"
            fi
        done
        ;;

        ListTables ) 
        ls -F | grep -v "/$"

        ;;
        esac
done