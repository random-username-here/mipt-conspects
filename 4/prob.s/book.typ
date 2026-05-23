#import "../../multibook/mb.typ": *

#show: mb.book(
    title: [ Семинары по теорверу ],
    fields: (
        [ Семинарист ],     [ Соколов Артемий Алексеевич ],
        [ Конспектировал ], [ 
            Дидык И. С. 
            #h(1em) #url("https://t.me/Ivan_SD")[#icon[]#h(0.6em)  \@Ivan_SD]
        ],
        [ Курс ],           [ 2 (4-й семестр), 2025-2026 год ],
        [ Группа ],         [ ФПМИ/ИВТсп, Б05-431 ],
        [ Гитхаб ],         [ #icon[]#h(0.6em)#url("https://github.com/random-username-here/mipt-conspects/blob/master/4/prob.s/build/main.pdf")[random-username-here/mipt-conspects] ]
    ),
    color: orange.darken(20%),
    pattern: "diamonds",
    logos: "ktl",
    extraRules: content => {
        set table(
            stroke: 0.5pt + gray.lighten(50%),
            inset: 8pt
        )
        content
    }
)

//Семинаристу писать `@SokolovArtemy` в тг.
