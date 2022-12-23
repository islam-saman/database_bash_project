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
                        read -p "Enter Number of Fields : " num_Field
                        echo
                        echo "The first colum is PRIMAY KEY by defualt"

                        declare -i num_Fields=$num_Field
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
        while true
        do
            read -p "Enter Name of the table to insert into : " name
            if [[ ${name} =~ $regex ]]
                then
                    if [ -e $name ] 
                        then



                            while (( $count <= $fiel ))
                            do
                                colum_data=$(sed -n '1p' t8 | cut -d: -f$count)
                                colum_type=$(sed -n '2p' t8 | cut -d: -f$count)

                                read -p "Enter the $var : " user_input
                                
                                if [[ $var2 == "int" ]]
                                    then
                                        if [[ ${user_input} =~ $intReg ]]
                                            then
                                                str+=$user_input":"
                                        else
                                            continue
                                        fi
                                else
                                    if [[ ${user_input} =~ $strReg ]]
                                        then 
                                            str+=$user_input":"
                                    else
                                        continue
                                    fi    
                                fi

                                let count=$count+1
                            done                       







                            echo "Table Already Exits "
                            read -p "Do you want to Enter insert something else (yes or no)" user_input
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

                        declare -i num_Fields=$num_Field
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

        esac
done