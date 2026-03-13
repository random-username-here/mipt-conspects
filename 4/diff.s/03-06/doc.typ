#import "../../../multibook/mb.typ": *
#import "@preview/cetz:0.4.2"
#show : mb.chapter(
    title: [Семинар 5. Положения равновесия, фазовые траектории],
    date: [6 марта]
)

#let ddx = $dot(x)$
#let ddy = $dot(y)$
#let ddu = $dot(u)$
#let ddv = $dot(v)$

#let sspace(min, max, step) = {
    let eps = step / 100
    let res = ()
    let pos = calc.ceil(min / step) * step
    while pos < max + eps {
        res.push(pos)
        pos += step
    }
    return res
}

#let vecfield(xmin, ymin, xmax, ymax, func, step: 0.2, arrLen : 0.7, color: gray.lighten(40%)) = {
    let eps = 0.01
    for x in sspace(xmin, xmax, step) {
        for y in sspace(ymin, ymax, step) {
            let (dx, dy) = func(x, y)
            let len = calc.sqrt(dx * dx + dy * dy)
            if calc.abs(len) < eps { continue }
            dx /= len
            dy /= len
            draw.line((x,y), (x + dx * arrLen * step, y + dy * arrLen * step), stroke: 0.5pt + color, mark: (end: "straight", scale: 0.3))
        }
    }
}

#let trace(xmin, ymin, xmax, ymax, x, y, func, endrule: (x,y) => false, dt: 0.01, maxsteps: 100, color: black, astep: 1) = {
    let path = ()
    let eps = 0.01
    let totalLen = 0
    for _ in range(maxsteps) {
        if x < xmin or x > xmax or y < ymin or y > ymax or endrule(x, y) {
            break
        }
        path.push((x, y))
        let (dx, dy) = func(x, y)
        let len = calc.sqrt(dx * dx + dy * dy)
        if calc.abs(len) < eps { break }

        // Euler.
        x += dx * dt / len
        y += dy * dt / len
        totalLen += dt
    }

    /*let marks = ()
    for i in sspace(1, totalLen, astep) {
        marks.push((
            symbol: "straight",
            offset: i / totalLen * 100%,
            shorten-to: none
        ))
    }*/
    if path.len() > 1 {
        draw.line(..path, stroke: color/*, mark: (end: marks)*/)
    }
}

#let traces(xmin, ymin, xmax, ymax, func, dt: 0.02, step: 1.0, maxsteps: 100, color: black) = {
    let eps = 0.05
    for x in sspace(xmin, xmax, step) {
        for y in sspace(ymin, ymax, step) {
            trace(xmin, ymin, xmax, ymax, x, y, func, dt: dt, maxsteps: maxsteps, color: color)
        }
    }
}

Обычно имеем диффуры вроде $dot(bar(x)) = f(t, bar(x))$.

Если от времени напрямую не зависит, то есть $dot(bar(x)) = f(bar(x))$, то система *автономная*.
Точки, в которых все производные зануляются называются *положениями равновесия*.

*Фазовые траектории* -- это решения диффура, такие что их нельзя продолжить. В более интуитивных терминах, траектория
точки, попавшей в пространство на котором диффур и двигающейся по производным.

= Линейные

Будем изучать уравнения такого вида:

$
    cases(
        ddx = a x + b y,
        ddy = c x + d y
    )
$

$(0, 0)$ -- положение равновесия этой системы.

$A = mat(a, b; c, d)$. Пусть $lambda_1, lambda_2$ -- собс. значения $A$, $v_1$ и $v_2$ их собс. вектора (если они есть).

#let mmark = (end: "straight", offset: 50%, shorten-to: none)

== Различные варианты фазовых траекторий для двумерного линейного

=== 1. Узел. $lambda_1, lambda_2 in RR, lambda_1 != lambda_2, lambda_1 dot lambda_2 > 0$.

Пусть $abs(lambda_1) < abs(lambda_2)$.
Если $lambda_1 < 0$ то устойчивое (все решения при $t -> oo$ идут к $bar(0)$), если $lambda_1 > 0$, то неустойчивое.

#canvas(length: 2cm, {
    draw.set-transform(cetz.matrix.transform-shear-x(0.3))
    draw.rotate(-30deg)
    let ps = ( -3, -1, -0.5, 0, 0.5, 1, 3 )
    for c in ps {
        plot.func(x => c * x*x, -1, 0, c: black, mark: mmark, ymax: 1, ymin: -1)
        plot.func(x => c * x*x, 1, 0, c: black, mark: mmark, ymax: 1, ymin: -1)
    }
    draw.content((1.3, 0))[$v_1$]
    draw.line((0, 1), (0, 0), mark: mmark)
    draw.line((0, -1), (0, 0), mark: mmark)
    draw.content((0, 1.2))[$v_2$]
    plot.pt(0,0)
    draw.set-transform(cetz.matrix.transform-scale((1, -1, 1)))
    plot.axes(-1.4, -1.4, 1.4, 1.4)
})[Фазовые траектории при $lambda_1 < 0, abs(lambda_1) < abs(lambda_2)$]

