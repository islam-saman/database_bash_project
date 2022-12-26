#!/usr/bin/bash 
export LC_COLLATE=C
shopt -s extglob


x=$(sed -n "1p" text | sed 's/:/ /g')
    declare -a array=($x)
 
            read -p "Enter the column you want to updata it  : " column

            declare -i checker=0
           
            for (( i=0; i<3; i++ ))
            do    
                if [[ $column == ${array[$i]} ]]
                    then
                        read -p "Enter the value your update  : " user_value
                        read -p "Enter the  new value your update  : " value
                              awk -F: -v USER_VALUE="$user_value" -v x="$value" '
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
                        ' text
                 checker=1
                     sed -i "s/$user_value/$value/g" text
                   break
                fi
         if [[ $checker == 0 ]]
                then
                    echo "We didn't found your column, You must choose from this list"
                    echo $x
                    break
            fi

            done

<<COMMENT
            

  

       grep ^$value$ text 

                      #  checker=1
                      #    sed -i "s/$user_value/$value/g" text
       


COMMENT


