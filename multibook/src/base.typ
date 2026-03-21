///
/// base.typ -- Book & chapter definition
/// 

#import "theme.typ": state as themeState, makeTheme
#import "elems.typ": * 

#let options = (
    isChapter:    sys.inputs.at("mode", default: "") == "chapter",
    isFullBook:   sys.inputs.at("mode", default: "") == "book",
    bookDir:      sys.inputs.at("book_dir", default: "."),
    chapters:     sys.inputs.at("chapters", default: "").split(),
    file:         sys.inputs.at("file", default: "")
)

#let curDir = state("curDir", none)

#let dirname(dir) = {
    let parts = dir.split("/")
    return parts.slice(0, -1).join("/")
}

#let chapter(
    title: [ Безымянная глава ],
    date: none,
    msg: []
) = { 

    let showRule = it => {
        if options.isChapter {
            let book = options.bookDir + "/book.typ"
            hide({include book}) // to update theme state, and other options
        }
    } + withTopLevelRules({
        
        chapterTitle(title: title, date: date, msg: msg)

        if options.isChapter {
            heading(level: 2, outlined: false)[Содержание]
            customOutline()
            v(2em)
            curDir.update(dirname(options.bookDir + "/" + options.file))
        }

        it
    })

    return showRule
}

#let book(
    title: [ Безымянная книга ],
    fields: (),
    color: blue,
    pattern: none,
    patscale: 1,
    mode: "book",
    logos: [],
    extraRules: x => x
) = {

    let patternImage = (bg, fg) => none

    if pattern != none {
        // todo: use recolorSVG from theme.typ here
        let path = "patterns/" + pattern + ".svg"
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
        width = width * patscale
        height = height * patscale
        let svg = read(path)
        patternImage = (bg, fg) => tiling(
            size: (width * 1pt, height * 1pt),
            box(
                width: (width+1) * 1pt,
                height: (height+1) * 1pt,
                image(
                    bytes(svg
                        .replace("#000000", fg.to-hex())
                        .replace("#000", fg.to-hex())),
                    width: width * 1pt,
                    format: "svg"
                ),
                fill: bg
            )
        )
    }

    let updateState() = {
        themeState.accent.update(color)
        themeState.pattern.update((_) => patternImage)
        themeState.extraRules.update((_) => extraRules)
    }

    if not options.isFullBook {
        return it => {
            updateState()
        }
    }

    if logos == "ktl" {
        // lectures tex club & mipt branding
        logos = stack(
            dir: ltr,
            link("https://github.com/LecturesTexClub/lectures_tex_club", image("img/logo_ltc_inverse.png", height: 5em)),
            link("https://mipt.ru/", image("img/mipt_rus_inv_eps.svg", height: 5em))
        )
    }

    return it => withTopLevelRules({
        
        updateState()
        bookTitlepage(
            title: title,
            fields: fields,
            extra: it,
            logos: logos
        )
        pagebreak()

        chapterTitle(title: [ Содержание ], outlined: false)
        customOutline(variant: mode)
        pagebreak()

        for name in options.chapters {
            let file = options.bookDir + "/" + name + "/doc.typ"
            curDir.update(options.bookDir + "/" + name)
            include file
        }
    })
}
