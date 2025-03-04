### Настройка SSH-Agent
Генерируем пару ключей коммандой:
ssh-keygen -t ed25519 -C "your_email@example.com"

#### Добавляем строчку в

```.bashrc 
eval `ssh-agent`
```
и перевходим в систему.

#### Загружаем ключ в агента:
```bash
ssh-add ~/.ssh/otus2023
```
#### Проверяем
```bash
ssh -T git@github.com
# Attempts to ssh to GitHub
```
#### Добавляем данные для коммитера
```bash
git config --global user.email "you@example.com"
git config --global user.name "Your Name"
```

### HW1

1. Найти топ 7 директорий на сервере, которые больше всего занимают память и записать их в файл.



```bash

#!/bin/bash


output_file="top_directories.txt"

# Получаем топ-7 директорий, занимающих больше всего места
du -ah / | sort -rh | head -n 7 > "$output_file"


echo "Топ-7 директорий, занимающих больше всего места, записан в файл $output_file"

```

2. Создать пользователя и добавить его в группу sudo.

```bash
USER='u.schuka'
useradd -m "$USER"
mkdir -p /home/"$USER"/.ssh
# Добавляем ключ в файл authorized_keys
echo "ssh-ed448 AAAACXNzaC1lZDQ0OAAAADlL4ph5NNzIe+vjO6E/NzfGkJXtAzhx7AJ4G/a6QiLp1K6CZdbeoTrVRCX0zcBOFdaxZaImZ/qmhQA= eddsa-key-my" >> /home/"$USER"/.ssh/authorized_keys
# Меняем владельца директории
chown "$USER":"$USER" /home/"$USER" -R
# Назначаем права, ограничивая доступ только владельцу
chmod 600 /home/"$USER"/.ssh/authorized_keys
chmod 700 /home/"$USER"/.ssh
# Добавляем в группу sudo
usermod -G sudo "$USER"
# Изменяем оболочку
usermod -s /bin/bash "$USER"
```


3. Изучить, что такое zombie процесс (спрашивают на собесах).
```
Процесс при завершении (как нормальном, так и в результате не обрабатываемого сигнала) освобождает все свои ресурсы и становится «зомби» — пустой записью в таблице процессов, хранящей статус завершения, предназначенный для чтения родительским процессом.

Зомби-процесс существует до тех пор, пока родительский процесс не прочитает его статус с помощью системного вызова wait(), в результате чего запись в таблице процессов будет освобождена.

При завершении процесса система уведомляет родительский процесс о завершении дочернего с помощью сигнала SIGCHLD, таким образом может быть удобно (но не обязательно) осуществлять вызов wait() в обработчике данного сигнала. 

Процесс-сирота (англ. orphan process) — в семействе операционных систем UNIX вспомогательный процесс, чей основной процесс (или связь с ним) был завершен нештатно (не подав сигнала на завершение работы).

Обычно «сиротой» остается дочерний процесс после неожиданного завершения родительского, но возможно возникновение сервера-сироты (локального или сетевого) при неожиданном прерывании связи или завершении клиентского процесса.

Процессы-сироты расходуют системные ресурсы сервера и могут быть источником проблем. Существует несколько их решений:

    Уничтожение (англ. extermination) заключается в завершении процесса (например, посылкой сигнала SIGTERM или SIGKILL), используется наиболее часто (особенно оператором, обслуживающим систему).
    Перевоплощение (англ. reincarnation) — система пытается «воскресить» родителей в состоянии на момент перед их удалением или найти других (например, более старших) родителей.
    Выдача лимита времени (англ. expiration) — процессу выдаётся временная квота для завершения до момента, когда он будет «убит» принудительно. Отметим, что процессу оставлена возможность запросить дополнительное время для завершения.

В Unix-подобных системах все процессы-сироты немедленно усыновляются специальным системным процессом «init». Эта операция ещё называется переподчинением (англ. reparenting) и происходит автоматически. Хотя технически процесс «init» признаётся родителем этого процесса, его всё равно считают «осиротевшим», поскольку первоначально создавший его процесс более не существует. 
```
### Для увеличения количества максимума открытх файлов

```bash
$ ulimit -Sn
$ ulimit -Hn
# sysctl -w fs.file-max=500000
cat /proc/sys/fs/file-max
```
```/etc/sysctl.conf
fs.file-max=500000
```
```bash
# sysctl -p
```
4. Изучить, что показывает команда top.

