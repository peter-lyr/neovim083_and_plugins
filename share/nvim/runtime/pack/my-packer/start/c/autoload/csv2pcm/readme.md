将一至多个csv文件拖拽到csv2pcm.exe，
将在所有csv文件所在目录创建output目录，
比如C:\Users\l\Desktop\data.csv，
将输出C:\Users\l\Desktop\output\data.csv.pcm。

排除第一行，将第3列（从1列开始数）的数据，以16bit，二进制格式，
写道pcm文件。

增加.ini文件
csv2pcm.ini
如果没有csv2pcm.ini，执行csv2pcm.exe会创建一个，默认值如下
```ini
[config]
skip_line_numbers=1
sel_columns=3
```

说明：
```ini
[config]
skip_line_numbers=1
sel_columns=2,3,4,5 ; 从1开始
; sel_columns=3时，以下行获取到的是2
; sel_columns=3,4时，以下行获取到的是2
; sel_columns=2,3,4时，以下行获取到的是0和2
; sel_columns=1,2,3,4时，以下行获取到的是0,0和2
; sel_columns=1,2,3时，以下行获取到的是0,0和2
; 0.207591855,0,,0x02,
; 转换成16bit整型数据
```
