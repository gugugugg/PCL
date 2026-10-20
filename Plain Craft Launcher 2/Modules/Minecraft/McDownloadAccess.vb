Imports Microsoft.Win32

'解锁状态独立保存；替换启动器文件或升级版本不会丢失。
Friend NotInheritable Class McDownloadAccess
    Private ReadOnly RegistryPath As String

    Public Sub New(RegistryPath As String)
        Me.RegistryPath = RegistryPath
    End Sub

    Public ReadOnly Property IsRestricted As Boolean
        Get
            Try
                Using Key = Registry.CurrentUser.OpenSubKey(RegistryPath)
                    Return Key Is Nothing OrElse Not Object.Equals(Key.GetValue("MinecraftDownloadUnlocked"), 1)
                End Using
            Catch ex As System.Security.SecurityException
                Return True
            Catch ex As UnauthorizedAccessException
                Return True
            End Try
        End Get
    End Property

    Public Function TryUnlock(Command As String) As Boolean
        If Command Is Nothing OrElse Command.Trim() <> "114514" Then Return False
        Using Key = Registry.CurrentUser.CreateSubKey(RegistryPath)
            Key.SetValue("MinecraftDownloadUnlocked", 1, RegistryValueKind.DWord)
            Key.Flush()
        End Using
        Return Not IsRestricted
    End Function
End Class