=== 2. Вырожденный узел. $lambda_1 dot lambda_2 > 0, lambda_1 = lambda_2$, собс. вектор один.

$v_1$ -- единственный собс. вектор.

#canvas(length: 2cm, {
    draw.set-transform(cetz.matrix.transform-shear-x(-0.3))
    draw.rotate(-30deg)
    let ps = ( -1, 0, 1, 2, 3, 5, 10 )
    let c2 = 1
    for c in ps {
        let c2 = 2
        let c1 = c
        let lambda = 0.8
        plot.func(x => c1 * x / c2 + c2/lambda * calc.ln(x/c2) * x/c2, 0.01, 1, c: black, mark: mmark, ymax: 1, ymin: -1)
        plot.func(x => - c1 * (-x) / c2 - c2/lambda * calc.ln(-x/c2) * (-x)/c2, -0.01, -1, c: black, mark: mmark, ymax: 1, ymin: -1)
    }
    draw.line((0, 0), (0, 1), mark: mmark)
    draw.line((0, 0), (0, -1), mark: mmark)
    draw.content((0, 1.2))[$v_1$]
    plot.pt(0,0)
    draw.set-transform(cetz.matrix.transform-scale((1, -1, 1)))
    plot.axes(-1.4, -1.4, 1.4, 1.4)
})

=== 3. Дикритический узел. $lambda_1 = lambda_2$, два собс. вектора. 

Тогда $A = mat(a, 0; 0, a)$, и уравнение вида $cases(ddx = a x, ddy = a y)$.
Следовательно $y = C_1 e^(a t), x = C_2 e^(a t)$, прямые от $(0, 0)$

Это называется дикритический узел. Очевидно, что если $lambda_1 < 0$ устойчивый, иначе неустойчивый.

#canvas(length: 2cm, {
    for i in sspace(0, 360, 30) {
        let a = i + 15
        draw.line((0, 0), (calc.cos(a * 1deg), calc.sin(a * 1deg)), mark: mmark)
    }
    plot.pt(0,0)
    plot.axes(-1.3, -1.3, 1.3, 1.3)
})

=== 4. Седло. $lambda_1 dot lambda_2 < 0$.

Имеем два собс. вектора $v_1, v_2$. Равновесие неустойчивое.

#canvas(length: 1.5cm, {
    draw.set-transform(cetz.matrix.transform-shear-x(-0.3))
    draw.rotate(-60deg)
    let ps = ( 0.7, 0.15, 0.4 )
    for c in ps {
        plot.func(x => c/x, 1, 0.01, c: black, mark: mmark, ymax: 2, ymin: -2)
        plot.func(x => c/x, -1, -0.01, c: black, mark: mmark, ymax: 2, ymin: -2)
        plot.func(x => -c/x, -1, -0.01, c: black, mark: mmark, ymax: 2, ymin: -2)
        plot.func(x => -c/x, 1, 0.01, c: black, mark: mmark, ymax: 2, ymin: -2)
    }
    draw.line((0, 0), (0, 1.7), mark: mmark)
    draw.line((0, 0), (0, -1.7), mark: mmark)
    draw.line((1, 0), (0, 0), mark: mmark)
    draw.line((-1, 0), (0, 0), mark: mmark)
    draw.content((0, 2))[$v_2$]
    draw.content((1.2, 0))[$v_1$]
    plot.pt(0,0)
    draw.set-transform(cetz.matrix.transform-scale((1, -1, 1)))
    plot.axes(-1.4, -1.4, 1.4, 1.4)
})

=== 5. Параллельные прямые. $rk A = 1$, т.е. $A = mat(a, b; k a, k b)$

$
    cases(
        ddx = a x + b y,
        ddy = k a x + k b y
    ) <==> dy/dx = k ==> y = k x + C
$

Уравнения параллельных прямых. Там подставляем какую-то точку, и определяем куда она движется.

#canvas(length: 1.5cm, {
    draw.set-transform(cetz.matrix.transform-shear-x(-0.2))
    draw.rotate(15deg)

    for i in sspace(-1, 1, 0.3) {
        draw.line((-1, i), (1, i), mark: mmark)
    }
    draw.set-transform(cetz.matrix.transform-scale((1, -1, 1)))
    plot.axes(-1.3, -1.3, 1.3, 1.3)
})[очев]

