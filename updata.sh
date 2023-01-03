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
"Update" "" \
"BackToMainMenue" "" \
"" ""   3>&1 1>&2 2>&3)


case $ADVSEL in

    Update)
        read -p "Enter Name of the table to select into : " name

        if [[ ${name} =~ $regex ]]
            then
                if [ -e $name ]
                    then
                        x=$(sed -n "1p" $name | sed 's/:/ /g')
                        declare -a array=($x)
                        numOfFiled=$(sed -n "1p" $name | sed 's/:/ /g' | wc -w)
                        read -p "Enter the column you want to select it  : " column

                        declare -i checker=0
                        declare -i checker1=0
                        declare -i counter=0
                        copy_user_value=""

                        for (( i=0; i<$numOfFiled; i++ ))  
                        do
                            if [[ $column == ${array[$i]} ]]
                                then
                                    let countType=$i+1 
                                    colum_type=$(sed -n '2p' $name | cut -d: -f$countType)
                                    declare -i columNum=$i+1
                                    read -p "Enter the value your search for  : " user_value
                                    copy_user_value=$user_value
                                    column_data=$(cut -d: -f$columNum $name) 
                                    declare -a column_dataArray=($column_data)
                                    declare -i numOfColumnData=$(cut -d: -f$columNum $name | wc -w)
                                    declare -a column_index

                                    for(( index=2; index < numOfColumnData; index++ ))
                                    do
                                        if [[ $user_value == ${column_dataArray[$index]} ]]
                                            then
                                                checker=1
                                                let count=$index+1  #This count + 1 becuase thsi loop start from 2 and file start from 3 and can't delete 1
                                                column_index[$counter]=$count
                                                counter=$counter+1
                                        fi
                                    done
                                    checker1=1
                            fi
                        done
                        
                        if  [[ $checker == 1  && $checker1 == 1 ]]
                            then 
                                read -p "Enter the new value to change : " newValue

                                column_data=$(cut -d: -f$columNum $name) 
                                declare -a column_dataArray=($column_data)
                                declare -i numOfColumnData=$(cut -d: -f$columNum $name | wc -w)
                                declare -i key=0

                                if [[ $column == ${array[0]} ]]
                                    then
                                        
                                        for (( index=0; index < numOfColumnData; index++ ))
                                        do
                                            if [[ $newValue == ${column_dataArray[$index]} ]]
                                                then
                                                    echo "This value found becuase this colum is primary key"
                                                    key=1
                                                    sleep 3
                                                    break
                                            fi
                                        done   
                                        if [[ $key == 0 ]]
                                            then
                                                for (( g=0; g < counter; g++ ))
                                                do
                                                    if [[ $colum_type == "int" ]]
                                                        then
                                                            if [[ $newValue =~ $intReg ]]
                                                                then
                                                                 sed -i "${column_index[$g]}s/$copy_user_value/$newValue/" $name
                                                                 echo "Updated successfully"
                                                                 sleep 3
                                                            else
                                                                echo "The value is different from the column type, The right type is int"
                                                                sleep 3
                                                                break
                                                            fi
                                                    fi

                                                     if [[ $colum_type == "string" ]]
                                                        then
                                                            if [[ $newValue =~ $strReg ]]
                                                                then
                                                                 sed -i "${column_index[$g]}s/$copy_user_value/$newValue/" $name
                                                                 echo "Updated successfully"
                                                                 sleep 3
                                                            else
                                                                echo "The value is different from the column type, The right type is string"
                                                                sleep 3
                                                                break
                                                            fi
                                                    fi                                                           
                                                done          
                                        fi                     
                                else
                                    for (( r=0; r < counter; r++ ))
                                    do
                                        if [[ $colum_type == "int" ]]
                                            then
                                                if [[ $newValue =~ $intReg ]]
                                                    then
                                                    sed -i "${column_index[$r]}s/$copy_user_value/$newValue/" $name
                                                    echo "Updated successfully"
                                                    sleep 3
                                                else
                                                    echo "The value is different from the column type, The right type is int"
                                                    sleep 3
                                                    break
                                                fi
                                        fi

                                            if [[ $colum_type == "string" ]]
                                            then
                                                if [[ $newValue =~ $strReg ]]
                                                    then
                                                        sed -i "${column_index[$r]}s/$copy_user_value/$newValue/" $name
                                                        echo "Updated successfully"
                                                        sleep 3                                                        
                                                else
                                                    echo "The value is different from the column type, The right type is string"
                                                    sleep 3
                                                    break
                                                fi
                                        fi    
                                        
                                    done  
                                fi
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
                    echo "Table is not found"
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
 
