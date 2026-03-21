if [ $# -ne 1 ]; then
	echo "1 argument (username) alone needed."
	exit 1
fi

username=$1
missing_rules=""

len=${#username}

if [ $len -lt 5 ] || [ $len -gt 15 ]; then
	missing_rules+=" - Username must be greater than 5 and lesser than 15 characters \n"
fi

first=${username:0:1}
case "$first" in
    [a-z])
        ;;
    *)
        missing_rules+=" - The first letter should be lowercase\n"
        ;;
esac

case $username in
    *[!a-z0-9]*)
        missing_rules+=" - Must contain only lowercase letters and numbers\n"
        ;;
esac

if [[ "$username" == *" "* ]]; then
    missing_rules+=" - Must not contain spaces\n"
fi

last=${username: -1}
case "$last" in
    [0-9]) 
      missing_rules+=" - Username must not end with a number\n"
      ;;
esac

# Result
if [ -z "$missing_rules" ]; then
    result="[VALID] Username is valid."
else
    result="[INVALID] Username is invalid."
fi

# Print output
echo "$result"

if [ ! -z "$missing_rules" ]; then
    echo -e "Missing:"
    echo -e "$missing_rules"
fi

# Logging
timestamp=$(date "+%Y-%m-%d %H:%M:%S")
user=$(whoami)

echo "$timestamp | Run by: $user | Username checked: $username | Result: $result" >> username_check_result.log

if [ ! -z "$missing_rules" ]; then
    echo -e "Missing:\n$missing_rules" >> username_check_result.log
fi

