#let data = yaml("content/resume.yaml")
#let ink = rgb("#22313b")
#let accent = rgb("#225b70")
#let muted = rgb("#657480")
#set document(title: data.profile.name + " | " + data.profile.role, author: data.profile.name)
#set page(paper: "a4", margin: (x: 18mm, top: 15mm, bottom: 15mm), footer: context [
  #set text(size: 8pt, fill: muted)
  #data.profile.name #h(1fr) #data.profile.footer_label · #data.profile.version #h(1fr) #counter(page).display("1 / 1", both: true)
])
#set text(font: ("Microsoft YaHei", "Arial"), size: 10.2pt, fill: ink, lang: "zh")
#set par(leading: 0.7em, spacing: 5pt)
#set list(indent: 0pt, body-indent: 10pt, spacing: 4pt, marker: text(fill: accent)[·])
#let section(title) = block(above: 13pt, below: 9pt, width: 100%)[
  #grid(columns: (auto, 1fr), column-gutter: 10pt, align: horizon,
    text(size: 11pt, weight: "bold", fill: accent)[#title],
    line(length: 100%, stroke: 0.5pt + rgb("#d5dfe3")))
]
#let project(p) = block(breakable: false, above: 0pt, below: 8pt)[
  #grid(columns: (1fr, auto), column-gutter: 12pt,
    text(size: 10pt, weight: "bold")[#p.name],
    text(size: 8.5pt, fill: muted)[#p.dates])
  #v(3pt)
  #text(size: 8.8pt, fill: accent)[#p.context]
  #v(4pt)
  #list(..p.bullets.map(x => [#x]))
]
#let header(continued: false) = {
  if continued {
    grid(columns: (1fr, auto), align: bottom,
      text(size: 15pt, weight: "bold")[#data.profile.name],
      text(size: 9pt, fill: muted)[项目经历与技术背景])
  } else {
    grid(columns: (1fr, auto), align: bottom,
      [#text(size: 27pt, weight: "bold")[#data.profile.name]
       #v(4pt)
       #text(size: 11pt, fill: accent)[#data.profile.role]],
      text(size: 9pt)[#link("tel:" + data.profile.phone)[#data.profile.phone]
       #linebreak()#link("mailto:" + data.profile.email)[#data.profile.email]])
  }
  v(8pt)
  line(length: 100%, stroke: 1.4pt + accent)
}
#header()
#block(above: 9pt, below: 0pt)[#data.profile.summary]
#section("工作经历")
#for e in data.work_experience [
  #block(breakable: false, below: 8pt)[
    #grid(columns: (1fr, auto), column-gutter: 8pt,
      [*#e.company*], text(size: 8.5pt, fill: muted)[#e.dates])
    #v(4pt)
    #text(size: 9.5pt, weight: "bold", fill: accent)[#e.role]
    #v(4pt)
    #e.summary
    #v(5pt)
  ]
]
#section("正式任职 · 业务流程与审核")
#for p in data.recent_projects { project(p); v(7pt) }
#section("教育背景")
#for e in data.education [
  #grid(columns: (1fr, auto), column-gutter: 10pt,
    [*#e.school*　#e.degree], text(size: 8.3pt, fill: muted)[#e.dates])
  #v(3pt)
]
#pagebreak()
#header(continued: true)
#section("正式任职 · 资产服务与模型运维")
#for p in data.additional_projects { project(p); v(7pt) }
#section("实习阶段 · 文档解析")
#for p in data.internship_projects { project(p); v(7pt) }
#section("早期项目")
#for p in data.historical_projects.slice(0, data.layout.historical_project_count) { project(p); v(7pt) }
#section("能力与技术背景")
#for s in data.skills [
  *#s.label*　#s.detail
  #parbreak()
]
#section("竞赛获奖")
#text(size: 8.5pt)[#data.awards.join("；")]
