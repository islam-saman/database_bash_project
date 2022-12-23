intReg='^[0-9]+$'
strReg='^[A-Za-z]+$'


fiel=3
count=1
str=""



while (( $count <= $fiel ))
do
    var=$(sed -n '1p' t8 | cut -d: -f$count)
    var2=$(sed -n '2p' t8 | cut -d: -f$count)

    read -p "Enter the $var : " user_input
    
    if [[ $count == 1 ]]
        then
            awk -F: -v myvar=$user_input '
            {

                if($1 == myvar)
                {
                    print "This $myvar is already exit"
                    
                }

            } ' t8


    fi

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

echo $str
echo $str >> t8






































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
