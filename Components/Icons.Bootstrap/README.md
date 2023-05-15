## [Bootstrap Icons](https://react-icons.github.io/react-icons/icons?name=bs)

```powershell
Install-Module Universal.Icons.Bootstrap
New-UDBootstrapIcon -Icon "BsFillBox2Fill"
```

### Size

Adjust the size of the icon.

```powershell
New-UDBootstrapIcon -Icon "BsFillBox2Fill" -Size '20em'
```

### Styling

Adjust the style of the icon.

```powershell
New-UDBootstrapIcon -Icon "BsFillBox2Fill" -Style @{
    backgroundColor = "red"
}
```