# 南京大学电子科学与工程学院实验报告 LaTeX 模板

此 LaTeX 模板是根据 南京大学电子信息专业国家级实验教学示范中心 提供的官方 Word 实验报告模板相应制作而成，适用于撰写规范、美观的实验报告。已优化为 **Markdown + Pandoc** 工作流，支持便捷的自动化编译。

## 📄 模板来源与对照

本模板对应实验中心提供的 Word 模板格式设计，包括页眉、标题、章节格式、信息填写区域等。原始 Word 模板已包含在项目根目录下，方便后续同学：

- 对比格式是否发生变化
- 在模板更新时参考修改 LaTeX 模板
- 了解原始格式要求

建议在每次使用前，先查看 Word 模板是否有版本更新，以确保 LaTeX 模板的格式仍然符合最新要求。

（当然，如果与给定的word模版稍有不同也没太大关系，以我的个人经验不会对给分有什么影响，而且有些助教批改时看出你用LaTeX还会给高点）

## 🚀 工作流概述

### 推荐工作流：Markdown 编写 + Pandoc 自动生成

本项目支持使用 **Markdown** 编写实验内容、通过 **Pandoc** 自动转换生成 LaTeX 和 PDF：

- **`content.md`** - 在此使用 Markdown 编写实验报告内容
- **`template2.tex`** - Pandoc 使用的 LaTeX 模板（自动填充样式）
- **`Makefile`** - 自动化编译脚本，一键生成 PDF 和 TeX 文件

**优势：**
- 只需编写 Markdown，无需直接修改 LaTeX 代码
- 支持自动编号、交叉引用、图表等高级功能
- 自动化编译，省去手动配置

**替代方案：直接编写 LaTeX**

如需直接编写 LaTeX（不使用 Markdown），可改用 `template.tex`，使用 XeLaTeX 编译。

## 🛠 环境要求

### 快速设置（推荐 Markdown 工作流）

1. **TeX 发行版**（支持 XeLaTeX）
   - Windows: MiKTeX 或 TeX Live
   - macOS: MacTeX
   - Linux: TeX Live

2. **Pandoc**（用于 Markdown 转换）
   ```bash
   # Windows (使用 Chocolatey)
   choco install pandoc

   # macOS
   brew install pandoc

   # Linux
   apt install pandoc  # Debian/Ubuntu
   ```

3. **中文字体**（用于页眉）
   - 推荐：`华文行楷`（STXingkai）
   - 备选：KaiTi 等其他楷体

4. **GNU Make**（用于运行 Makefile）
   - Windows: 通过 MinGW-w64 或 WSL
   - macOS/Linux: 通常已内置

### 可选：pandoc-crossref 过滤器

若需使用图表交叉引用功能，安装：
```bash
pandoc-crossref  # 用于自动图表编号
```

## 🚀 快速开始

### 方式 1: Markdown 工作流（推荐）✨

1. **编辑 `content.md`**  
   编写你的实验报告内容，支持：
   - Markdown 语法（标题、列表、代码块等）
   - LaTeX 数学公式
   - 交叉引用（图、表、公式）
   - 插入图片

2. **YAML 前置信息**  
   在 `content.md` 顶部填写个人信息：
   ```yaml
   ---
   name: "你的名字"
   id: "学号"
   major: "专业"
   grade: "年级"
   course: "课程名称"
   semst: "学年学期"
   exp_name: "实验名称"
   time: "实验时间"
   room: "实验教室"
   teacher: "指导教师"
   packages: "LaTeX 所需包（用逗号分隔）"
   ---
   ```

3. **运行编译**  
   ```bash
   make all       # 同时生成 PDF 和 TeX 文件到 build/
   make clean     # 清理生成的文件
   ```

   生成的文件：
   - `build/test.pdf` - 最终 PDF 报告
   - `build/test.tex` - LaTeX 源文件（可选）

### 方式 2: 直接 LaTeX 编写

如不使用 Markdown，直接编辑 `template.tex`：

1. **填写个人信息**

   在 `template.tex` 中找到以下部分，替换为你的信息：

   ```latex
   {\songti \bfseries 姓\ \ 名:}    & \fillinblank{10em}{张三李四} &
   {\songti \bfseries 学\ \ 号:}     & \fillinblank{10em}{231180000}\\
   {\songti \bfseries 专\ \ 业:}     & \fillinblank{10em}{神秘专业} &
   {\songti \bfseries 年\ \ 级:}     & \fillinblank{10em}{2023级}\\
   ... 其他字段类似
   ```

2. **设置课程名称**

   需要修改两处课程相关名称：

   - 页眉处（右上角）：找到 `\fancyhead[R]{\zihao{-5}\songti{课程名称实验报告}}`，将"课程名称实验报告"替换为你的课程名称后加"实验报告"，例如"电路分析实验报告"。
   - 封面表格中：找到"课程名称:"和"实验名称:"对应的 `\fillinblank{...}{...}`，分别替换为实际的课程名称和实验名称。

3. **插入校徽图片**

   模板默认使用 `nju_logo.jpg` 作为校徽图片，请确保该图片文件与 `.tex` 文件在同一目录下。

4. **编写实验内容**

   从 `\section{sec1}` 开始编写你的实验报告正文。你可以使用以下章节命令：

   - `\section{...}` → 一级标题
   - `\subsection{...}` → 二级标题
   - `\subsubsection{...}` → 三级标题
   - `\paragraph{...}` → 四级标题（不推荐频繁使用）

5. **编译生成 PDF**

   推荐使用 **TexStudio** 软件，并在选项中将默认构建器设为 **XeLaTex** ！

## 📁 项目文件结构

```
.
├── README.md              # 本文件
├── content.md             # Markdown 实验内容（推荐使用）
├── template.tex           # 原始 LaTeX 模板（可选）
├── template2.tex          # Pandoc 使用的 LaTeX 模板
├── Makefile               # 自动化编译脚本
├── .gitignore             # Git 忽略规则
├── build/                 # 编译输出目录
│   ├── test.pdf           # 生成的 PDF 文件
│   └── test.tex           # 生成的 LaTeX 文件
└── fig/                   # 图片存放目录
```

## 📌 注意事项

1. **字体问题**：如果系统缺少"华文行楷"字体：
   - 安装该字体，或
   - 在模板中将 `\setCJKfamilyfont{mhwxk}{STXingkai}` 改为其他已安装的楷体字体，如 `\setCJKfamilyfont{mhwxk}{KaiTi}`

2. **文档类**：模板默认使用 `ctexart` 文档类，支持中文排版和章节标题格式。

3. **格式调整**：如需调整页边距、行距等格式，可修改 `geometry` 和 `linespread` 参数。

4. **配置**：模板已配置超链接和页眉样式，无需额外设置。

## 🛠 更新与贡献

如果实验中心更新了格式要求，欢迎提交 Pull Request 更新 LaTeX 模板以保持同步。

## 📄 许可证

本项目模板仅限南京大学学生撰写实验报告使用，遵循实验中心相关格式要求。原始 Word 模板版权归南京大学电子信息专业国家级实验教学示范中心所有。
