AddEmployee()
{
echo "Please follow instructions carefully to add new record to the employee database"
ans=0
while test "$ans" -eq 0
do
	echo "Please enter empNo"
	echo -e "\t EmpNo should start from E or W"
	echo -e  "\t which should follwed by number in range 99-900"
    while true
    do
	read eno
	firstChar=`echo "$eno"|cut -c 1`
	remChars=`echo "$eno"|cut -c 2-`
		if test "$remChars" -lt 100 -o "$remChars" -gt 999
			then echo "please enter numbers between 100 to 999"
			continue
		fi

		if [ "$firstChar" = "E" -o "$firstChar" = "W" ]
			then break
		else
			echo "Please make sure first ch is E or W"
			continue
		fi
    done

	echo "Please enter Employee Name"
	echo -e "\t Employee name should be minimum of 5 letters"
	while true
	do
		read name
		len=`expr length "$name"`
		if test "$len" -lt 5
			then echo "Name should be minimum of 5 letters"
			continue
		else
			break
		fi
	done


	echo -e "Please enter department name{IT\ACCT\PERS\MKTG}"
	while true
	do
		read dept
		if [ "$dept" = "IT" -o "$dept" = "ACCT" -o "$dept" = "PERS" -o "$dept" = "MKTG" ]
			then break
		else
			echo "Invalid department,should be IT or ACCT or PERS or MKTG"
			continue
		fi
	done

	echo "Please enter employee designation{EXEC\MANAGER\DIRECTOR\INTERN}"
	while true
	do
		read desgn
		if [ "$desgn" = "EXEC" -o "$desgn" = "MANAGER" -o "$desgn" = "DIRECTOR" -o "$desgn" = "INTERN" ]
			then break
		else
			echo "Invalid designation,should be EXECor MANAGER or DIRECTOR or INTERN"
			continue
		fi
	done


	echo "Please enter employee salary in range of 25K to 25l"
	while true
	do
		read salary
		if test "$salary" -lt 25000 -o "$salary" -ge 250000
			then echo "Please enter salary in the specified range of 25000 to 250000"
			continue
		else
		  break
		fi
	done

	echo "$eno:$name:$dept:$desgn:$salary">>employee.dat
	echo "Enter o to add next employee and 1 to come out of add menu of employee"
	read ans
done

}

DeleteEmployee()
 {
 ans=0
 while test "$ans" -eq 0
 do
	echo  "Please enter empNo to delete"
	echo -e "\t EmpNo should start from E or W"
	echo -e  "\t which should follwed by number in range 99-900"
    while true
    do
	read eno
	firstChar=`echo "$eno"|cut -c 1`
	remChars=`echo "$eno"|cut -c 2-`
		if test "$remChars" -lt 100 -o "$remChars" -gt 999
			then echo "please enter numbers between 100 to 999"
			continue
		fi

		if [ "$firstChar" = "E" -o "$firstChar" = "W" ]
			then break
		else
			echo "Please make sure first ch is E or W"
			continue
		fi
    done


 	if grep "^$eno" employee.dat > /dev/null
 		then grep -v "^$eno" employee.dat >temp
		mv temp employee.dat
		echo "employee $eno deleted from the records"
	else
		echo "Employee $eno not found"
	fi
 echo "Enter o to delete  next employee and 1 to come out of delete menu of employee"
 read ans
done
}


