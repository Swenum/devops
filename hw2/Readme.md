### HW2



1. Написать скрипт, если в файле есть слово "error", тогда удалить этот файл.

```bash
#!/bin/bash
echo "Написать скрипт, если в файле есть слово "error", тогда удалить этот файл."
# Путь к файлу
file_to_check="error/file.txt"
echo "error" > $file_to_check
# Проверяем, содержится ли слово "error" в файле
if grep -q "error" $file_to_check; then
  # Если слово "error" найдено, удаляем файл
  rm "$file_to_check"
  echo "Файл $file_to_check был удалён, так как содержит слово 'error'."
else
  echo "Слово 'error' не найдено в файле $file_to_check."
fi

```

###### Глобально назначить переменную
```
export file_to_check="error/file.txt"
```
#### Второй вариант
```bash
#!/bin/bash
# 
# grep -E 'error' -r ${PWD}/error/ | cut -d: -f1
# Создаём файл с содержимым:
echo "error" > error/file.txt
# Ищем в директории error/ отрезаем от вывода имя файла
grep -E 'error' -r ${PWD}/error/ | cut -d: -f1
# Выводим содержимое найденного файла перед удалением
#grep -E 'error' -r ${PWD}/error/ | cut -d: -f1 | xargs  cat
grep -E 'error' -r ${PWD}/error/ | cut -d: -f1 | xargs  rm
```

2. Написать скрипт, который будет создавать пользователя, имя пользователя должно вводится с клавиатуры.
Если пользователь существует, то вывести сообщение об этом.

```bash
#!/bin/bash -x
echo "Написать скрипт, который будет создавать пользователя, имя пользователя должно вводится с клавиатуры. Если пользователь существует, то вывести сообщение об этом."
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
```



3. Что такое systemd ?

```
Systemd — это система инициализации и менеджер служб для операционных систем на базе Linux. Он предназначен для управления процессами и службами, упрощая запуск, остановку и мониторинг служб, а также их конфигурацию. Systemd стал стандартной системой инициализации для многих современных дистрибутивов Linux, таких как Fedora
, CentOS
, Ubuntu и Debian.
```

4. Написать любой сервис в линуксе.

```bash
# Создаём виртуальное окружение flask для установки бибилиотек, чтобы не устанавливать их локально 
python3 -m venv flask
# Входим в окружение
source flask/bin/activate
# Устанавливаю Web библотеку для python
pip install flask
```

Создаём файл сервиса и размещаем его 
```ini /etc/systemd/system/mywebapp.service
[Unit]
Description=My Simple Web Application
After=network.target

[Service]
User=root
WorkingDirectory=/root/devops/hw2
ExecStart=/usr/bin/bash  /root/devops/hw2/mywebapp.sh
Restart=always

[Install]
WantedBy=multi-user.target

```
```bash mywebapp.sh
#!/usr/bin/env bash
# Создаём обертку для погрузки виртуального окружения до запуска приложения
source ${PWD}/flask/bin/activate
python ${PWD}/app.py
```

```python app.py
from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello():
    return "Hello, World! DevOps Cource 2025"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)

```