=== 6. Фокус. $lambda_1, lambda_2 = alpha pm i beta, alpha != 0$.

По сути спираль. $alpha > 0$ -- неустойчиый (от центра), $alpha < 0$ устойчивый (к центру).

Определяем направление накручивания спирали. Рассмотрим например $alpha < 0$.

$
    cases(
        ddx = a x + b y,
        ddy = c x + d y
    )
$


Пусть $with(vec(ddx, ddy))_((1, 0)) = vec(a, c)$.

Рисуем его. Берём ту картинку, где направление сонаправлено.

#let mmmark = (start: (
    (symbol: "straight", offset: 10%, shorten-to: none),
    (symbol: "straight", offset: 10%, shorten-to: none),
    (symbol: "straight", offset: 10%, shorten-to: none),
    (symbol: "straight", offset: 10%, shorten-to: none),
    (symbol: "straight", offset: 10%, shorten-to: none),
    (symbol: "straight", offset: 10%, shorten-to: none),
    (symbol: "straight", offset: 10%, shorten-to: none),
    (symbol: "straight", offset: 10%, shorten-to: none),
    (symbol: "straight", offset: 10%, shorten-to: none)
))

#align(center, stack(dir: ltr, 
canvas(length: 1.5cm, {
    draw.set-transform(cetz.matrix.transform-shear-x(-0.1))
    draw.rotate(15deg)

    let pts = ()
    for i in sspace(0, 20, 0.1) {
        pts.push((angle: i * 1rad, radius: i/20))
    }
    draw.line(..pts, stroke: olive, mark: mmmark)

    draw.set-transform(cetz.matrix.transform-scale((1, -1, 1)))
    plot.axes(-1.3, -1.3, 1.3, 1.3)
    draw.line((1, 0), (1.2, 0.6), mark: (end: "straight"))
    draw.content((1.4, 0.8))[$vec(a, b)$]
    plot.pt(0, 0)
}),
canvas(length: 1.5cm, {
    draw.set-transform(cetz.matrix.transform-shear-x(-0.1))
    draw.rotate(15deg)

    let pts = ()
    for i in sspace(0, 20, 0.1) {
        pts.push((angle: -i * 1rad, radius: i/20))
    }
    draw.line(..pts, stroke: red, mark: mmmark)
    draw.set-transform(cetz.matrix.transform-scale((1, -1, 1)))
    plot.axes(-1.3, -1.3, 1.3, 1.3)
    draw.line((1, 0), (1.2, 0.6), mark: (end: "straight"))
    draw.content((1.4, 0.8))[$vec(a, b)$]
    plot.pt(0, 0)
})
))

#note[
    В точке найденная производная сонаправлена фазовым траекториям.
    Поскольку мы рисуем схематично, то она, ясное дело, не точно совпадает с нарисованным.
]

=== 7. Центр. $lambda_(1, 2) = pm i beta$

Эллипсы. Так же определяем направления движения по ним.

Ноль положение устойчивое по Ляпунову, но не асимптотически устойчивое.#footnote[что это такое будет обсуждаться на след. семинаре]

#canvas(length: 1.5cm, {
    draw.set-transform(cetz.matrix.transform-shear-x(-0.1))
    draw.rotate(15deg)

    for j in sspace(0.3, 1, 0.3) {
        let pts = ()
        for i in sspace(0, 360, 10) {
            pts.push((angle: i * 1deg, radius: j))
        }
        draw.line(..pts, mark: mmmark)
    }

    draw.set-transform(cetz.matrix.transform-scale((1, -1, 1)))
    plot.axes(-1.3, -1.3, 1.3, 1.3)
    plot.pt(0, 0)
})

=== Что с нелинейными?

В случае с нелинейными системами, если сделать её линейной в точке, то положение равновесия в этой точке такое же.
На это есть теорема на лекциях.

Важно, что все эти нарисованные линии -- приближение того, что происходит вокруг точки, и чем дальше от точки,
тем оно менее похоже.

== Задачи


#task[
    #term[972]
    $ cases(ddx = 2x - y, ddy = x) $
]

$ A = mat(2, -1; 1, 0) hhh cX_A (lambda) = lambda^2 - 2 lambda + 1 = (lambda-1)^2 ==> lambda_1 = lambda_2 = 1 $

$ lambda = 1 : mat(1, -1; 1, -1) ~ mat(1, -1; 0, 0) hhh "собс. вектор" v = vec(1, 1) $

Вариант 2. Неустойчивый вырожденный узел. Рисуем картинку.

#note[Картинок тут не будет, они такие же, как в теории выше. Смотрите их. ]

#task[
    #term[975]
    $ cases(ddx = - 2x - 5y, ddy = 2x + 2y) $
]

