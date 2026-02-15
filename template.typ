// 广东工业大学论文模板 - 通用版本
// 支持本地字体强制覆盖配置

// 导入封面模块
#import "chapters/0-thesis-cover.typ": thesis-cover
#import "chapters/0-course-report.typ": course-report-cover

// =================== 字体配置系统 ===================

// 默认字体（系统预设）
#let default-songti = "SimSun"
#let default-heiti = "SimHei"
#let default-times = "Times New Roman"
#let default-arial = "Arial"
#let default-code = "JetBrainsMono NF"

// 本地字体覆盖变量（通过 configure-fonts 设置）
#let local-songti = none
#let local-heiti = none
#let local-times = none
#let local-arial = none
#let local-code = none

// 是否启用本地字体（默认 false）
#let use-local-fonts = false

// 字体配置函数：设置本地字体路径
// 参数：
//   songti: 宋体字体路径
//   heiti: 黑体字体路径
//   times: Times New Roman 字体路径
//   arial: Arial 字体路径（一级标题使用）
//   code: 代码字体路径
//   enable: 是否启用本地字体
#let configure-fonts(
  songti: none,
  heiti: none,
  times: none,
  arial: none,
  code: none,
  enable: true
) = {
  if songti != none { local-songti = songti }
  if heiti != none { local-heiti = heiti }
  if times != none { local-times = times }
  if arial != none { local-arial = arial }
  if code != none { local-code = code }
  use-local-fonts = enable
}

// 解析字体名称
#let resolve-font(name, default) = {
  if not use-local-fonts { return default }
  let val = if name == "songti" { local-songti } else if name == "heiti" { local-heiti } else if name == "times" { local-times } else if name == "arial" { local-arial } else if name == "code" { local-code } else { none }
  if val != none { val } else { default }
}

// 实际使用的字体定义
#let songti = resolve-font("songti", default-songti)
#let heiti = resolve-font("heiti", default-heiti)
#let times = resolve-font("times", default-times)
#let arial = resolve-font("arial", default-arial)
#let code_font = resolve-font("code", default-code)

// 导出字体变量供封面模块使用
#let fonts = (songti: songti, heiti: heiti, times: times, arial: arial, code: code_font)

// Graphviz 图表渲染配置
#let raw_render_custom(dot_content, width: 100%) = {
  import "@preview/diagraph:0.3.6": raw-render
  raw-render(dot_content, width: width)
}

// =================== 通用设置函数 ===================

