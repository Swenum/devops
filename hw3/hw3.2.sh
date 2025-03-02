#!/bin/bash
echo "Написать скрипт, который будет делать ping google.com. Если сервер отвечает, то выводить - success, если нет - doesn't work."
ping  10.11.1.55 -c 4
if [ $? -eq 0 ]
then
  echo "Ping was successful"
  exit 0
else
  echo "Ping doesn't work" 
  exit 1
fi