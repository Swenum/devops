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
