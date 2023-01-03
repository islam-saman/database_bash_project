#!/usr/bin/bash
export LC_COLLATE=C
shopt -s extglob

#Regex to check

regex='^[A-Z | a-z][A-Za-z0-9]+$'
intReg='^[0-9]+$'
strReg='^[A-Za-z]+$'
declare -i num_Fields


function advancedMenue() {

ADVSEL=$(whiptail --title "menu" --fb --menu "select option" 15 60 4 \
"ALL" "" \
"BYCOLUMN" "" \
"BackToMainMenue" ""   3>&1 1>&2 2>&3)

case $ADVSEL in


    ALL)
        read -p "Enter Name of the table to delete it : " name
        if [[ ${name} =~ $regex ]]
            then
                if [ -e $name ]
                    then
                        sed -i '3,$d' $name
                        echo "ALL Data in Your table has been removed"
                        sleep 3
                else
                    echo "We dind't find the table"
                    sleep 3
                fi

        else
            echo "The name is wrong, the name don't have to start with numbers or special character and not contain spaces or special character"
            sleep 3
        fi     
        advancedMenue
        ;;

    BYCOLUMN)
        read -p "Enter Name of the table to delete it : " name

        if [[ ${name} =~ $regex ]]
            then
                if [ -e $name ]
                    then
                        x=$(sed -n "1p" $name | sed 's/:/ /g')
                        numOfFiled=$(sed -n "1p" $name | sed 's/:/ /g' | wc -w)
                        declare -a array=($x)

                        read -p "Enter the column you want to delete from it  : " column
                        declare -i checker=0
                        declare -i checker1=0
                        declare -a column_index
                        declare -i counter=0

                        for (( i=0; i<numOfFiled; i++ ))
                        do    

                            if [[ $column == ${array[$i]} ]]
                                then
                                    read -p "Enter the value you search for  : " user_value
                                    declare -i columNum=$i+1
                                    column_data=$(cut -d: -f$columNum $name) 
                                    declare -a column_dataArray=($column_data)
                                    declare -i numOfColumnData=$(cut -d: -f$columNum $name | wc -w)

                                    
                                    declare -i index

                                    for(( index=2; index < numOfColumnData; index++ ))
                                    do
                                        if [[ $user_value == ${column_dataArray[$index]} ]]
                                            then
                                                checker=1
                                                let count=$index+1
                                                column_index[$counter]=$count
                                                counter=$counter+1
                                        fi
                                    done           
                                    checker1=1

                            fi
                        done

                        if  [[ $checker == 1  && $checker1 == 1 ]]
                            then 
                                for(( index=0; index < counter; index++ ))
                                do
                        
                                    sed -i "${column_index[$index]}d" $name
                                    for(( i=$index; i < counter; i++ ))
                                    do
                                        let count=${column_index[$i]}-1
                                        column_index[$i]=$count
                                    done
                                done  
                            echo "We have removed what you want and updated the table"
                            sleep 3
                        fi

                        if [[ $checker1 == 1 &&  $checker == 0 ]]
                            then
                                echo "Value not found, please select again"
                                sleep 3
                        fi

                        if [[ $checker1 == 0 ]]
                            then
                                echo "We didn't found your column, You must choose from this list"
                                echo $x
                                sleep 3
                        fi

                else
                    echo "We dind't find the table"
                    sleep 3
                fi

        else
            echo "The name is wrong, the name don't have to start with numbers or special character and not contain spaces or special character"
            sleep 3
        fi       
        advancedMenue      
        ;;
    BackToMainMenue)
        . ../../table.sh
        ;; 
        * )
        . ../../table.sh 
    esac

    }
    advancedMenue
 
