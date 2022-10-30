while IFS="," read -r domain password
do
	echo "$domain &&& $password"
done < data.csv	
