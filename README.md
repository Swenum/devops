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
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDImDp8kZKfq+OBcaWLIvshozRogPTv63Kd8Nbz6+Esas3uCoiQoPjHKV3aScDBR0tBPQobemaVICUuihJ/ONjhtV1LPDuZAhVoThtQ6aJJwH5425lgd8F9zQ/JXAuJC9+yOQsg+87mzKFcrg+zudfQ2vOfbNxYkrrsG7+kyZSFwyRioFBNSF+u0yqJWNfnytkWDaULqEVxi4CSycnW/aMHZ6yA5Xadb3sTUhMiXwXbJXVmXUuvBahPXzhToc62+uqPzChqgIoUSRNH7KJZqzttow6sNnnbUrEewQTSf6UZTEIjw4GFBV911yInF8EEZDXFzpiGJZbeuueml2bVsyNB swenum@uladzimir" > /home/"$USER"/.ssh/authorized_keys
echo "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAgEA2cAT60z9sWO1Uzz4nURqXUq66kkhjbZ3CXOkOkfouRuspTp4C4JmV+qUZ7dC2niuPTNCV00UIHkUKvX/r5vPUd0KLDw9vTIMOCte6DG1XYeg8aB15iyNt951updJ9zBV+L69iCp8r02zvbb2JzmrhAlNyhENX+6cBc9ToH6oiTFoAjgjxZTT3c3VfaO87APp4tYeYUUecoZHwEKegKO54+uS3gYQ4+nf/Nzs4aw2gPrPqNjUr4viQBdIFgb+jy473v/KUcwn77DmTLsgARgn+QoBfFNKR3FxReVG00wAAzlekjsJKGF+EkzvnRCu5XckciDG+WU1/q4hz9IFsGRQPMywDwkNRVIlZIpft+d7JTpdvWMmApy5L67NIt0xFV1wOXSmJtKZdI+r93j7sMAHKrSMaZoHRBzWlhZKVMaFZpgNOUw0oKld3qxByMo1N/71sOnwyGImLOE/BdhwWPS4aK5UHU45p7h/fo2T5xZufI+yYpdA4AZqzpCBRA+zi2uko0sS916tnubdcI+21tUvwEe8HaltNgzQmItXrW4cHgtzymeNR7GRVcjCnpjZrKUQ5ddgi9kuHoQdBUyzftvzEHcqkMED8AheLAd+WFGwAKvDDS4rJjAnAI0PqvetIbL4G6u2uRbDZLQRipI0FvB5urA6WfUw8Ez5RhBSlkD/GR0= rsa-key-20191204-test-env" >> /home/"$USER"/.ssh/authorized_keys
echo "ssh-ed448 AAAACXNzaC1lZDQ0OAAAADlL4ph5NNzIe+vjO6E/NzfGkJXtAzhx7AJ4G/a6QiLp1K6CZdbeoTrVRCX0zcBOFdaxZaImZ/qmhQA= eddsa-key-my" >> /home/"$USER"/.ssh/authorized_keys
chown "$USER":"$USER" /home/"$USER" -R
chmod 600 /home/"$USER"/.ssh/authorized_keys
chmod 700 /home/"$USER"/.ssh
usermod -G sudo "$USER"
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

4. Изучить, что показывает команда top.

### HW2



1. Написать скрипт, если в файле есть слово "error", тогда удалить этот файл.

```bash
#!/bin/bash

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

2. Написать скрипт, который будет создавать пользователя, имя пользователя должно вводится с клавиатуры.
Если пользователь существует, то вывести сообщение об этом.





3. Что такое systemd ?


4. Написать любой сервис в линуксе.


### HW3


1. Написать скрипт, пользователь вводит строку из букв и специальных символов в нижнем регистре и верхнем регистре. Нужно посчитать, сколько в этой строке больших букв.

2. Написать скрипт, который будет делать ping google.com. Если сервер отвечает, то выводить - success, если нет - doesn't work.


3. Написать скрипт, который будет выводить текущую дату и время.

### HW4

1. Выкачать свой репозиторий с помощью ssh способа.
2. С помощью .gitignore, сделать так, чтобы все файлы *.txt не попадали в репозиторий.
3. Изучить что такое git cherry-pick.
4. Продемонстрировать применение git cherry-pick на собственном репозитории (придумать любой пример).
5. Какая разница между git rebase и git merge ?
6. Какая разница между git pull и git fetch ?
7. Что такое git submodule ?
8. Изучить гит стратегии https://bool.dev/blog/detail/git-branching-strategies
9. Установить Docker на Ubuntu.

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
