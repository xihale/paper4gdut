// 本科毕业设计（论文）封面
// 由 template.typ 中的 thesis 函数调用

#let thesis-cover(
  fonts: (songti: "SimSun", heiti: "SimHei", times: "Times New Roman", arial: "Arial"),
  title: "",
  title_en: "",
  author: "",
  student_id: "",
  advisor: "",
  major: "",
  school: "",
  class_info: "",
  date: datetime.today(),
) = {
  // 获取字体变量
  let songti = fonts.songti
  let heiti = fonts.heiti
  let times = fonts.times
  let arial = fonts.arial
  // 封面图片路径（默认使用 images/thesis/ 下的图片）
  let logo-image = sys.inputs.at("logo-image", default: "../images/thesis/cover_logo.webp")
  let banner-image = sys.inputs.at("banner-image", default: "../images/thesis/cover_banner.webp")
  
  // 辅助函数：下划线填空
  let field(content, width: 100%) = {
    box(width: width, {
      set align(center + bottom)
      v(4pt)
      text(font: songti, size: 16pt)[#content]
      v(-4pt)
      line(length: 100%, stroke: 0.7pt)
    })
  }
  
  // 辅助函数：分散对齐的标签（如"学 院"）
  let label-text(str) = {
    text(font: heiti, size: 16pt, weight: "bold")[#str]
  }
  
  // 使用 box 限制在一页内
  box(height: 100%, [
    // 第一行：logo 居左
    #image(logo-image, width: 1.5cm)
    #h(0.1fr)

    // 其他内容居中
    #align(center)[
      // 校名图片（image1 - 广东工业大学书法字）- 独占一行
      #image(banner-image, width: 8cm)

      #v(0.8cm)

      // 大标题：本科毕业论文
      #text(font: (arial, heiti), size: 24pt, weight: "bold")[本科毕业论文]

      #v(1.5cm)

      // 论文题目（二号）
      #text(font: heiti, size: 22pt, weight: "bold")[#title]
      
      // 外文题目（小二，如有）
      #if title_en != "" {
        v(0.3em)
        text(font: heiti, size: 18pt, weight: "bold")[#title_en]
      }

      #v(2cm)

      // 信息填写栏（项之间紧密相隔）
      #grid(
        columns: (100pt, 220pt),
        row-gutter: 0.2cm,
        align: (right + horizon, left + bottom),
        
        label-text("学　　院"), field(school),
        label-text("专　　业"), field(major),
        label-text("年级班别"), field(class_info),
        label-text("学　　号"), field(student_id),
        label-text("学生姓名"), field(author),
        label-text("指导教师"), field(advisor),
      )

      #v(1.5cm)

      // 日期
      #text(font: (times, songti), size: 16pt)[
        #date.display("[year] 年 [month] 月")
      ]
      
      #v(0.5cm)
    ]
  ])
  
  pagebreak()
}
