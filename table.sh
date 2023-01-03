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
"CreateTable" "" \
"ListTables" "" \
"DropTable" "" \
"InsertIntoTable" "" \
"SelectFromTable" "" \
"DeleteFromTable" "" \
"UpdateTable" "" \
"BackToMainMenue" ""   3>&1 1>&2 2>&3)

 case $ADVSEL in


  CreateTable)
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
                        read -p "Enter Number of Fields : " num_Field
                        if [[ $num_Field =~ $intReg && $num_Field != 0 ]]
                            then
                                touch $name
                                echo "The first colum is PRIMAY KEY by defualt"
                        else
                            sleep 3
                            echo "Please select create table  again"
                            break
                        fi
                        

                        num_Fields=$num_Field # Casting to integer
                        declare -i count=1
                        colum=""
                        type=""

                        while (( $count <= $num_Fields ))
                        do
                            if [[ $count == $num_Fields ]]
                                then
                                    read -p "Enter the $count Field : " user_content
                                    colum+=$user_content

                                    read -p "Enter the type of field : " content_type
                                    if [[ $content_type == "string" || $content_type == "int" ]]
                                        then
                                            type+=$content_type
                                        else
                                           echo "Only int and string are vaild type"
                                           read -p "Enter the type of field : " content_type 
                                           type+=$content_type
                                    fi
                                    
                            else
                                    read -p "Enter the $count Field : " user_content
                                    colum+=$user_content":"

                                    read -p "Enter the type of field : " content_type
                                    if [[ $content_type == "string" || $content_type == "int" ]]
                                        then
                                            type+=$content_type":"
                                        else
                                           echo "Only int and string are vaild type"
                                           read -p "Enter the type of field : " content_type
                                           type+=$content_type":"
                                    fi
                            fi
                            let count=$count+1
                        done
                        echo $colum >> $name
                        echo $type >> $name

                        break
                    fi
            else
	            echo "The name is wrong, the name don't have to start with numbers or special character and not contain spaces or special character"
                sleep 3
            fi
        done

    advancedMenue
      ;;
  
  ListTables)
    ls -F | grep -v "/$"
    sleep 3
    advancedMenue      
      ;;

  DropTable)
        while true
        do
            read -p "Enter Name of a Table to remove : " name
            if [[ ${name} =~ $regex ]]
                then
                    if [ -f $name ]
                        then
                            rm $name
                            echo "Your Table has been removed"
                            sleep 3
                            break
                    else
                        echo "There is no Table with this name"
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
                sleep 3
            fi
        done
    advancedMenue
      ;;

  InsertIntoTable)
        declare -i check_state=0
        while true
        do
            if [[ $check_state == 0 ]]
                then
                    read -p "Enter Name of the table to insert into : " name
                    if [[ ${name} =~ $regex ]]
                        then
                            if [ -e $name ]
                                then
                                    count=1
                                    line_insert=""
                                    check_unique=""

                                declare -i insert_num_fields=$(sed -n "1p" $name | grep -o ":" | wc -l)+1

                                    while true
                                    do
                                        while (( $count <= $insert_num_fields ))
                                        do
                                            colum_data=$(sed -n '1p' $name | cut -d: -f$count)
                                            colum_type=$(sed -n '2p' $name | cut -d: -f$count)

                                            read -p "Enter the $colum_data : " user_input

                                            if [[ $count == 1 ]]
                                                then
                                                check_unique=$(grep "^${user_input}\b" $name);
                                                if [[ $check_unique != "" ]]
                                                        then
                                                            echo "This item was found and It must be unique"
                                                            sleep 3
                                                            continue
                                                    fi
                                            fi

                                            if [[ $count == $insert_num_fields ]]
                                                then
                                                 if [[ $colum_type == "int" ]]
                                                    then
                                                        if [[ ${user_input} =~ $intReg ]]
                                                            then
                                                                line_insert+=$user_input
                                                        else
                                                            echo "This column accept int only"
                                                            continue
                                                        fi
                                                else
                                                    if [[ ${user_input} =~ $strReg ]]
                                                        then
                                                            line_insert+=$user_input
                                                    else
                                                        echo "This column accept string only"
                                                        continue
                                                    fi
                                                fi
                                            else
                                                if [[ $colum_type == "int" ]]
                                                    then
                                                        if [[ ${user_input} =~ $intReg ]]
                                                            then
                                                                line_insert+=$user_input":"
                                                        else
                                                            echo "This column accept int only"
                                                            continue
                                                        fi
                                                else
                                                    if [[ ${user_input} =~ $strReg ]]
                                                        then
                                                            line_insert+=$user_input":"
                                                    else
                                                        echo "This column accept string only"
                                                        continue
                                                    fi
                                                fi
                                            fi

                                            let count=$count+1
                                            
                                        done 
                                        echo $line_insert >> $name                      #End of the while loop

            
                                        read -p "Do you want to Enter insert something else (yes or no)" insert_again
                                        if [[ $insert_again == "yes" ]]
                                            then
                                                let count=1
                                                line_insert=""
                                                continue
                                        else
                                            check_state=1
                                            break
                                        fi

                                    done
                        
                            else
                                echo "Table does NOT found "
                                read -p "Do you want to Enter another table (yes or no)" user_try
                                if [[ $user_try == "yes" ]]
                                    then
                                        continue
                                else
                                    break
                                fi
                            fi
                    else
                        echo "The name is wrong, the name don't have to start with numbers or special character and not contain spaces or special character"
                        sleep 3
                    fi
            else
                break
            fi
        done
    advancedMenue
      ;;

  SelectFromTable)
    . ../../selectTable.sh
    advancedMenue       
      ;;

  DeleteFromTable)
    . ../../delete.sh
    advancedMenue
      ;;

  UpdateTable)
    . ../../updata.sh
    advancedMenue
      ;;
  BackToMainMenue)
    cd ../../
    . ./projectBash.sh
    ;;
    * )
    cd ../../
    . ./projectBash.sh
    

  esac
}
advancedMenue
