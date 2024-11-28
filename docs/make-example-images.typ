#import "readme.typ": eval-kwargs, showman-config
#import "@preview/showman:0.1.2": runner
#show raw.where(lang: "example"): it => it


#let get-example-blocks(body) = {
  let example-blocks = ()
  let example-blocks-regex = regex("```example\n([\s\S]+?)\n```")
  for match in body.matches(example-blocks-regex) {
    example-blocks.push(match.captures.at(0))
  }
  example-blocks
}

#let all-blocks = get-example-blocks(read("readme.typ"))
#set page(margin: 1em, ..showman-config.page-size)
// Dummy first page to match showman expectations
#pagebreak()
#for (ii, example) in all-blocks.enumerate() {
  eval(
    mode: "markup",
    "#let output(body) = body;\n" + eval-kwargs.eval-prefix + example,
  )
  if ii != all-blocks.len() - 1 {
    pagebreak()
  }
}

