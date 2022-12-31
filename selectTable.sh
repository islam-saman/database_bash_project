#!/usr/bin/bash
export LC_COLLATE=C
shopt -s extglob

#Regex to check

regex='^[A-Z | a-z][A-Za-z0-9]+$'
intReg='^[0-9]+$'
strReg='^[A-Za-z]+$'
declare -i num_Fields


read -p "Enter Name of the table to select into : " name

if [[ ${name} =~ $regex ]]
    then
        if [ -e $name ]
            then
                x=$(sed -n "1p" $name | sed 's/:/ /g')
                numOfFiled=$(sed -n "1p" $name | sed 's/:/ /g' | wc -w)

                declare -a array=($x)

                function advancedMenue() {

                ADVSEL=$(whiptail --title "menu" --fb --menu "select option" 15 60 4 \
                "ALL"                                    "options" \
                "BYCOLUMN"                               "options" \
                "COLUMN"                                 "options" \
                "BackToMainMenue"                         "options"   3>&1 1>&2 2>&3)

                case $ADVSEL in


                ALL)
                    cat $name | sed -n '1!p' | sed -n '1!p'
                    sleep 5
                    advancedMenue
                    ;;
                
                BYCOLUMN)
                    read -p "Enter the column you want to select it  : " column

                    declare -i checker=0
                    declare -i checker1=0

                    for (( i=0; i<$numOfFiled; i++ ))  
                    do
                        if [[ $column == ${array[$i]} ]]
                            then
                                read -p "Enter the value your search for  : " user_value
                                declare -i columNum=$i+1

                                column_data=$(cut -d: -f$columNum $name) 
                                declare -a column_dataArray=($column_data)
                                declare -i numOfColumnData=$(cut -d: -f$columNum $name | wc -w)
                                declare -i column_index

                                for(( index=2; index < numOfColumnData; index++ ))
                                do
                                    if [[ $user_value == ${column_dataArray[$index]} ]]
                                        then
                                            checker=1
                                            column_index=$index+1
                                            break
                                    fi
                                done
                                checker1=1
                        fi

                    done

                    if  [[ $checker == 1  && $checker1 == 1 ]]
                        then 
                            sed -n "$column_index p" $name ;
                    fi

                    if [[ $checker1 == 1 &&  $checker == 0 ]]
                        then
                            echo "Value not found, please select again"
                    fi

                    if [[ $checker1 == 0 ]]
                        then
                            echo "We didn't found your column, You must choose from this list"
                            echo $x
                    fi
                            
                    advancedMenue      
                    ;;

                COLUMN)
                    read -p "Enter the field you want to select it  : " field
                    declare -i checker=0

                    for (( i=0; i<$numOfFiled; i++ ))
                    do
                        if [[ $field == ${array[$i]} ]]
                            then
                                declare -i f=$i+1 
                                cut -d: -f$f $name | sed -n '1!p' | sed -n '1!p'
                                checker=1
                                break
                        fi
                    done

                    if [[ $checker == 0 ]]
                        then
                            echo "We didn't found your column, You must choose from this list"
                            echo $x
                    fi
                    advancedMenue
                    ;;
                BackToMainMenue)
                    . ../../table.sh 
                    
                esac

                }
                advancedMenue
        else
            echo "Table is not found"
        fi

else
    echo "The name is wrong, the name don't have to start with numbers or special character and not contain spaces or special character"
fi 
        