$ A = mat(-2, -5; 2, 2) hhh cX_A (lambda) = -(4 - lambda^2) + 10 = lambda^2 + 6 ==> lambda = pm i sqrt(6) $

Случай 7. Эллипсы (по умному -- центр).

Рисуем какие-то эллипсы (график качественный). Смотрим куда направлена, рисуем стрелочки.

= Нелинейные

Имеем 
$ cases(ddx = P(x, y), ddy = Q(x, y)) $

Допустим мы имеем точку $(x_0, y_0)$, для которой мы хотим узнать, что там происходит.
Линеаризуем.

$
    cases(
        ddx = P'_x (x_0, y_0) (x - x_0) + P'_y (y - y_0) + o(rho),
        ddy = ...
    )
$

Рисуем то что происходит в точке. Рисуем в правильных координатах (не в нуле, в $(x_0, y_0)$!),
либо помечаем, что в $(u, v) = (x - x_0, y - y_0)$.

#task[
    #term[Задача 2005-2006 года]
    $ cases(
        ddx = -5/4 arctan(y^2 - 1),
        ddy = exp(x^2 + 2 x y + 3 y) - 1
    ) $
    Найти положения равновесия, найти их характер, построить фазовые тракетория.
]

#proof[
    Ищем положения равновесия.
    $
        cases(ddx = 0, ddy = 0) ==> 
        cases(y = pm 1, x^2 + 2 x y + 3 y = 0)
    $
    $ y = 1 ==> x^2 + 2x + 3 = 0 => x = -1 pm sqrt(2) i $
    Не годится, т.к. $x$ и $y$ нас интересуют только действительные.
    $ y = -1 ==> x^2 - 2x - 3 = 0 ==> x in {3, -1} $

    Итого, имеем положения равновесия в $(3, -1)$ и $(-1, -1)$. Исследуем их.

    *1. $(3, -1)$*.

    Замена $y = u - 1, x = v + 3$.
    $
        ddv = - 5/4 arctan (v^2 - 2v) = -5/4 (v^2 - 2v + o(sqrt(v^2 + u^2))) = 5/2 v + o(...)\
        ddu = exp(u^2 + 6u + 9 + 22 u v - 2 u + 6 v - 6 + 3u - 3) - 1 = 4 u + 9 v +o(...)
    $

    Итого линеаризовали систему в:
    $
        cases(
            ddu = 5/2 v,
            ddv = 4 u + 9v
        )
    $

    $ A = mat(0, 5/2; 4, 9) hhh cX_A (lambda) = lambda^2 - 9 lambda - 10 ==> lambda_1 = 10, lambda_2 = -1 $

    Седло. Найдём вектора.

    $
        lambda_1 : hh mat(-10, 5/2; 4, -1) ~ mat(-20, 5; 0, 0) ~ mat(-4, 1; 0, 0) ==> v_1 = vec(1, 4)
    $
    $
        lambda_2 : hh mat(1, 5/2; 4, 10) ==> v_2 = vec(5, -2)
    $

    Рисуем картинку. Не забываем подписать асимптоты по собс. векторам.

    #sep

    *2. $(-1, -1)$*

    $y = u - 1, x = v - 1$

    $ ddu = exp(u^2 - 2u + 1 + 2 u v - 2 u - 2 v + 2 + 3u - 3) - 1 = -4u + v + o(...) $
    $ ddv = 5/2 v + o(...) $

    $ cases(ddv = 5/2 v, ddu = -4u + v) ==> A = mat(0, 5/2; -4, 1) $
    $ cX_A (lambda) = lambda^2 + lambda + 10 ==> lambda = - 1/2 pm sqrt(39/4) i $

    Фокус. Поскольку $Re lambda < 0$, то мы идём к $(0, 0)$.
    Найдём производнуй в какой-нибудь точке. $with(vec(u, v))_((0, 1)) = vec(5/2, 1)$.

    Спиралька по часовой. Рисуем.

/*
    #sep
    
    #canvas(length: 1.3cm, {
        let f(x, y) = (
            - 5/4 * calc.atan(y*y - 1).rad(),
            calc.exp(x*x + 2 * x * y + 3 * y) - 1
        )
        //vecfield(-3, -3, 5, 1, f)
        //traces(-3, -3, 5, 1, f, step: 0.5, maxsteps: 200, color: 0.5pt + olive.transparentize(50%))
        plot.axes(-3, -3, 5, 1)
        plot.pt(-1, -1)
        plot.pt(3, -1)
        plot.xperp(-1, -1)
        plot.xperp(3, -1)
        plot.yperp(3, -1)
    })[Поле производных изначального диффура. Можно заметить найденные точки.]*/
]


