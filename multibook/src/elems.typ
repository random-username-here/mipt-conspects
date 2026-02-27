///
/// Internal book elements, like titlepages, etc.
///
#import "theme.typ": makeTheme, makeStatelessTheme

///
/// Apply top-level show and set rules
/// to given content
///
#let withTopLevelRules(it) = context {
    let theme = makeTheme()
    set heading(offset: 1)
    set page(
        margin: 3cm,
        footer: context text(fill: gray, {
            let headings = query(heading.where(level: 1).before(here()))
            if headings.len() != 0 {
                headings.last().body
            }
            h(1fr)
            counter(page).display("1")
        })
    )
    show heading : it => it + v(0.2em)
    set text(font: theme.font)
    //show link: it => underline(it)
    show heading.where(level: 2) : it => text(font: "IBM Plex Serif", it)
    it
}

///
/// Generate book's titlepage
/// 
#let bookTitlepage(title: [], fields: (), extra: [], logos: []) = {
    context {
        let theme = makeTheme()
        set page(fill: (theme.pattern)(
            theme.accentBg,
            theme.accentBgAlt
        ), footer: none)
        text(size: 1.3em, fill: white, {
            std.title(text(font: "IBM Plex Serif", title))
            v(2em)
            table(
                stroke: none,
                gutter: 1em,
                column-gutter: 2em,
                row-gutter: 1em,
                inset: 0pt,
                columns: (auto, auto),
                ..fields
                    .chunks(2)
                    .map(((name, val)) => (text(weight: "bold", name), val))
                    .flatten()
            )
            v(2em)
            extra
        })

        place(bottom + right,
            logos +
            text(fill: white, [
                Документ скомпилирован #datetime.today().display()\
                Версия typst #sys.version\
                git commit #sys.inputs.git_hash
            ])
        )
    }
    counter(page).update(1)
}

///
/// That fancy chapter title page
/// 
#let chapterTitle(title : [], date: none, outlined: true, msg: []) = {

    let sth = makeStatelessTheme()

    let titleContents = text(
        text(title, size: 1.5em, font: "IBM Plex Serif") +
        h(1fr) +
        text(date)
    ) + linebreak() + v(0.1em) + msg

    place(layout(pageSize => {
        let titleSize = measure(titleContents, width: pageSize.width) 
        let marginTop = page.margin
        let marginLeft = page.margin
        let marginRight = page.margin
        let theme = makeTheme()

        let color = theme.accent.lighten(85%)
        let bgcolor = theme.accent.lighten(95%)
        
        place(
            dx: -marginLeft,
            dy: -marginTop,
            float: false,
            rect(
                width: marginLeft + 100% + marginRight,
                height: marginTop + titleSize.height + 1cm,
                fill: (theme.pattern)(bgcolor, color),
                stroke: (
                    bottom: 2pt + color 
                )
            )
        )
    }))
    hide(place(heading(level: 1, title, outlined: outlined)))
    titleContents
    v(1.5cm)
}

///
/// Tasks outline.
/// Has 3d level headings in lines after
/// last higher level heading, like this:
///
///   some section: 1, 22, 34, 41
///   other section: 30, 36
///
#let tasksOutline() = context {
    let headings = query(heading.where(outlined: true))
    let had-prev = false
    for i in headings {
        if i.level <= 3 {
            linebreak()
            h((i.level - 1) * 2em)
            link(
                i.location(),
                text(weight: "bold", i.body),
            )
            had-prev = false
        } else {
            if had-prev [, ] else [: ]
            had-prev = true
            link(i.location(), i.body)
        }
    }
}

#let normalOutline() = {
    let theme = makeStatelessTheme()
    set outline.entry(
        fill: repeat(gap: 2pt, text(fill: silver, weight: "regular")[-])
    )
    show outline.entry.where(
        level: 1,
    ): it => v(1em) + text(
        weight: "bold",
        font: theme.titleFont,
        it
    ) + v(0.5em)
    show outline.entry.where(level: 1): set outline.entry(
        fill: repeat(gap: 2pt, text(weight: "regular", [-])))
    outline(title: none)
}

#let todoTable() = context {
    let todos = query(figure.where(kind: "todo"))
    if todos.len() == 0 { return }
    
    heading(level: 2, outlined: false, "Список TODO")
    for todo in todos {
        block(inset: (left: 30pt), link(todo.location(), [
            стр. #todo.location().page() : #todo.body
        ]))
    }
}

#let customOutline(variant: "normal") = {
    if variant == "tasks" {
        tasksOutline()
    } else {
        normalOutline()
    }
    todoTable()
}
