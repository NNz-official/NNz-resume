周鸿展 · Typst 简历工程

当前版本已录入两段任职经历和用户确认的项目职责分类。项目日期与任职阶段已补充，具体成果与硕士毕业状态仍待确认，PDF 保留核对版标记。

文件说明
  content/resume.yaml       简历显示内容；后续主要修改这里。
  content/verification.yaml 事实依据、待确认事项与未选项目。
  content/project-roles.yaml 用户确认的完整项目职责清单，供后续选项目参考。
  手动修改指南.txt          手动编辑内容、增加项目和编译预览的示例。
  resume.typ                A4 单栏双页模板；字体与样式集中管理。
  build.ps1                 编译或监听脚本，优先使用 PATH 中的 Typst。
  output/pdf/               PDF 输出。
  .tools/                   本次从 Typst 官方 GitHub Releases 下载的便携编译器 0.15.1。
  tmp/pdfs/                 排版检查临时文件。

Typst 已安装
已检测到 WinGet 安装的 Typst。本次更新使用该已安装版本编译；脚本依次查找 PATH、WinGet 安装目录和工程内便携版，兼容当前进程 PATH 尚未刷新的情况。
新打开 PowerShell 后可执行 typst --version 检查。

编译（从任意目录均可）：
  & 'D:/Data/code/nodesk/resume/build.ps1'
持续预览编译：
  & 'D:/Data/code/nodesk/resume/build.ps1' -Watch
或切换到本工程目录后直接执行：
  typst compile resume.typ output/pdf/周鸿展-简历.pdf

布局与维护
模板不依赖在线包。使用 Windows Microsoft YaHei 与 Arial；跨设备复现需提供相同字体，或换为有授权的统一字体并调整模板。
第一页为概述、两段任职、三个正式任职项目与教育；第二页为知识与技能资产、模型服务、两项实习项目、两个早期项目、能力与奖项。
项目顺序可以随求职方向调整。项目时间与具体成果确认后，再更新核对版标记。
旧简历的 mIoU 和推理时间保留历史来源与缺失口径，尚未进行新的性能复测。
本工程独立维护；本轮仅修改简历工程，未改动作品集或业务代码。
