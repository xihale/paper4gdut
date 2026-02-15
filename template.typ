// 广东工业大学论文模板 - 通用版本
// 支持本地字体强制覆盖配置

// =================== 字体配置系统 ===================

// 默认字体（系统预设）
#let default-songti = "SimSun"
#let default-heiti = "SimHei"
#let default-times = "Times New Roman"
#let default-code = "JetBrainsMono NF"

// 本地字体覆盖变量（通过 configure-fonts 设置）
#let local-songti = none
#let local-heiti = none
#let local-times = none
#let local-code = none

// 是否启用本地字体（默认 false）
#let use-local-fonts = false

// 字体配置函数：设置本地字体路径
// 参数：
//   songti: 宋体字体路径
//   heiti: 黑体字体路径
//   times: 英文字体路径
//   code: 代码字体路径
//   enable: 是否启用本地字体
#let configure-fonts(
  songti: none,
  heiti: none,
  times: none,
  code: none,
  enable: true
) = {
  if songti != none { local-songti = songti }
  if heiti != none { local-heiti = heiti }
  if times != none { local-times = times }
  if code != none { local-code = code }
  use-local-fonts = enable
}

// 解析字体名称
#let resolve-font(name, default) = {
  if not use-local-fonts { return default }
  let val = if name == "songti" { local-songti } else if name == "heiti" { local-heiti } else if name == "times" { local-times } else if name == "code" { local-code } else { none }
  if val != none { val } else { default }
}

// 实际使用的字体定义
#let songti = resolve-font("songti", default-songti)
#let heiti = resolve-font("heiti", default-heiti)
#let times = resolve-font("times", default-times)
#let code_font = resolve-font("code", default-code)

// Graphviz 图表渲染配置
#let raw_render_custom(dot_content, width: 100%) = {
  import "@preview/diagraph:0.3.6": raw-render
  raw-render(dot_content, width: width)
}

// =================== 论文模板函数 ===================

// thesis: 生成广东工业大学本科毕业设计（论文）
#let thesis(
  title: "",
  author: "",
  student_id: "",
  advisor: "",
  major: "",
  school: "",
  class_info: "",
  grade: "",
  date: datetime.today(),
  abstract_cn: [],
  keywords_cn: (),
  abstract_en: [],
  keywords_en: (),
  header_text: none,
  body
) = {
  // 页面布局（广工规范）
  set page(
    paper: "a4",
    margin: (top: 30mm, bottom: 25mm, left: 30mm, right: 20mm),
  )

  // 全局文本样式
  set text(font: (times, songti), size: 12pt, lang: "zh", weight: 400)
  set par(leading: 1.5em, first-line-indent: 2em, justify: true)

  // 标题编号
  set heading(numbering: "1.1.1")

  // 一级标题：三号黑体加粗 (15.75pt)，居中
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    v(2em)
    align(center)[
      #text(font: (times, heiti), size: 15.75pt, weight: 400)[#it.body]
    ]
    v(1.5em)
  }

  // 二级标题：小四黑体加粗 (12pt)
  show heading.where(level: 2): it => {
    v(1em)
    text(font: (times, heiti), size: 12pt, weight: 400)[#it.body]
    v(0.5em)
  }

  // 三级标题：小四黑体 (12pt)
  show heading.where(level: 3): it => {
    v(0.5em)
    text(font: (times, heiti), size: 12pt, weight: 400)[#it.body]
    v(0.5em)
  }

  // 粗体/斜体样式覆盖
  show strong: set text(font: (times, heiti), weight: 400)
  show emph: set text(style: "normal")

  // 图表编号样式
  show figure.where(kind: image): set figure(supplement: [图])
  show figure.where(kind: table): set figure(supplement: [表])
  show figure: set text(size: 10.5pt)

  // ==================== 封面 ====================
  set page(numbering: none)
  
  // 校徽图片（通过 --input head-image=path 传入，或默认使用 images/head.webp）
  let head-image = sys.inputs.at("head-image", default: "images/head.webp")
  
  align(center)[
    #v(-1.5cm)
    #image(head-image, width: 80%)

    #v(2em)
    #text(font: heiti, size: 24pt, weight: 400)[广东工业大学本科生毕业设计（论文）]

    #v(2.5em)
  ]

  // 封面字段配置
  let field_line(field-key, field-val, field-font, field-size) = {
    align(center)[
      #block(width: 320pt)[
        #grid(
          columns: (100pt, 220pt),
          align(right + horizon)[
            #text(font: songti, size: 16pt, weight: 400)[#field-key]
            #h(0.5em)
          ],
          align(center + horizon)[
            #text(font: field-font, size: field-size, weight: 400)[#field-val]
            #v(-5pt)
            #line(length: 100%, stroke: 0.5pt)
          ]
        )
      ]
    ]
    v(0.8em)
  }
  
  // 字段配置映射：key -> (显示值, 字体, 字号)
  let fields = (
    ("题    目", title, heiti, 18pt),
    ("学    院", school, songti, 16pt),
    ("专    业", major, songti, 16pt),
    ("年级班别", class_info, songti, 16pt),
    ("学    号", student_id, songti, 16pt),
    ("学生姓名", author, songti, 16pt),
    ("指导教师", advisor, songti, 16pt),
    ("成    绩", grade, songti, 16pt),
  )

  // 遍历字段，只显示有值的内容
  for (k, v, f, s) in fields {
    if v != "" {
      field_line(k, v, f, s)
    }
  }
  
  v(1fr)
  align(center)[
    #text(font: songti, size: 14pt, weight: 400)[#date.display("[year] 年 [month] 月")]
  ]

  pagebreak()

  // ==================== 中文摘要 ====================
  [#align(center)[
    #text(font: heiti, size: 15.75pt, weight: 400)[摘  要]
  ]
  #v(1em)]
  abstract_cn
  [#v(1em)
  #text(font: heiti, size: 14pt, weight: 400)[关键词：]
  #keywords_cn.join("；")]

  pagebreak()

  // ==================== 英文摘要 ====================
  if abstract_en != [] or keywords_en != () {
    [#align(center)[
      #text(font: heiti, size: 15.75pt, weight: 400)[Abstract]
    ]
    #v(1em)]
    abstract_en
    [#v(1em)
    #text(font: heiti, size: 14pt, weight: 400)[Keywords: ]
    #keywords_en.join("; ")]
    
    pagebreak()
  }

  // ==================== 目录 ====================
  [#align(center)[
    #text(font: heiti, size: 15.75pt, weight: 400)[目  录]
  ]
  #v(1em)
  #outline(title: none, indent: auto, depth: 3)]

  pagebreak()

  // ==================== 正文 ====================
  set page(
    numbering: "1",
    header: context [
      #set text(font: songti, size: 10.5pt, weight: 400)
      #align(center)[
        #if header_text != none [#header_text] else [#title]
      ]
      #v(-0.5em)
      #line(length: 100%, stroke: 0.5pt)
    ],
    footer: context [
      #align(right, text(font: times, size: 9pt, weight: 400)[#counter(page).display()])
    ]
  )
  counter(page).update(1)

  body
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
