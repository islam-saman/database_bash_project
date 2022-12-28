#!/usr/bin/bash 
export LC_COLLATE=C
shopt -s extglob


          intReg='^[0-9]+$'

         x=$(sed -n "1p" t8 | sed 's/:/ /g')

           declare -a array=($x)
 
            read -p "Enter the column you want to delete from it  : " column

            declare -i checker=0
           
            for (( i=0; i<3; i++ ))
            do    
                if [[ $column == ${array[$i]} ]]
                    then
                        read -p "Enter the value your update  : " user_value
                        
                    y=$(awk -F: -v USER_VALUE="$user_value" '
                        BEGIN{
                             x=0 
                        }
                        {
                           
                            i=1
                            while(i <= NF)
                            {
                                if($i == USER_VALUE)
                                {
                                    x=1
                                    print NR
                                }
                                i++
                            }
                        }

                        END{
                            if(x == 0)
                            {
                                print "This value is not found \n Please select Again from the list if you want to delete"
                            }
                        }
                        ' t8)
                        
                    echo $y 
                if [[ $y =~ $intReg ]]
                      then
                        echo $y
                       sed -i "${y}d" t8
                        checker=1
                        break
                 else 
                      echo "This value is not found \n Please select Again from the list if you want to delete"
                      checker=1
                          break
                     
                fi
                   
             fi
    

            done
     if [[ $checker == 0 ]]
                then
                    echo "We didn't found your column, You must choose from this list"
                    echo $x
     
            fi







