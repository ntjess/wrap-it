#import "@preview/showman:0.1.2"
#import "/wrap-it.typ"

#let eval-kwargs = (
  eval-prefix: "
      #set par(justify: true)
      #let fig = figure(
        rect(fill: teal, radius: 0.5em, width: 8em),
        caption: [A figure],
      )
      #let body = lorem(30)

      #let wrap-content(..args) = output(wrap-it.wrap-content(..args))
      #let wrap-top-bottom(..args) = output(wrap-it.wrap-top-bottom(..args))
    ",
  scope: (wrap-it: wrap-it),
)
// TODO: Can't find how to tell pandoc the --root is at /, so it doesn't have access to typst.toml
#let pkg-version = "0.1.1"
// #let pkg-version = toml("/typst.toml").at("package").at("version")


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
#let raw-string = "#import \"@preview/wrap-it:" + pkg-version + "\": wrap-content"

#raw(raw-string, lang: "typ")

= Sample use:
== Vanilla

```example
#let fig = figure(
rect(fill: teal, radius: 0.5em, width: 8em),
caption: [A figure],
)
#let body = lorem(30)
#wrap-content(fig, body)
```

== Changing alignment and margin
```example
#wrap-content(
fig,
body,
align: bottom + right,
column-gutter: 2em
)
```

== Uniform margin around the image
The easiest way to get a uniform, highly-customizable margin is through boxing your image:
```example
#let boxed = box(fig, inset: 0.25em)
#wrap-content(boxed)[
#lorem(30)
]
```
== Wrapping two images in the same paragraph
Note that for longer captions (as is the case in the bottom figure below), providing an explicit `columns` parameter is necessary to inform caption text of where to wrap.
```example
#let fig2 = figure(
rect(fill: lime, radius: 0.5em),
caption: [#lorem(10)],
)
#wrap-top-bottom(
bottom-kwargs: (columns: (1fr, 2fr)),
box(fig, inset: 0.25em),
fig2,
lorem(50),
)
```

== Adding a label to a wrapped figure
Typst can only append labels to figures in content mode. So, when wrapping text around a figure that needs a label, you must first place your figure in a content block with its label, then wrap it:

```example
#show ref: it => underline(text(blue, it))
#let fig = [
  #figure(
    rect(fill: red, radius: 0.5em, width: 8em),
    caption:[Labeled]
  )<fig:lbl>
]
#wrap-content(fig, [Fortunately, @fig:lbl's label can be referenced within the wrapped text. #lorem(15)])
```
