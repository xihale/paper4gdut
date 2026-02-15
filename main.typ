#import "template.typ": *
#import "metadata/thesis.typ": thesis-metadata

// 配置本地字体（可选）：取消注释并设置字体路径
// configure-fonts(
//   songti: "/path/to/your/simsun.ttf",
//   heiti: "/path/to/your/simhei.ttf",
//   times: "/path/to/times.ttf",
//   arial: "/path/to/arial.ttf",  // 一级标题使用 Arial 字体
//   code: "/path/to/jetbrainsmono.ttf",
//   enable: false  // 设为 true 启用本地字体
// )

// ============================================
// 本科毕业设计（论文）模板使用示例
// ============================================
#thesis(
  ..thesis-metadata
)[
  #include "chapters/1-introduction.typ"
  #include "chapters/2-related.typ"
  #include "chapters/3-method.typ"
  #include "chapters/4-experiment.typ"
  #include "chapters/5-conclusion.typ"
  #include "chapters/appendix.typ"
]

// ============================================
// 程序设计课程设计报告模板使用示例
// ============================================
// 如需使用课程设计报告模板，请注释上面的 thesis 调用，取消注释下面的代码：
/*
#import "metadata/course.typ": course-metadata

#course-report(
  ..course-metadata
)[
  #include "chapters/1-introduction.typ"
  #include "chapters/2-related.typ"
  #include "chapters/3-method.typ"
  #include "chapters/4-experiment.typ"
  #include "chapters/5-conclusion.typ"
]
*/
