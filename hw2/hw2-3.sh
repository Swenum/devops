#!/bin/bash
# Запрос имени пользователя
read -p "Введите имя пользователя: " username
# Проверка существования пользователя
if id "$username" &>/dev/null; then
    echo "Пользователь '$username' уже существует."
else
    # Создание пользователя
    sudo useradd -m "$username"
    if [ $? -eq 0 ]; then
        echo "Пользователь '$username' успешно создан."
    else
        echo "Ошибка при создании пользователя '$username'."
    fi
fi