// 广东工业大学论文模板 - 通用版本

// =================== 字体配置 ===================

// 默认字体（系统预设）
#let default-songti = "SimSun"
#let default-heiti = "SimHei"
#let default-times = "Times New Roman"
#let default-arial = "Arial"
#let default-code = "JetBrainsMono NF"

// 本地字体覆盖变量
#let local-songti = none
#let local-heiti = none
#let local-times = none
#let local-arial = none
#let local-code = none
#let use-local-fonts = false

// 字体配置函数
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

// 实际使用的字体
#let songti = resolve-font("songti", default-songti)
#let heiti = resolve-font("heiti", default-heiti)
#let times = resolve-font("times", default-times)
#let arial = resolve-font("arial", default-arial)
#let code_font = resolve-font("code", default-code)
#let fonts = (songti: songti, heiti: heiti, times: times, arial: arial, code: code_font)

// =================== 通用设置 ===================

// 通用格式设置
#let common-settings(body) = {
  set page(
    paper: "a4",
    margin: (top: 30mm, bottom: 25mm, left: 30mm, right: 20mm),
  )
  set text(font: (times, songti), size: 12pt, lang: "zh", weight: 400)
  set par(leading: 1.5em, first-line-indent: 2em, justify: true)
  set heading(numbering: "1.1.1")

  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    v(2em)
    align(center)[
      #text(font: (arial, heiti), size: 16pt, weight: "bold")[#it.body]
    ]
    v(1.5em)
  }

  show heading.where(level: 2): it => {
    v(1em)
    text(font: (arial, heiti), size: 16pt, weight: "bold")[#it.body]
    v(0.5em)
  }

  show heading.where(level: 3): it => {
    v(0.5em)
    text(font: (arial, heiti), size: 16pt, weight: "bold")[#it.body]
    v(0.5em)
  }

  show heading.where(level: 4): it => {
    v(0.5em)
    text(font: (arial, heiti), size: 14pt, weight: "bold")[#it.body]
    v(0.5em)
  }

  show strong: set text(font: (times, heiti), weight: 400)
  show emph: set text(style: "normal")
  show figure.where(kind: image): set figure(supplement: [图])
  show figure.where(kind: table): set figure(supplement: [表])
  show figure: set text(size: 10.5pt)

  body
}

// 页眉页脚设置
#let setup-header-footer(title: "", header_text: none) = {
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
}

// 导入封面模块
#import "chapters/0-thesis-cover.typ": thesis-cover
#import "chapters/0-course-report.typ": course-report-cover

// =================== 模板函数 ===================

// 本科毕业设计（论文）
#let thesis(
  title: "",
  title_en: "",
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
  show_cover: true,
  doc_body
) = {
  common-settings[
    set page(numbering: none)

    // 封面
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

    // 中文摘要
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

    // 英文摘要
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

    // 目录
    [
      #align(center)[
        #text(font: heiti, size: 15.75pt, weight: 400)[目  录]
      ]
      #v(1em)
      #outline(title: none, indent: auto, depth: 3)
    ]

    pagebreak()

    // 正文
    setup-header-footer(title: title, header_text: header_text)

    doc_body
  ]
}

// 程序设计课程设计报告
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
    set page(numbering: none)

    // 封面
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

    // 正文
    setup-header-footer(title: title, header_text: header_text)

    body
  ]
}

// =================== 通用组件 ===================

// 代码块组件
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