```
Команда top в Unix-подобных операционных системах (например, Linux) показывает динамическую информацию о работающих процессах и общем состоянии системы в реальном времени. Вот что она отображает:

    Общая информация о системе:

        Время работы системы (uptime).

        Количество пользователей, подключенных к системе.

        Средняя загрузка системы за последние 1, 5 и 15 минут.

    Информация о задачах (процессах):

        Общее количество процессов.

        Количество запущенных, спящих, остановленных и зомби-процессов.

    Информация о использовании ресурсов:

        Использование процессора (CPU): процент времени, затраченного на выполнение пользовательских процессов, системных процессов, процессов с измененным приоритетом (nice), а также время простоя (idle).

        Использование оперативной памяти (RAM): общий объем, используемый объем, свободный объем, а также объем памяти, используемый для кэширования.

        Использование подкачки (swap): общий объем, используемый объем и свободный объем.

    Список процессов:

        PID (идентификатор процесса).

        Пользователь, от имени которого запущен процесс.

        Приоритет (PR) и значение nice (NI).

        Использование виртуальной памяти (VIRT), резидентной памяти (RES), разделяемой памяти (SHR).

        Процент использования процессора (%CPU) и памяти (%MEM).

        Время работы процесса (TIME+).

        Команда, запустившая процесс.

    Интерактивные команды:

        top позволяет управлять отображением и сортировкой процессов с помощью клавиш (например, P для сортировки по использованию CPU, M для сортировки по использованию памяти, k для завершения процесса и т.д.).
```

### HW2



1. Написать скрипт, если в файле есть слово "error", тогда удалить этот файл.

```bash
#!/bin/bash
echo "Написать скрипт, если в файле есть слово "error", тогда удалить этот файл."
# Путь к файлу
file_to_check="your_file.txt"

# Проверяем, содержится ли слово "error" в файле
if grep -q "error" "$file_to_check"; then
  # Если слово "error" найдено, удаляем файл
  rm "$file_to_check"
  echo "Файл $file_to_check был удалён, так как содержит слово 'error'."
else
  echo "Слово 'error' не найдено в файле $file_to_check."
fi

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
[Unit]
Description=ROT13 demo service
After=network.target
StartLimitIntervalSec=0[Service]
Type=simple
Restart=always
RestartSec=1
User=centos
ExecStart=/usr/bin/env bash /root/mycool_script.py

[Install]
WantedBy=multi-user.target
```

### HW3


1. Написать скрипт, пользователь вводит строку из букв и специальных символов в нижнем регистре и верхнем регистре. Нужно посчитать, сколько в этой строке больших букв.

```bash
#!/bin/bash
echo "Написать скрипт, пользователь вводит строку из букв и специальных символов в нижнем регистре и верхнем регистре. Нужно посчитать, сколько в этой строке больших букв."
# Запрос строки
read -p "Введите строку: " string
echo $string | sed -E 's/[[:lower:]]|[[:punct:]]|[[:space:]]//g' | wc -m


```


2. Написать скрипт, который будет делать ping google.com. Если сервер отвечает, то выводить - success, если нет - doesn't work.
```bash
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
```

3. Написать скрипт, который будет выводить текущую дату и время.
```bash
date
```
### HW4

1. Выкачать свой репозиторий с помощью ssh способа.
   +
3. С помощью .gitignore, сделать так, чтобы все файлы *.txt не попадали в репозиторий.

```
$GIT_DIR/hw2/error/*.txt
```
4. Изучить что такое git cherry-pick.
5. Продемонстрировать применение git cherry-pick на собственном репозитории (придумать любой пример).
6. Какая разница между git rebase и git merge ?
7. Какая разница между git pull и git fetch ?
8. Что такое git submodule ?
9. Изучить гит стратегии https://bool.dev/blog/detail/git-branching-strategies
10. Установить Docker на Ubuntu.

### HW5

1. Зарегистрироваться в Dockerhub.
2. Создать свой любой имадж(использовать Dockerfile) и запушить имадж в свой репозиторий в Dockerhub. Репозиторий сделать приватный.
3. Изучить разницу между CMD и Entrypoint.

### HW6

1. Через volume подкинуть конфиг в nginx контейнер, чтобы на страничке в браузере появилась слово Docker (либо через curl это проверить).
2. То же самое сделать через docker-compose.

### HW7

1. Развернуть Jenkins.
2. Подключить Linux Slave к Jenkins.
3. Создать Jenkins pipeline, pipeline должен уметь разворачивать ELK stack. Если не хватает ресурсов, тогда развернуть только Elasticsearch.
   ELK стек должен разворачиваться на новом слейве.
