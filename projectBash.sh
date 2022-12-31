#!/bin/bash 
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

function advancedMenue() {

ADVSEL=$(whiptail --title "menu" --fb --menu "select option" 15 60 4 \
"CreateDatabase"                            "options" \
"ListDatabases"                              "options" \
"ConnectToDatabases"                         "options"  \
"DropDatabase"                               "options"     3>&1 1>&2 2>&3)

 case $ADVSEL in


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
        advancedMenue
    ;;
  
  ListDatabases )
        ls -F | grep "/" | cut -d/ -f1  
        sleep 3
        advancedMenue   
    ;;

  ConnectToDatabases )
        while true
        do
            read -p "Enter a name of  Database to connect : " name
            if [[ ${name} =~ $regex ]]
                then
                    if [ -d $name ]
                        then
                            cd $name
                            echo "Your are connected to $name Database"
                             . ../../table.sh
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
        advancedMenue      
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
        advancedMenue         
    ;;
     * )
        echo "Please select one of the choice: "
  esac

}
advancedMenue
