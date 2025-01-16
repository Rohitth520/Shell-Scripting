#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

LOGS_FOLDER="/var/log/shellscript-logs"
LOG_FILE=$(echo $0 | cut -d "." f1 )
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
LOG_FILE_NAME="$LOGS_FOLDER/$LOG_FILE-$TIMESTAMP.log"


VALIDATE(){
    if [ $1 -ne 0 ]
    then 
        echo -e "$2 ..... $R Failure $N "
        exit 1
    else
        echo -e "$2..... $G Success $N "
    fi

}
echo "Script started executing at: $TIMESTAMP" &>>$LOG_FILE_NAME  &>>$LOG_FILE_NAME


if [ $USERID -ne 0 ]
then
    echo "ERROR:: You must have Sudo access to run the script"
    exit 1
fi

dnf list installed mysql &>>$LOG_FILE_NAME

if [ $? -ne 0 ]
then # not installed
    dnf install mysql -y  &>>$LOG_FILE_NAME
    VALIDATE $? "Installing MySQL"
else

    echo -e "Mysql is already ...... $Y Installed $N"
fi

dnf list installed git &>>$LOG_FILE_NAME

if [ $? -ne 0 ]
then  #not installed so install now
    dnf install git -y &>>$LOG_FILE_NAME
    VALIDATE $? "Installing Git"
else

    echo -e "git is already ...... $Y Installed" $N"
fi

