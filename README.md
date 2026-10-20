# Plain Craft Launcher

本仓库为 [gugugugg/PCL](https://github.com/gugugugg/PCL) 独立维护的 fork，基于上游 `2.99.0.0`（`6b9a50df911c9d68b69b24c979efba477fb14b67`）。日常维护分支为 [`codex/2.99-maintenance`](https://github.com/gugugugg/PCL/tree/codex/2.99-maintenance)。

此分支关闭 `RestrictMcDownload`，保留 MC 本体下载、整合包安装和已安装实例的 MC 版本切换，并同步修正更新提示。其他代码及 MeloongCore 子模块保持 2.99.0.0 基线。

本地 `origin` 指向此 fork，`upstream` 指向 `Meloong-Git/PCL`；后续改动提交到维护分支，上游更新由维护者手动审查并合入。开源构建的微软登录、CurseForge API 仍需自行配置 `PCL_MS_CLIENT_ID`、`PCL_CURSEFORGE_API_KEY`，不要将密钥提交到仓库。

克隆时使用 `git clone --recurse-submodules --branch codex/2.99-maintenance https://github.com/gugugugg/PCL.git`。构建方式见 `.github/workflows/build.yml`：先执行 `dotnet restore PCLCS/PCLCS.csproj`，再通过 Visual Studio MSBuild 编译 `Plain Craft Launcher 2/Plain Craft Launcher 2.vbproj`，配置选择 `Release` 或 `Debug`。

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
