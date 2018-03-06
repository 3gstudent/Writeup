1.create file

```
md test.{1D2680C9-0E2A-469d-B787-065558BC7D43}
```

2.Get the short name

The short name is `TEST~1.{1D`

3.Copy file

```
copy mimikatz.exe .\TEST~1.{1D\newmimikatz.exe
```
4.File the file

```
dir c:\ /s /b | find "newmimikatz.exe"
```

The path is `c:\test\test.{1D2680C9-0E2A-469d-B787-065558BC7D43}\newmimikatz.exe`

But we can't find it by the following:



