#!/usr/bin/bash
export LC_COLLATE=C
shopt -s extglob

#Regex to check

regex='^[A-Z | a-z][A-Za-z0-9]+$'
intReg='^[0-9]+$'
strReg='^[A-Za-z]+$'
declare -i num_Fields

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
                        read -p "Enter Number of Fields : " num_Field
                        echo
                        echo "The first colum is PRIMAY KEY by defualt"

                        num_Fields=$num_Field # Casting to integer YOU CA#%543534534
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
                                    type+=$content_type
                            else
                                    read -p "Enter the $count Field : " user_content
                                    colum+=$user_content":"

                                    read -p "Enter the type of field : " content_type
                                    type+=$content_type":"
                            fi
                            let count=$count+1
                        done
                        echo $colum >> $name
                        echo $type >> $name

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

        DropTable )
        while true
        do
            read -p "Enter Name of a Table to remove : " name
            if [[ ${name} =~ $regex ]]
                then
                    if [ -f $name ]
                        then
                            rm $name
                            echo "Your Table has been removed"
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
            fi
        done
        ;;

        InsertIntoTable )
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
                                                            continue
                                                        fi
                                                else
                                                    if [[ ${user_input} =~ $strReg ]]
                                                        then
                                                            line_insert+=$user_input
                                                    else
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
                                                            continue
                                                        fi
                                                else
                                                    if [[ ${user_input} =~ $strReg ]]
                                                        then
                                                            line_insert+=$user_input":"
                                                    else
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
                    fi
            else
                break
            fi
        done
        ;;
        
    SelectFromTable )
 
            read -p "Enter Name of the table to select into : " name

            if [[ ${name} =~ $regex ]]
                then
                    if [ -e $name ]
                        then
                            select choice in ALL BYCOLUMN COLUMN
                            do
                                x=$(sed -n "1p" $name | sed 's/:/ /g')
                                numOfFiled=$(sed -n "1p" $name | sed 's/:/ /g' | wc -w)

                                declare -a array=($x)

                                echo $choice
                                case $choice in
                                    ALL )
                                        cat $name | sed -n '1!p' | sed -n '1!p'
                                    ;;

                                    BYCOLUMN )
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
                                        
                                    
                                    ;;

                                    COLUMN )
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

                                    ;;    

                                    * )
                                        echo "Please select one of the choice: "
                                esac
                            done 
                    else
                        echo "Table is not found"
                    fi

            else
                echo "The name is wrong, the name don't have to start with numbers or special character and not contain spaces or special character"
            fi                                                      
        ;;
        DeleteFromTable )
 
            read -p "Enter Name of the table to delete it : " name

            if [[ ${name} =~ $regex ]]
                then
                    if [ -e $name ]
                        then
                            . ./delete.sh
                    else
                        echo "We dind't find the table"
                    fi

            else
        
                echo "The name is wrong, the name don't have to start with numbers or special character and not contain spaces or special character"
            fi           
        ;;

        esac
done