// 通用格式设置
#let common-settings(body) = {
  // 页面布局（广工规范）
  // 上边距 30mm, 下边距 25mm, 左边距 30mm, 右边距 20mm
  set page(
    paper: "a4",
    margin: (top: 30mm, bottom: 25mm, left: 30mm, right: 20mm),
  )

  // 全局文本样式
  // 中文字体：宋体，英文字体：Times New Roman，字号：12pt（小四）
  set text(font: (times, songti), size: 12pt, lang: "zh", weight: 400)
  // 行距：1.5倍，首行缩进：2字符，两端对齐
  set par(leading: 1.5em, first-line-indent: 2em, justify: true)

  // 标题编号格式：1.  1.1  1.1.1
  set heading(numbering: "1.1.1")

  // 一级标题：16pt 黑体加粗，Arial 西文，居中，段前分页
  // 注：dotx 规范要求一级标题使用 Arial(西文)+黑体(中文)，16pt
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    v(2em)
    align(center)[
      #text(font: (arial, heiti), size: 16pt, weight: "bold")[#it.body]
    ]
    v(1.5em)
  }

  // 二级标题：16pt 黑体加粗，继承一级标题格式
  show heading.where(level: 2): it => {
    v(1em)
    text(font: (arial, heiti), size: 16pt, weight: "bold")[#it.body]
    v(0.5em)
  }

  // 三级标题：16pt 黑体加粗，段前段后间距约 0.5cm
  show heading.where(level: 3): it => {
    v(0.5em)
    text(font: (arial, heiti), size: 16pt, weight: "bold")[#it.body]
    v(0.5em)
  }

  // 四级标题：14pt 黑体加粗
  show heading.where(level: 4): it => {
    v(0.5em)
    text(font: (arial, heiti), size: 14pt, weight: "bold")[#it.body]
    v(0.5em)
  }

  // 粗体/斜体样式覆盖
  show strong: set text(font: (times, heiti), weight: 400)
  show emph: set text(style: "normal")

  // 图表编号样式
  show figure.where(kind: image): set figure(supplement: [图])
  show figure.where(kind: table): set figure(supplement: [表])
  show figure: set text(size: 10.5pt)

  body
}

// =================== 本科毕业设计（论文）模板 ===================

// 辅助函数：下划线填空
#let field(content, width: 100%) = {
  box(width: width, {
    set align(center + bottom)
    v(4pt)
    text(font: songti, size: 16pt)[#content]
    v(-4pt)
    line(length: 100%, stroke: 0.7pt)
  })
}

// 辅助函数：分散对齐的标签（如"学 院"）
#let label-text(str) = {
  text(font: heiti, size: 16pt, weight: "bold")[#str]
}

// thesis: 生成广东工业大学本科毕业设计（论文）
// 按照 dotx 文档格式规范
#let thesis(
  title: "",
  title_en: "",  // 外文题目（可选）
  author: "",
  student_id: "",
  advisor: "",
  major: "",
  school: "",
  class_info: "",
  date: datetime.today(),
  abstract_cn: [],
  keywords_cn: (),
  abstract_en: [],
  keywords_en: (),
  header_text: none,
  show_cover: true,  // 是否显示封面
  doc_body
) = {
  // 页面布局（广工规范）
  set page(
    paper: "a4",
    margin: (top: 30mm, bottom: 25mm, left: 30mm, right: 20mm),
  )

  // 全局文本样式
  set text(font: (times, songti), size: 12pt, lang: "zh", weight: 400)
  set par(leading: 1.5em, first-line-indent: 2em, justify: true)

  // 标题编号格式
  set heading(numbering: "1.1.1")

  // 一级标题
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    v(2em)
    align(center)[
      #text(font: (arial, heiti), size: 16pt, weight: "bold")[#it.body]
    ]
    v(1.5em)
  }

  // 二级标题
  show heading.where(level: 2): it => {
    v(1em)
    text(font: (arial, heiti), size: 16pt, weight: "bold")[#it.body]
    v(0.5em)
  }

  // 三级标题
  show heading.where(level: 3): it => {
    v(0.5em)
    text(font: (arial, heiti), size: 16pt, weight: "bold")[#it.body]
    v(0.5em)
  }

  // 四级标题
  show heading.where(level: 4): it => {
    v(0.5em)
    text(font: (arial, heiti), size: 14pt, weight: "bold")[#it.body]
    v(0.5em)
  }

  // 粗体/斜体样式
  show strong: set text(font: (times, heiti), weight: 400)
  show emph: set text(style: "normal")

  // 图表编号
  show figure.where(kind: image): set figure(supplement: [图])
  show figure.where(kind: table): set figure(supplement: [表])
  show figure: set text(size: 10.5pt)
  
  set page(numbering: none)
  
  // ==================== 封面（按 dotx 格式）====================
  if show_cover {
    thesis-cover(
      fonts: fonts,
      title: title,
      title_en: title_en,
      author: author,
      student_id: student_id,
      advisor: advisor,
      major: major,
      school: school,
      class_info: class_info,
      date: date,
    )
  }

  // ==================== 中文摘要 ====================
  [
    #align(center)[
      #text(font: heiti, size: 15.75pt, weight: 400)[摘  要]
    ]
    #v(1em)
    #abstract_cn
    #v(1em)
    #text(font: heiti, size: 14pt, weight: 400)[关键词：]
    #keywords_cn.join("；")
  ]

  pagebreak()

  // ==================== 英文摘要 ====================
  if abstract_en != [] or keywords_en != () {
    [
      #align(center)[
        #text(font: heiti, size: 15.75pt, weight: 400)[Abstract]
      ]
      #v(1em)
      #abstract_en
      #v(1em)
      #text(font: heiti, size: 14pt, weight: 400)[Keywords: ]
      #keywords_en.join("; ")
    ]
    
    pagebreak()
  }

  // ==================== 目录 ====================
  [
    #align(center)[
      #text(font: heiti, size: 15.75pt, weight: 400)[目  录]
    ]
    #v(1em)
    #outline(title: none, indent: auto, depth: 3)
  ]

  pagebreak()

  // ==================== 正文 ====================
  [
    #set page(
      numbering: "1",
      header: context [
        #set text(font: (times, songti), size: 9pt)
        #align(center)[
          #if header_text != none [#header_text] else [#title]
        ]
        #v(-0.3em)
        #line(length: 100%, stroke: 0.5pt)
      ],
      footer: context [
        #align(right, text(font: times, size: 9pt)[#counter(page).display()])
      ]
    )
    #counter(page).update(1)
  ]

  doc_body
}

// =================== 程序设计课程设计报告模板 ===================

// course-report: 生成程序设计课程设计报告
#let course-report(
  title: "",
  author: "",
  student_id: "",
  advisor: "",
  major: "",
  school: "",
  class_info: "",
  grade: "",
  date: datetime.today(),
  header_text: none,
  body
) = {
  common-settings[
    // ==================== 封面 ====================
    #set page(numbering: none)
    
    course-report-cover(
      fonts: fonts,
      title: title,
      author: author,
      student_id: student_id,
      advisor: advisor,
      major: major,
      school: school,
      class_info: class_info,
      grade: grade,
      date: date,
    )

    // ==================== 正文 ====================
    #set page(
      numbering: "1",
      // 页眉：9pt，宋体，Times New Roman，居中对齐，底部有单线边框
      header: context [
        #set text(font: (times, songti), size: 9pt)
        #align(center)[
          #if header_text != none [#header_text] else [#title]
        ]
        #v(-0.3em)
        #line(length: 100%, stroke: 0.5pt)
      ],
      // 页脚：9pt，Times New Roman，右对齐显示页码
      footer: context [
        #align(right, text(font: times, size: 9pt)[#counter(page).display()])
      ]
    )
    #counter(page).update(1)

    body
  ]
}

// ==================== 通用组件 ====================

// 代码块组件（带编号）
#let code_block(content, caption: none) = {
  figure(
    rect(
      width: 100%,
      fill: luma(250),
      stroke: luma(200),
      inset: 8pt,
      radius: 4pt,
      align(left)[
        text(font: code_font, size: 9pt, weight: 400)[#content]
      ]
    ),
    caption: caption,
    supplement: "程序清单"
  )
}

// 公式块样式
#show math.equation.where(block: true): it => {
  block(
    width: 100%,
    inset: 1em,
    align(center)[#it.body]
  )
}
