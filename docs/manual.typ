#import "@preview/tidy:0.2.0"
#import "@preview/showman:0.1.1"
#import "../wrap-it.typ"
#show raw.where(block: true, lang: "typ"): showman.formatter.format-raw.with(width: 100%)
#show raw.where(lang: "typ"): showman.runner.global-example.with(
  unpack-modules: true,
  scope: (wrap-it: wrap-it),
  eval-prefix: "#let wrap-content(..args) = output(wrap-it.wrap-content(..args))"
)
#show <example-output>: set text(font: "New Computer Modern")
#let module = tidy.parse-module(read("../wrap-it.typ"))
#tidy.show-module(module,
  style: tidy.styles.default,
  first-heading-level: 1,
  show-outline: false,
  break-param-descriptions: true,
)
