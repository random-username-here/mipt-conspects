#import "../../mb.typ": *
#show: mb.chapter(
    title: [ Галлерея узоров ],
)

Однотипный фон выглядит некрасиво, поэтому я сделал узорчатую заливку.
Все узоры взять с #url("https://heropatterns.com/")[heropatterns.com].

Если масштаб не тот, можно использовать `patscale`.

#context {
    // for i in *.svg; do echo \"${i%.svg}\",; done
    let patterns = (
        "4-point-stars",
        "architect",
        "autumn",
        "aztec",
        "bamboo",
        "bank-note",
        "bathroom-floor",
        "bevel-circle",
        "brick-wall",
        "bubbles",
        "cage",
        "church-on-sunday",
        "circles-and-squares",
        "circuit-board",
        "clouds",
        "connections",
        "current",
        "curtain",
        "cutout",
        "death-star",
        "diagonal-stripes",
        "diamonds",
        "dominos",
        "eyes",
        "falling-triangles",
        "fancy-rectangles",
        "flipped-diamonds",
        "floor-tile",
        "formal-invitation",
        "graph-paper",
        "groovy",
        "happy-intersection",
        "heavy-rain",
        "hexagons",
        "hideout",
        "houndstooth",
        "intersecting-circles",
        "jigsaw",
        "jupiter",
        "lines-in-motion",
        "lisbon",
        "melt",
        "moroccan",
        "overcast",
        "overlapping-diamonds",
        "overlapping-hexagons",
        "parkay-floor",
        "piano-man",
        "pie-factory",
        "pixel-dots",
        "plus",
        "polka-dots",
        "rails",
        "rain",
        "random-shapes",
        "rounded-plus-connected",
        "signal",
        "slanted-stars",
        "squares-in-squares",
        "squares",
        "steel-beams",
        "temple",
        "tiny-checkers",
        "topography",
        "volcano-lamp",
        "wallpaper",
        "wiggle",
        "x-equals",
        "yyy",
    )

    let theme = mb.elems.makeTheme()
    
    let rects = ()

    for i in patterns {
        rects.push(rect(
            width: 200pt,
            height: 90pt,
            inset: 20pt,
            fill: mb.elems.patternImage(i)(theme.accentBg, theme.accentBgAlt),
            stroke: 2pt + theme.accentBg.darken(30%),
            text(fill: white, i)
        ))
    }

    grid(
        columns: 2,
        column-gutter: 1fr,
        row-gutter: 1em,
        ..rects
    )
}
