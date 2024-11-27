#import "@preview/showman:0.1.2"


#let eval-kwargs = (
  eval-prefix: "
      #import \"@preview/wrap-it:0.1.1\"
      #let wrap-content(..args) = output(wrap-it.wrap-content(..args))
      #let wrap-top-bottom(..args) = output(wrap-it.wrap-top-bottom(..args))
    ",
)


// Uncomment to render examples, comment when generating readme md file
#show: showman.formatter.template.with(eval-kwargs: (eval-kwargs))

#let showman-config = (
  page-size: (width: 4.1in, height: auto),
  eval-kwargs: eval-kwargs,
)
#show <example-output>: set text(font: "Libertinus Serif", size: 10pt)
#show link: it => {
  set text(fill: blue)
  underline(it)
}
#set page(height: auto)

= Wrap-It: Wrapping text around figures & content
Until https://github.com/typst/typst/issues/553 is resolved, `typst` doesn't natively support wrapping text around figures or other content. However, you can use `wrap-it` to mimic much of this functionality:
- Wrapping images left or right of their text
- Specifying margins
- And more

Detailed descriptions of each parameter are available in the #link("https://github.com/ntjess/wrap-it/blob/main/docs/manual.pdf")[wrap-it documentation].

= Installation
The easiest method is to import `wrap-it: wrap-content` from the `@preview` package:
```typ
#import "@preview/wrap-it:0.1.0": wrap-content
```

= Sample use:
== Vanilla

```globalexample
#set par(justify: true)
#let fig = figure(
  rect(fill: teal, radius: 0.5em, width: 8em),
  caption: [A figure],
)
#let body = lorem(40)
#wrap-content(fig, body)
```

== Changing alignment and margin
```globalexample
#wrap-content(
  fig,
  body,
  align: bottom + right,
  column-gutter: 2em
)
```

== Uniform margin around the image
The easiest way to get a uniform, highly-customizable margin is through boxing your image:
```globalexample
#let boxed = box(fig, inset: 0.5em)
#wrap-content(boxed)[
  #lorem(40)
]
```
== Wrapping two images in the same paragraph
```globalexample
#let fig2 = figure(
  rect(fill: lime, radius: 0.5em),
  caption: [Another figure],
)
#wrap-top-bottom(boxed, fig2, lorem(62))
```
