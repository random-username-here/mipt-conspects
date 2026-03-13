#import "../../../multibook/mb.typ": *
#import "../sym.typ": *
#import "@preview/cetz:0.4.2"
#show : mb.chapter(
    title: [Семинар 6. Типы устойчивости],
    date: [13 марта]
)

/*
Итак, на прошлом занятии рассматривали случаи:

 1. Узела
 2. Вырожденного узла
 3. Паралльных прямых
 4. Дикритического узла
 5. Седла
 6. Фокуса
 7. Центра
*/

#task[
    #term[Задача на повторение]
    $ 
        cases(
            ddx = sh (x^4 - y^2 - 1),
            ddy = ln (x^2 - y)
        )
    $
]
#let mmark = (end: ">", offset: 50%, shorten-to: none)
#let rmmark = (start: ">", offset: 50%, shorten-to: none)
#proof[
    *Ищем устойчивые точки:*

    $ 
        ddx = ddy = 0 
        ==> cases(x^2 + y^2 - 1 = 0, x^2 - y = 1) 
        ==> cases(x^4 - (x^2-1)^2 - 1 = 0, y = x^2 - 1)
        ==> cases(x = pm 1, y = 0)
    $

    *Точка $(1, 0)$:*

    Замена $x = u + 1, y = v$. $r = sqrt(u^2 + v^2)$

    $ 
        ddu = sh((u+1)^4 - u^2 - 1) = sh(1 + 4u - 1 + o(r)) = 4u + o(r)\
        ddv = ln((u+1^2 - v)) = ln(1 + 2u - v + o(r)) = 2u - v + o(r)
    $
    Тогда линеаризованная система будет:
    $
        cases(ddu = 4u, ddv = 2u - v) 
        hhh A = mat(4, 0; 2, -1)
        hhh X_A = (4-lambda)(-1-lambda) hhh lambda = 4, -1
    $
    Это седло.

    Собственные вектора:
    $ A - 4 E = mat(0, 0; 2, -5) ==> v_1 = vec(5, 2) $
    $ A + E = mat(5, 0; 2, 0) ==> v_2 = vec(0, 1) $

    #canvas({
        // стрелки от вертикали к линии
        plot.axes(-3, -3, 3, 3, xl: $u$, yl: $v$)
        draw.line((0, -3), (0, 3), stroke: olive)
        draw.line((-2.5, -1), (2.5, 1), stroke: olive)
        for i in (0.3, 0.7) {
            plot.func(x => i/x + 2/5 * x, 0.1, 3, c: olive, mark: mmark, ymax: 3, ymin: -3)
            plot.func(x => i/x + 2/5 * x, -0.1, -3, c: olive, mark: mmark, ymax: 3, ymin: -3)
            plot.func(x => -i/x + 2/5 * x, -0.1, -3, c: olive, mark: mmark, ymax: 3, ymin: -3)
            plot.func(x => -i/x + 2/5 * x, 0.1, 3, c: olive, mark: mmark, ymax: 3, ymin: -3)
        }
    })[Седло]

    *Точка $(-1, 0)$*

    $x = y - 1, y = v$

    $
        ddu = sh((u-1)^4 - u^2 - 1) = sh(-4u + o(r)) = -4u + o(r)\
        ddv = ln((u-1)^2 - v) = ln(1-2u-u+o(r)) = -2u - v + o(r)
    $
    Система 
    $ cases(ddu = -4u, ddv = -2u - v) $

    Решаем, получаем $lambda = -4, -1$. Вектора $vec(3, 2)$ и $vec(0, 1)$.

    Получаем устойчивый узел.

    #canvas({
        plot.axes(-3, -3, 3, 3, iz: true, xl: $u$, yl: $v$)
        draw.line((0, -3), (0, 0), stroke: olive, mark: mmark)
        draw.line((0, 3), (0, 0), stroke: olive, mark: mmark)
        draw.line((3, 2), (0, 0), stroke: olive, mark: mmark)
        draw.line((-3, -2), (0, 0), stroke: olive, mark: mmark)
        for c in (1, 2) {
            plot.func(x => c * calc.sqrt(x) + 2/3 * x, 3, 0, ymin: -3, ymax: 3, c: olive, mark: mmark)
            plot.func(x => -c * calc.sqrt(x) + 2/3 * x, 3, 0, ymin: -3, ymax: 3, c: olive, mark: mmark)
            plot.func(x => c * calc.sqrt(-x) + 2/3 * x, -3, 0, ymin: -3, ymax: 3, c: olive, mark: mmark)
            plot.func(x => -c * calc.sqrt(-x) + 2/3 * x, -3, 0, ymin: -3, ymax: 3, c: olive, mark: mmark)
        }
    })[Устойчивый узел]
]

= Типы устойчивости.

Допустим имеем автономную систему: $dot(bar(x)) = f(bar(x))$.
Допустим имеем начальное условие: $bar(x) (t_0) = bar(x)_0$.

Зачем нужна устойчивость системы? На бумаге если мы в $(0, 0)$, то мы в $(0, 0)$.
На практике если мы в $(0, 0)$, то мы находимся где-то вокруг $(0, 0)$.
Поэтому нужно понимать, что произойдёт из-за этой неточности.

#sep

Устойчивость по Ляпунову простыми словами -- если мы чуть подвинемся, то 
результат не сильно изменится.

Формально:

#def[
    #term[Устойчивость по Ляпунову]

    $phi(t)$ -- решение системы $dot(bar(x)) = f(bar(x))$ устойчиво по Ляпунову,
    если:

    $ forall eps > 0 exists delta > 0 forall bar(x)(t) - "решение" : abs(bar(x)(t_0) - bar(x)_0) < delta 
    ==> abs(bar(x)(t) - phi(t)) < eps forall t in (t_0, +oo) $
]

