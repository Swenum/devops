
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



