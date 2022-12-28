#!/usr/bin/bash 
export LC_COLLATE=C
shopt -s extglob
regex='^[A-Z | a-z][A-Za-z0-9]+$'
intReg='^[0-9]+$'



select choice in ALL BYCOLUMN
do

echo $choice
case $choice in
    ALL )
            read -p "Enter Name of the table to delete it : " name
            if [[ ${name} =~ $regex ]]
                then
                    
                    if [ -e $name ]
                        then
                            sed -i '3,$d' $name
                    else
                        echo "We dind't find the table"
                    fi

            else
                echo "The name is wrong, the name don't have to start with numbers or special character and not contain spaces or special character"
            fi             

    ;;

    BYCOLUMN )

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
                                          #  echo ${column_index[$i]}
                                        done
                                        
                                    done
                                    
                                    
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
                        echo "We dind't find the table"
                    fi

            else
                echo "The name is wrong, the name don't have to start with numbers or special character and not contain spaces or special character"
            fi     

    ;;
    esac
done


