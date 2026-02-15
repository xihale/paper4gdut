// 程序设计课程设计报告封面
// 由 template.typ 中的 course-report 函数调用

#let course-report-cover(
  fonts: (songti: "SimSun", heiti: "SimHei", times: "Times New Roman", arial: "Arial"),
  title: "",
  author: "",
  student_id: "",
  advisor: "",
  major: "",
  school: "",
  class_info: "",
  grade: "",
  date: datetime.today(),
) = {
  // 获取字体变量
  let songti = fonts.songti
  let heiti = fonts.heiti
  let times = fonts.times
  let arial = fonts.arial
  // 封面图片路径（默认使用 images/course/ 下的图片）
  let logo-image = sys.inputs.at("logo-image", default: "../images/course/head.webp")
  let banner-image = sys.inputs.at("banner-image", default: "../images/thesis/cover_banner.webp")
  
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
  
  align(center)[
    #v(1cm)
    // 校徽
    #image(logo-image, width: 25%)
    
    #v(0.5cm)
    // 广东工业大学横幅
    #image(banner-image, width: 70%)
    
    #v(2cm)
    // 大标题：程序设计课程设计报告
    #text(font: (arial, heiti), size: 24pt, weight: "bold")[程序设计课程设计报告]

    #v(2.5em)
  ]

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
}
