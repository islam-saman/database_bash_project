#!/usr/bin/bash 
export LC_COLLATE=C
shopt -s extglob
regex='^[A-Z | a-z][A-Za-z0-9]+$'

select choice in Update  BackToTablesMenue
do

echo $choice
case $choice in
    Update )

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
                                                    break
                                            fi
                                        done   
                                        if [[ $key == 0 ]]
                                            then
                                                for (( g=0; g < counter; g++ ))
                                                do
                                                    sed -i "${column_index[$g]}s/$copy_user_value/$newValue/" $name
                                                done          
                                        fi                     
                                else
                                    for (( r=0; r < counter; r++ ))
                                    do
                                        sed -i "${column_index[$r]}s/$copy_user_value/$newValue/" $name
                                    done  
                                fi
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
                else
                    echo "Table is not found"
                fi             
        else
            echo "The name is wrong, the name don't have to start with numbers or special character and not contain spaces or special character"
        fi    
    ;;

    BackToTablesMenue )
        . ../../table.sh 
    ;;

    * )
        echo "Please, select something from the menue"
    esac
done




































































# x=$(sed -n "1p" t8 | sed 's/:/ /g')
# declare -a array=($x)
 
# read -p "Enter the column you want to updata it  : " column

# declare -i checker=0

# for (( i=0; i<3; i++ ))
# do    
#     if [[ $column == ${array[$i]} ]]
#         then
#             let count=$i+1
    
#             read -p "Enter the value your update  : " old_value

#             awk_resualt=$(awk -F: -v OLD_VALUE="$old_value" -v newCount="$count" '
#             BEGIN{x=0}
#             {
#                 print $count
#                 if($count == $OLD_VALUE)
#                 {
#                     print NR
#                     x=1
#                 }

#             }

#             END{
#                 if(x == 0)
#                 {
#                     print "This value is not found \n Please select Again from the list"
#                 }
#             }
#             ' t8 );
#             echo $awk_resualt 
#             if [[ $awk_resualt == "" ]]
#                 then
#                     read -p "Enter the value your update  : " new_value
                    
#                     sed -i "s/$old_value/$new_value/g" t8

#                     checker=1
#                     break
#             else
#                 echo $awk_resualt
#                 checker=1
#                 break
#             fi
            
#     fi
# done

# if [[ $checker == 0 ]]
#     then
#         echo "We didn't found your column, You must choose from this list"
#         echo $x
# fi
