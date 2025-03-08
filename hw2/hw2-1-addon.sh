#!/bin/bash
echo "Написать скрипт, если в файле есть слово "error", тогда удалить этот файл."
# Путь к файлу
file_to_check="error/file.txt"
echo "error" > $file_to_check
# Проверяем, содержится ли слово "error" в файле
if grep -q "error" $file_to_check; then
  # Если слово "error" найдено, удаляем файл
  rm $file_to_check
  echo "Файл $file_to_check был удалён, так как содержит слово 'error'."
else
  echo "Слово 'error' не найдено в файле $file_to_check."
fi
