#import "template.typ": *

// 配置本地字体（可选）：取消注释并设置字体路径
// configure-fonts(
//   songti: "/path/to/your/simsun.ttf",
//   heiti: "/path/to/your/simhei.ttf",
//   times: "/path/to/times.ttf",
//   code: "/path/to/jetbrainsmono.ttf",
//   enable: false  // 设为 true 启用本地字体
// )

#thesis(
  title: "（论文题目）",
  author: "（作者姓名）",
  student_id: "（学号）",
  advisor: "（指导教师）",
  major: "（专业名称）",
  school: "（学院名称）",
  class_info: "（年级班别）",
  grade: "",
  date: datetime.today(),
  abstract_cn: [
    （在此处填写中文摘要内容。摘要应概括论文的主要研究内容、方法、结果和结论，字数一般在300-500字之间。）
    
    （摘要第二段，可继续阐述研究意义、创新点或应用价值等。）
  ],
  keywords_cn: ("关键词1", "关键词2", "关键词3", "关键词4"),
  abstract_en: [
    (Please write your English abstract here. It should summarize the main research content, methods, results, and conclusions of your thesis, typically between 200-400 words.)
    
    (Second paragraph of the abstract, you may continue to elaborate on research significance, innovations, or application value.)
  ],
  keywords_en: ("Keyword1", "Keyword2", "Keyword3", "Keyword4"),
  header_text: "（页眉文字，可为空则默认使用论文题目）"
)[
  #include "chapters/1-introduction.typ"
  #include "chapters/2-related.typ"
  #include "chapters/3-method.typ"
  #include "chapters/4-experiment.typ"
  #include "chapters/5-conclusion.typ"
  #include "chapters/appendix.typ"
]
