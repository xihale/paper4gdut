# 广东工业大学本科毕业设计（论文）Typst 模板

一个符合广工格式规范的本科毕业设计论文模板，支持自定义本地字体配置。

## 特性

- 完整的毕业设计（论文）结构：封面、中英文摘要、目录、正文、附录
- 符合广工格式规范：页面布局、字体大小、标题层级、行距等
- 灵活的字体配置：支持本地字体强制覆盖
- 便于扩展的组件：代码块、公式编号等
- 清晰的章节结构示例

## 快速开始

### 1. 安装 Typst

参考 [Typst 官网](https://typst.app/) 安装命令行工具或使用在线编辑器。

### 2. 克隆或复制模板

将模板文件复制到你的项目中，确保目录结构如下：

```
paper4gdut/
├── template.typ      # 核心模板
├── main.typ          # 论文主文件
├── chapters/         # 章节目录
│   ├── 1-introduction.typ
│   ├── 2-related.typ
│   ├── 3-method.typ
│   ├── 4-experiment.typ
│   ├── 5-conclusion.typ
│   └── appendix.typ
└── images/           # 图片资源（可选）
    └── head.webp     # 校徽图片（用于封面）
```

### 3. 配置字体（可选）

如果需要在没有预装字体的环境中使用，或者想使用特定版本的字体，可以在 `main.typ` 开头配置本地字体：

```typst
#import "template.typ": *
#import "template.typ": configure-fonts  // 导入配置函数

// 启用本地字体（默认使用系统字体如 SimSun、SimHei）
configure-fonts(
  songti: "/absolute/path/to/simsun.ttf",  // 宋体
  heiti: "/absolute/path/to/simhei.ttf",   // 黑体
  times: "/absolute/path/to/times.ttf",    // Times New Roman
  code: "/absolute/path/to/jetbrainsmono.ttf", // 代码字体
  enable: true
)
```

**注意**：不配置字体或 `enable: false` 时，模板会使用默认的系统字体名（Windows 自带：SimSun、SimHei、Times New Roman）。

### 4. 修改论文信息

编辑 `main.typ`，填入你的论文信息：

```typst
#thesis(
  title: "你的论文题目",
  author: "你的姓名",
  student_id: "你的学号",
  advisor: "指导教师",
  major: "你的专业",
  school: "你的学院",
  class_info: "年级班别，如 2022级 1班",
  abstract_cn: [中文摘要内容...],
  keywords_cn: ("关键词1", "关键词2"),
  abstract_en: [English abstract...],  // 可选
  keywords_en: ("keyword1", "keyword2"), // 可选
  header_text: "页眉显示的文字（可为空，默认使用论文题目）"
)[
  #include "chapters/1-introduction.typ"
  // ... 其他章节
]
```

### 5. 编写章节内容

在 `chapters/` 目录下编写各章节内容，使用标准的 Typst 语法。常用的命令：

- 一级标题：`= 引言`
- 二级标题：`== 研究背景`
- 三级标题：`=== 国内外研究`
- 图片：`#figure(image("path.jpg"), caption: [图片说明])`
- 表格：使用 `table` 函数
- 公式：`$E = mc^2$`
- 引用：`#cite(...)`（需另外配置参考文献系统）

### 6. 编译

```bash
typst compile main.typ
```

输出文件为 `main.pdf`。

## 模板参数说明

### `#thesis(...)` 参数

| 参数 | 类型 | 说明 |
|------|------|------|
| `title` | `string` | 论文题目（必填，封面和页眉使用） |
| `author` | `string` | 作者姓名（必填） |
| `student_id` | `string` | 学号（必填） |
| `advisor` | `string` | 指导教师（必填） |
| `major` | `string` | 专业名称（必填） |
| `school` | `string` | 学院名称（必填） |
| `class_info` | `string` | 年级班别（必填） |
| `grade` | `string` | 成绩（答辩后填写，可选） |
| `date` | `datetime` | 提交日期（默认今天） |
| `abstract_cn` | `content` | 中文摘要（必填） |
| `keywords_cn` | `array` | 中文关键词数组（必填） |
| `abstract_en` | `content` | 英文摘要（推荐填写） |
| `keywords_en` | `array` | 英文关键词（推荐填写） |
| `header_text` | `string \| none` | 页眉文字，默认使用论文题目 |
| `body` | `content` | 正文内容，使用 `#include` 包含各章节 |

### 字体配置函数

```typst
configure-fonts(
  songti: string,    // 宋体字体路径或名称
  heiti: string,     // 黑体字体路径或名称
  times: string,     // 英文字体路径或名称
  code: string,      // 代码字体路径或名称
  enable: bool       // 是否启用本地字体，默认 true
)
```

**使用示例**：

```typst
// 禁用本地字体，使用系统默认字体
configure-fonts(enable: false)

// 指定字体路径
configure-fonts(
  songti: "C:/Windows/Fonts/simsun.ttc",
  heiti: "C:/Windows/Fonts/simhei.ttf",
  enable: true
)
```

## 目录结构建议

```
your-project/
├── main.typ          # 主文件
├── template.typ      # 模板（建议保持原样，勿修改）
├── chapters/         # 章节文件
│   ├── 0-abstract.typ    # 摘要（可选，也可写在 main.typ）
│   ├── 1-introduction.typ
│   ├── 2-related.typ     # 文献综述/相关技术
│   ├── 3-method.typ      # 方法论
│   ├── 4-experiment.typ  # 实验
│   ├── 5-conclusion.typ  # 结论
│   └── appendix.typ      # 附录
├── images/           # 图片资源
└── bibliography.bib  # 参考文献（可选）
```

## 注意事项

1. **字体问题**：确保系统已安装中文字体（SimSun、SimHei）和英文字体（Times New Roman）。如果编译时出现字体缺失警告，请检查字体名称是否正确，或使用本地字体配置。

2. **图片路径**：在章节中使用相对路径引用图片，路径相对于 `main.typ` 所在目录。

3. **封面图片**：模板默认使用 `images/head.webp` 作为校徽图片。请替换为你的学校 logo 或删除封面图片相关代码。

4. **页眉页脚**：页眉默认为论文题目，可通过 `header_text` 参数覆盖。页脚为页码，位于右下角。

5. **图表编号**：图片自动标记为"图 X"，表格自动标记为"表 X"。

6. **代码块**：使用 `code_block(content, caption: "程序清单 X")` 函数来渲染带编号的代码块。

## 自定义

如需修改样式，可以编辑 `template.typ`：

- 页面边距：`set page(margin: ...)`
- 字体大小和行距：`set text(...)` 和 `set par(leading: ...)`
- 标题样式：`show heading.where(level: N): ...`
- 页眉页脚内容：修改 `header` 和 `footer` 配置

## 常见问题

**Q: 编译时报错找不到字体**
A: 使用本地字体配置功能，指定系统中存在的字体文件路径。或者确保系统已安装 SimSun、SimHei 等字体。

**Q: 如何添加参考文献？**
A: 结合 BibTeX 使用。Typst 支持 `.bib` 文件，通过 `#bibliography("bibliography.bib")` 引用。

**Q: 如何调整行距？**
A: 在 `template.typ` 中找到 `set par(leading: 1.5em, ...)`，修改 `leading` 值。

**Q: 如何添加新的章节？**
A: 在 `chapters/` 目录创建新文件（如 `6-future.typ`），然后在 `main.typ` 的 `#thesis(...)[...]` 块中添加 `#include "chapters/6-future.typ"`。

## License

MIT License

## 贡献

欢迎提交 Issue 和 Pull Request。

---

祝你论文顺利！
