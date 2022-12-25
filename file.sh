clear

num_Field=3
count=1
line_insert=""
check_unique=""


while (( $count <= $num_Field ))
do
    colum_data=$(sed -n '1p' t8 | cut -d: -f$count)
    colum_type=$(sed -n '2p' t8 | cut -d: -f$count)

    read -p "Enter the $colum_data : " user_input
    
    if [[ $count == 1 ]]
        then   
           check_unique=$(grep "^${user_input}\b" t8);
           if [[ $check_unique != "" ]]
                then
                    echo "This item was found and It must be unique"
                    continue
            fi
    fi

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

    let count=$count+1
done


echo $line_insert >> t8






































# colum=""

# awk -F:
# '
# {

# i=1

# while(i<=NF)
# {
#     read -p "Enter the data for the $i"  colum_data
    
#     type=$(sed -n '2p' t8 | cut -d: -f$i)
#     if($type == "int")
#     {
#         if( $colum_data =~ $intReg )
#         {
            
#         }
#     }

    

# }

# }

# ' /home/islam/database_bash_project/DataBases/student/t8

colum_data="islam"
awk -F: '
{

if( $colum_data == /islam/ )
{
    print "It Test"        
}
    
}

' t8