EditEmployee()
{

echo "Please follow the instructions to edit an existing employee data"

	echo -e "Please enter empNo to Edit"
	echo -e "\t EmpNo should start from E or W"
	echo -e  "\t which should follwed by number in range 99-900"
    while true
    do
	read eno
	firstChar=`echo "$eno"|cut -c 1`
	remChars=`echo "$eno"|cut -c 2-`
		if test "$remChars" -lt 100 -o "$remChars" -gt 999
			then echo "please enter numbers between 100 to 999"
			continue
		fi

		if [ "$firstChar" = "E" -o "$firstChar" = "W" ]
			then break
		else
			echo "Please make sure first ch is E or W"
			continue
		fi
    done


if grep "^$eno" employee.dat > /dev/null
	then for ln in `cat employee.dat`
	do
		meno=`echo "$ln"|cut -d":" -f1`
		name=`echo "$ln"|cut -d":" -f2`
		desgn=`echo "$ln"|cut -d":" -f3`
		dept=`echo "$ln"|cut -d":" -f4`
		salary=`echo "$ln"|cut -d":" -f5`
		if [ "$eno" = "$meno" ]
			then 
			echo "Please enter New Employee Name"
			echo -e "\t Employee name should be minimum of 5 letters"
			while true
			do
				read name
				len=`expr length "$name"`
				if test "$len" -lt 5
					then echo "Name should be minimum of 5 letters"
					continue
				else
					break
				fi
			done


			echo -e "Please enter new department name{IT\ACCT\PERS\MKTG}"
			while true
			do
				read dept
				if [ "$dept" = "IT" -o "$dept" = "ACCT" -o "$dept" = "PERS" -o "$dept" = "MKTG" ]
					then break
				else
					echo "Invalid department,should be IT or ACCT or PERS or MKTG"
					continue
				fi
			done

			
			echo "Please enter new  designation{EXEC\MANAGER\DIRECTOR\INTERN}"
			while true
			do
				read desgn
				if [ "$desgn" = "EXEC" -o "$desgn" = "MANAGER" -o "$desgn" = "DIRECTOR" -o "$desgn" = "INTERN" ]
					then break
				else
					echo "Invalid designation,should be EXECor MANAGER or DIRECTOR or INTERN"
					continue
				fi
			done

			
			echo "Please enter employee salary in range of 25K to 25l"
			while true
			do
				read salary
				if test "$salary" -lt 25000 -o "$salary" -ge 250000
					then echo "Please enter salary in the specified range of 25000 to 250000"
					continue
				else
		 			 break
				fi
			done


			echo "$meno:$name:$dept:$desgn:$salary">>temp
		else
			echo "$meno:$name:$dept:$desgn:$salary">>temp
		fi
	done
else
	echo  "Employee $eno not found"
fi
mv temp employee.dat

}


ViewEmpRecords()
{
echo "Total Record in Emp database is as below:"

#cat employee.dat
echo -e `date +'%d-%m-%y' `

echo -e                  "Empno \t    EmpName \t      Designation \t         Department \t             Salary"

for ln in `cat employee.dat`
	do
		meno=`echo "$ln"|cut -d":" -f1`
		name=`echo "$ln"|cut -d":" -f2`
		desgn=`echo "$ln"|cut -d":" -f3`
		dept=`echo "$ln"|cut -d":" -f4`
		salary=`echo "$ln"|cut -d":" -f5`
  
		echo -e  " "$meno" \t "$name" \t       "$desgn" \t                 "$dept" \t               "$salary" "
	done
	
}

AddEmpToCloud()
{
echo "Adding data to cloud....please be patient!!"
echo "Enter Employee no to add to cloud"
read eno
if grep "^$eno" employee.dat > /dev/null
	then for ln in `cat employee.dat`
	do
		meno=`echo "$ln"|cut -d":" -f1`
		usrName=`echo "$ln"|cut -d":" -f2`
		if [ "$eno" = "$meno" ]
			then sudo adduser $usrName
		fi
	done
else
	echo "Employee no not found"
fi
}

ViewCloudStatus()
{
echo "Please find cloud details as below:"
#who
echo        "User                                 Terminal                             Date          	 	 Time              IP"
for ln in `who|tr -s " " ":"`
do
	f1=`echo "$ln"|cut -d":" -f1`
	
	f2=`echo "$ln"|cut -d":" -f2`

        f3=`echo "$ln"|cut -d":" -f3`
	
	f4=`echo "$ln"|cut -d":" -f4`
	
	f5=`echo "$ln"|cut -d":" -f5`

	f6=`echo "$ln"|cut -d":" -f6`
    
	echo "$f1                            $f2                         $f3             		$f4:$f5             $f6"
done
	

#read
#clear
}


choice=0
while test "$choice" -ne 7
do
	echo "1. Add Employee Record"
	echo "2. Edit Employee Record"
	echo "3. Delete Employee Record"
	echo "4. View Employee Record"
	echo "5. Add an Employee account to cloud server"
	echo "6. View Cloud user details"
	echo "7. Exit"
	echo "Please Enter a choice from menu"
	read choice
	case "$choice" in
		1) AddEmployee;;
		2) EditEmployee;;
		3) DeleteEmployee;;
		4) ViewEmpRecords;;
		5) AddEmpToCloud;;
		6) ViewCloudStatus;;
		7);;
		*)echo "Invalid Choice";;
	esac
done
