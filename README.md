# Plain Craft Launcher

本启动器为 **PCL 单独维护版**，基于上游 `2.99.0.0` 单独维护，当前版本为 **3.00.0.0**。仓库：[gugugugg/PCL](https://github.com/gugugugg/PCL)，开发分支：`codex/3.00.0.0`。本版本新增了控制台功能，默认保留 MC 游戏本体下载限制。

> **一定不要按 F3 打开控制台后输入 114514 啊！如果输入了，会造成未知后果，对造成的后果，我概不负责。**

控制台支持 Enter 执行、Esc 关闭。上述提醒是彩蛋文案，命令的实际作用是永久解锁 MC 本体下载、整合包安装和 MC 版本切换，不执行其他操作。解锁状态保存在当前 Windows 用户的 `HKCU\Software\PCLFork\DownloadAccess` 中，重启、替换程序或后续升级不会清除；其他用户不会自动解锁。

### 替换原版更新

在 [Releases](https://github.com/gugugugg/PCL/releases) 下载 `PCL-3.00.0.0-update.zip`，解压后双击“更新启动器.cmd”，选择原来的启动器 EXE。更新器会检查原程序已退出，将原 EXE 备份到同一目录后替换。也可以直接将包内 `PCL.exe` 改成原启动器的文件名，关闭原程序后覆盖原 EXE。

更新只替换启动器 EXE，保留 `PCL`、`.minecraft`、实例目录和存档。非加密的原版注册表偏好会作为默认值继续读取；本维护版的账号缓存、识别码和新设置使用独立的 `HKCU\Software\PCLFork`，避免误写原版加密数据。**原版账号缓存不能保证迁移，可能需要重新登录。** 回退时关闭程序，用备份 EXE 替换回来即可。

此构建来自上游公开代码，未包含官方专有服务凭据。微软登录需要自行配置 `PCL_MS_CLIENT_ID`，CurseForge API 需要 `PCL_CURSEFORGE_API_KEY`；未配置时，这两类服务不保证可用。本地实例和存档的保留不代表微软重新登录已经验证。不要把这些凭据提交到仓库。

### 开发与验证

`origin` 为本 fork，`upstream` 为 `Meloong-Git/PCL`。原来的 `codex/2.99-maintenance` 分支保留不变，本版本在 `codex/3.00.0.0` 分支独立维护。克隆时使用 `--recurse-submodules`。构建命令见 `.github/workflows/build.yml`；CI 编译 Debug、Release，并对编译后的解锁逻辑执行默认限制、错误输入、正确输入、持久化和跨进程恢复检查。

[![Stars](https://img.shields.io/github/stars/Meloong-Git/PCL?style=flat&logo=data:image/svg%2bxml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZlcnNpb249IjEiIHdpZHRoPSIxNiIgaGVpZ2h0PSIxNiI+PHBhdGggZD0iTTggLjI1YS43NS43NSAwIDAgMSAuNjczLjQxOGwxLjg4MiAzLjgxNSA0LjIxLjYxMmEuNzUuNzUgMCAwIDEgLjQxNiAxLjI3OWwtMy4wNDYgMi45Ny43MTkgNC4xOTJhLjc1MS43NTEgMCAwIDEtMS4wODguNzkxTDggMTIuMzQ3bC0zLjc2NiAxLjk4YS43NS43NSAwIDAgMS0xLjA4OC0uNzlsLjcyLTQuMTk0TC44MTggNi4zNzRhLjc1Ljc1IDAgMCAxIC40MTYtMS4yOGw0LjIxLS42MTFMNy4zMjcuNjY4QS43NS43NSAwIDAgMSA4IC4yNVoiIGZpbGw9IiNlYWM1NGYiLz48L3N2Zz4=&logoSize=auto&label=Stars&labelColor=444444&color=eac54f)](https://github.com/Meloong-Git/PCL/)
[![Issues](https://img.shields.io/github/issues/Meloong-Git/PCL?style=flat&label=Issues&labelColor=444444&color=1F883D)](https://github.com/Meloong-Git/PCL/issues)
[![哔哩哔哩](https://img.shields.io/badge/动态-BiliBili-00A4DB?style=flat&labelColor=444444&logoSize=auto)](https://space.bilibili.com/11343203/dynamic)
[![爱发电](https://img.shields.io/badge/赞助-爱发电-946ce6?style=flat&labelColor=444444&logoSize=auto)](https://meloong.com/afd/a/LTCat)

包含 PCL 的大部分源代码，包括 UI 库、动画模块、下载模块、Minecraft 启动模块等！<br/>
代码并不是实时更新的，它会在每次 PCL 发布更新时同步一次。<br/>
非常感谢社区的大力支持！

<br/>

### 相关资源
- [PCL 下载](https://meloong.com/pcl)：下载可免费使用的正式版 PCL！
- [PCL 功能投票](https://github.com/Meloong-Git/PCL/discussions/2)：来参加投票吧，开发者会优先处理票数较高的项目！
- [帮助文档库](https://github.com/LTCatt/PCL2Help)：PCL 内置帮助文档的存储库
