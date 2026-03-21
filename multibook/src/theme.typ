
#let state = (
    accent: state("theme.state.accent", green),
    pattern: state("theme.state.pattern", (bg, fg) => none),
    extraRules: state("theme.state.extra-rules", (x) => x)
)

#let colorIsDark(color) = {
    let (r, g, b) = color.components(alpha: false)
    let p = calc.sqrt(float(0.299 * r * r + 0.587 * g * g + 0.114 * b * b))
    return p < 0.4;
}

#let recolorSVG(path, color, rescale: 1) = {
    let width = 5
    let height = 5
    for i in xml(path) {
        if i.tag == "svg" {
            if "width" in i.attrs {
                width = int(i.attrs.width.replace("px", ""))
                height = int(i.attrs.height.replace("px", ""))
            } else {
                let box = i.attrs.viewBox.split()
                width = int(box.at(2)) - int(box.at(0))
                height = int(box.at(3)) - int(box.at(1))
            }
        }
    }
    width = width * rescale
    height = height * rescale
    let svg = read(path)
    return image(
        bytes(svg
            .replace("white", "transparent") // hide exported bg
            .replace("black", color.to-hex())
            .replace("#000000", color.to-hex())
            .replace("#000", color.to-hex())),
        width: width * 1pt,
        format: "svg"
    )
}

#let makeStatelessTheme() = {
    return (        
        font:      "IBM Plex Sans",
        titleFont: "IBM Plex Sans",
        codeFont:  "IBM Plex Mono",

        bg: white,
        fg: black,

        fontSize: (
            base: 12pt,
            h1: 20pt,
            h2: 18pt
        ),
    )
}

#let makeTheme() = {

    let accent = state.accent.get()
    let pattern = state.pattern.get()

    return (
        .. makeStatelessTheme(),

        accent: accent,
        accentBg: accent.darken(50%),
        accentBgAlt: if colorIsDark(accent) {
            accent.darken(20%)
        } else {
            accent.darken(40%)
        },
        pattern: pattern,
    )
}