Менее формально: у нас есть решение и начальная точка.
Если два объекта стартуют в начальной точке и в каком-то шаре диаметра $delta$
вокруг неё, то они не удалятся дальше чем на $eps$.

//#todo[картинка]

#sep

#def[
    #term[Асимптотически устойчивое решение]

    Решение $phi(t)$ асимптотически устойчивое, если:
    1. Оно устойчиво по Ляпунову.
    2. $exists delta_0 > 0 : forall bar(x)(t) - "решение" abs(bar(x)(t_0) - bar(x)_0) < delta_0 : abs(bar(x)(t) - phi(t)) -> 0$
]

Эти два условия никак не связаны. Можно найти системы, подходящие под 1) и 2) по отдельности.

Например такое:

#canvas({
    for k in (0.5, 1, 1.5, 2) {
        draw.line((3, -k), (0, -k), stroke: olive, mark: mmark)
        draw.arc((0, -k), start: -90deg, stop: -270deg, radius: k + 1, stroke: olive, mark: mmark)
        draw.arc((0, 2 + k), start: 90deg, delta: -180deg, radius: (k+2)/2, stroke: olive, mark: mmark)
    }
    draw.arc((0, 0), start: -90deg, delta: 120deg, radius: 2.5, stroke: olive, mark: rmmark)
    draw.arc((0, 0), start: -90deg, delta: 90deg, radius: 3, stroke: olive, mark: rmmark)
    draw.arc((0, 0), start: -90deg, delta: 45deg, radius: 4, stroke: olive, mark: rmmark)
    for k in (0.5, 0.75, 1) {
        draw.arc((0, 2 * k), start: 90deg, delta: -180deg, radius: k, stroke: olive, mark: mmark)
        draw.arc((0, 0), start: -90deg, delta: -180deg, radius: k, stroke: olive, mark: mmark)
    }
    plot.axes(-3.5, -2.5, 3.5, 4.5)
    plot.pt(0, 0)
})

Точка $(0, 0)$ подходит под второе условие (в конце концов все решения оказываются на одной окружности), но устойчивости по Ляпунову в ней нет.
Если возьмём $eps = 1/2$ радиуса окружности, на которую выходит траектория,
то точка постоянно будет залетать и вылетать из $eps$-окрестности $(0, 0)$.

#note[Этот пример подробно разобран в учебнике Филлипова]

#sep

=== Пример: Устойчивость центра

Он устойчив по Ляпунову, но не асимптотически.

#canvas({
    plot.axes(-3, -3, 3, 3)
    draw.circle((0, 0), radius: 2.5, stroke: (dash: "dashed", thickness: 0.5pt))
    draw.circle((0, 0), radius: 1, stroke: (dash: "dashed", thickness: 0.5pt))

    draw.content((1, 1))[$delta$]
    draw.content((2, 2))[$eps$]

    draw.rotate(60deg)
    draw.circle((0, 0), radius: (1, 2.5), name: "path", stroke: olive)
    draw.mark("path.south-east", (rel: (-1, -3)), symbol: ">", stroke: olive)
    draw.mark("path.south-west", (rel: (-1, 2.5)), symbol: ">", stroke: olive)
    draw.mark("path.north-east", (rel: (1, -3)), symbol: ">", stroke: olive)
    draw.mark("path.north-west", (rel: (1, 2.5)), symbol: ">", stroke: olive)
})[Хотим, чтобы все пути с началом в $B_delta$ были внути $B_eps$]

Допустим фиксировано $eps$. Тогда берём такое $delta$, такое что эллипс-решение с малой полусью $delta$
имеет большую полуось $eps$.

Устойчивость по Ляпунову есть.

#sep

Например:

$ cases(ddx = -y, ddy = x) ==> A = mat(0, -1; 1, 0) ==> X_A = lambda^2 + 1 ==> lambda = pm i $
$ A - i E = mat(-i, -1; 1, -i) ~ ... ~ mat(1, -i; 0, 0) ==> v = vec(i, 1) $
$ vec(i, 1) e^(i t) = (vec(0, 1) + i vec(1, 0))(cos t + i sin t) = vec(- sin t, cos t) + i vec(cos t, sin t) $
$ vec(x, y) = C_1 vec(- sin t, cos t) + C_2 vec(cos t, sin t) $

$ x^2 + y^2 &= C_1^2 sin^2 t + C_2^2 cos^2 t - 2 C_1 C_2 cos t sin t\
    &+ C_1^2 cos^2 t + C_2^2 sin^2 t + 2 C_1 C_2 sin t cos t = C_1^2 + C_2^2 $

Итого, имеем окружности. В $vec(sqrt(C_1^2 + C_2^2), 0)$: $vec(ddx, ddy) = vec(0, sqrt(C_1^2 + C_2^2))$.

Если мы берём фиксированное $eps$, берём $delta = eps$, и готово.

#sep

Есть теорема о устойчивости, которая говорит, что если все $Re lambda < 0$, то 
положение равновесия ассимптотически устойчивое. Если есть $Re lambda > 0$, то
положение неустойчивое.

С нулём: если есть собс. знач $0$ и жорданова клетка соотв. ему имеет размер $>=2$, то
положение равновесия неустойчиво.

Если $Re lambda = 0$ и размер жордановых клеток матрицы единичный, то положение равновесия
просто устойчивое, не ассимптотически.

#note[
    Б05-431: *На следующей неделе КР. Также сдача задания.*\

    На КР 4 задачи на темы:

    1. Зависимость решения от параметра.
    2. ЛДУ с переменными коэфф.
    3. Положения равновесия, типы, устойчивость.
    4. Теорема Штурма.
]
