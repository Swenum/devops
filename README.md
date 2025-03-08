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
ssh-add ~/.ssh/kurs_devops2025
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
#### Работа с ветками:
```bash
# СОздать ветку
$ git branch <name of new branch>
# Перейти в ветку
$ git checkout <name of branch>
```

#### История кооммитов
```bash
git log --graph
```

#### Разница между двумя коммитами
```bash
git diff id-commit id2-commit
```

### Для увеличения количества максимума открытых файлов

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



