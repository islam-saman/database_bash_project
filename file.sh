# x=$(sed -n "1p" t8 | sed 's/:/ /g')
x=$(sed -n "1p" t8 | sed 's/:/ /g')



select choice in ALL BYCOLUMN COLUMN
do
    declare -a array=($x)

    echo $choice
    case $choice in
        ALL )
            cat t8 | sed -n '1!p' | sed -n '1!p'
        ;;

        BYCOLUMN )
            read -p "Enter the column you want to select it  : " column

            declare -i checker=0
            

            for (( i=0; i<3; i++ ))
            do
                if [[ $column == ${array[$i]} ]]
                    then
                        read -p "Enter the value your search for  : " user_value

                        awk -F: -v USER_VALUE="$user_value" '
                        BEGIN{
                             x=0
                        }
                        {
                            i=1
                            while(i <= NF)
                            {
                                if($i == USER_VALUE)
                                {
                                    print $0
                                    x=1
                                }
                                i++

                            }
                            

                        }

                        END{
                            if(x == 0)
                            {
                                print "This value is not found \n Please select Again from the list"
                            }
                        }
                        ' t8
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

        COLUMN )
            read -p "Enter the field you want to select it  : " field
            declare -i checker=0

            for (( i=0; i<3; i++ ))
            do
                if [[ $field == ${array[$i]} ]]
                    then
                        declare -i f=$i+1 
                        cut -d: -f$f t8 | sed -n '1!p' | sed -n '1!p'
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










































# clear

# num_Field=3
# count=1
# line_insert=""
# check_unique=""


# while (( $count <= $num_Field ))
# do
#     colum_data=$(sed -n '1p' t8 | cut -d: -f$count)
#     colum_type=$(sed -n '2p' t8 | cut -d: -f$count)

#     read -p "Enter the $colum_data : " user_input
    
#     if [[ $count == 1 ]]
#         then   
#            check_unique=$(grep "^${user_input}\b" t8);
#            if [[ $check_unique != "" ]]
#                 then
#                     echo "This item was found and It must be unique"
#                     continue
#             fi
#     fi

#     if [[ $colum_type == "int" ]]
#         then
#             if [[ ${user_input} =~ $intReg ]]
#                 then
#                     line_insert+=$user_input":"
#             else
#                 continue
#             fi
#     else
#         if [[ ${user_input} =~ $strReg ]]
#             then 
#                 line_insert+=$user_input":"
#         else
#             continue
#         fi    
#     fi

#     let count=$count+1
# done


# echo $line_insert >> t8






































# # colum=""

# # awk -F:
# # '
# # {

# # i=1

# # while(i<=NF)
# # {
# #     read -p "Enter the data for the $i"  colum_data
    
# #     type=$(sed -n '2p' t8 | cut -d: -f$i)
# #     if($type == "int")
# #     {
# #         if( $colum_data =~ $intReg )
# #         {
            
# #         }
# #     }

    

# # }

# # }

# # ' /home/islam/database_bash_project/DataBases/student/t8

# colum_data="islam"
# awk -F: '
# {

# if( $colum_data == /islam/ )
# {
#     print "It Test"        
# }
    
# }

# ' t8