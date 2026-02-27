#import "theme.typ": makeTheme, recolorSVG
#import "base.typ": curDir

#let contentBlock(
    x,
    bg: luma(250),
    border: black,
    prefix: none
) = block(
    inset: 10pt,
    width: 100%,
    fill: bg,
    stroke: (left: 1pt + border),
    x
)

#let def(x) = contentBlock(x, bg: luma(250), border: black)
#let task(x) = context {
    let theme = makeTheme()
    contentBlock(x, bg: theme.accent.lighten(90%), border: theme.accent)
}
#let term(x) = {
    show heading: none
    heading(level: 4, x)
    highlight(fill: none, underline(x))
}

#let proof(x) = block(inset: (left: 5pt), block(
    place(dx: -15pt, dy: -10pt, rect(width: 5pt, height: 5pt, stroke: 1pt + gray)) 
    + text(size: 0.9em, x) 
    + place(dx: -15pt, dy: 5pt, rect(width: 5pt, height: 5pt, stroke: 1pt + gray, fill: gray)),
    width: 100%,
    inset: (left: 15pt, y: 10pt),
    stroke: (left: 1pt + gray)
))

#let note(x) = context {
    let theme = makeTheme()
    stack(dir: ltr,
        h(10pt),
        recolorSVG("img/fancy-arrow.svg", theme.accent, rescale: 0.8),
        block(inset: (left: 10pt, top: 1.5pt, right: 40pt), text(fill: theme.accent, x))
    )
}

//#let proof(x) = block(text(size: 0.9em, sym.triangle.filled + linebreak() + x) + sym.square.filled, width: 100%, inset: (left: 10pt))
#let todo(x) = {
        hide(place(figure(kind: "todo", supplement: none, x)))
        text(fill: red, [*todo: *] + x)
    }

#let blk(x) = block(inset: (left: 1cm), x)

#let img(..args, width: auto, height: auto, scl: none) = context {
    if args.pos().len() != 1 and args.pos().len() != 2 {
        panic("img() expects 1 argument (src) or two (src, label)")
    }
    let src = args.pos().at(0)
    let label = if args.pos().len() == 2 { args.pos().at(1) } else { none }
    let path = curDir.get() + "/" + src

    if scl != none {
        let size = measure(image(path))
        align(
            center,
            image(
                path,
                width: size.width * scl,
                height: size.height * scl
            )
        )

    } else if width == auto and height == auto {
        // try figuring this out
        let size = measure(image(path))
        layout(box => {
            let maxWidth = 0.6 * box.width
            let maxHeight = 7cm
            let newSize = none
            if maxWidth / size.width * size.height > maxHeight {
                newSize = (
                    width: maxHeight / size.height * size.width,
                    height: maxHeight
                )
            } else {
                newSize = (
                    width: maxWidth,
                    height: maxWidth / size.width * size.height
                )
            }
            align(
                center,
                image(
                    path,
                    width: newSize.width,
                    height: newSize.height
                )
            )
        })
    } else {
        align(
            center,
            context image(
                path,
                width: width,
                height: height
            )
        )
    }
    if label != none {
        align(center, label)
    }
}

#let icon(x) = text(font: "FiraCode Nerd Font", x)

#let url(..args) = underline(link(..args))
