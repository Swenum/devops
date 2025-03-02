#!/usr/bin/bash

output_file="top_directories.txt"

# Получаем топ-7 директорий, занимающих больше всего места
du -ah / | sort -rh | head -n 7 > "$output_file"


echo "Топ-7 директорий, занимающих больше всего места, записан в файл $output_file"
