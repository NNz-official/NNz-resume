#let data = yaml("content/resume.yaml")
#let ink = rgb("#1c2a36")
#let accent = rgb("#236a79")
#let muted = rgb("#586975")
#set document(title: data.profile.name + " | " + data.profile.role, author: data.profile.name)
#set page(paper: "a4", margin: (x: 17mm, top: 15mm, bottom: 15mm), footer: context [
  #set text(size: 8pt, fill: muted)
  #data.profile.name #h(1fr) #data.profile.footer_label · #data.profile.version #h(1fr) #counter(page).display("1 / 1", both: true)
])
#set text(font: ("Microsoft YaHei", "Arial"), size: 9.4pt, fill: ink, lang: "zh")
#set par(justify: false, leading: 0.58em)
#set list(indent: 0pt, body-indent: 11pt, spacing: 3.2pt, marker: [#text(fill: accent)[•]])
#let section(title) = {
  v(9pt)
  block(above: 0pt, below: 6pt, width: 100%)[
    #text(size: 12pt, weight: "bold", fill: accent)[#title]
    #v(3pt)
    #line(length: 100%, stroke: 0.6pt + rgb("#c7d7dd"))
  ]
}
#let project(p) = block(breakable: false, above: 0pt, below: 8pt)[
  #grid(columns: (1fr, auto), column-gutter: 9pt,
    text(size: 10.3pt, weight: "bold")[#p.name],
    text(size: 8pt, fill: muted)[#p.dates])
  #v(2pt)
  #text(size: 8.3pt, fill: accent)[#p.stack]
  #v(3pt)
  #text(size: 8.5pt, fill: muted)[#p.context]
  #v(4pt)
  #list(..p.bullets.map(x => [#x]))
]

#text(size: 25pt, weight: "bold")[#data.profile.name]
#h(14pt)
#text(size: 11pt, fill: accent)[#data.profile.role]
#v(5pt)
#text(size: 9pt)[#link("tel:" + data.profile.phone)[#data.profile.phone]　|　#link("mailto:" + data.profile.email)[#data.profile.email]]
#v(4pt)
#text(size: 8pt, fill: muted)[#data.profile.draft_note]
#section("个人概述")
#data.profile.summary
#section("教育背景")
#for e in data.education [
  #grid(columns: (1fr, auto), column-gutter: 10pt,
    [*#e.school*　#e.degree],
    text(size: 8.5pt, fill: muted)[#e.dates])
  #v(4pt)
]
#section("工作经历")
#for e in data.work_experience [
  #grid(columns: (1fr, auto), column-gutter: 10pt,
    [*#e.company*], text(size: 8.5pt, fill: muted)[#e.dates])
  #v(2pt)
  #text(fill: accent, weight: "bold")[#e.role]
  #if e.summary != "" [#v(3pt) #text(size: 8.7pt)[#e.summary]]
  #v(6pt)
]
#section("技术能力")
#for s in data.skills [
  *#s.label*　#s.detail
  #parbreak()
  #v(2pt)
]
#section("重点项目")
#for p in data.recent_projects { project(p) }

#pagebreak()
#text(size: 17pt, weight: "bold")[#data.profile.name]
#h(12pt)
#text(size: 10pt, fill: accent)[项目经历 · 续]
#section("文档平台、模型服务与协作项目")
#for p in data.additional_projects { project(p) }
#text(size: 8pt, fill: muted)[#data.maintenance_summary]
#section("早期项目经历")
#for p in data.historical_projects.slice(0, data.layout.historical_project_count) { project(p) }
#section("竞赛与获奖")
#list(..data.awards.map(x => [#x]))
