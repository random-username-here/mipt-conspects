#import "../../../multibook/mb.typ": *
#import "../sym.typ": *
#show : mb.chapter(
    title: [Семинар 4: Задачи, задачи и ещё задачи],
    date: [3 марта]
)

#let bxi = $bar(xi)$
#let bx = $bar(x)$

Есть случайный вектор $bar(x) = (xi_1 ... xi_n)$.
Есть, $F_bar(xi) (bar(x)) = P(xi_1 <= x_1 and ... and xi_n <= x_n)$ есть плотность
$rho_bar(xi) (bar(x))$.

Соответственно $P(bar(xi) in A) = int_A rho_bar(xi) (bar(x)) dd bar(x)$.

Допустим у нас есть $phi(bar(xi))$.

$ EE bxi = int_(RR^n) phi(x) rho_bxi (bx) dd bx $

#sep

#task[
    #term[Задача]
    $ x ~ U(0, 2) hh y ~ exp(1) hh x indep y hh P(x > y) = ? $
]

#proof[
    *Решение через плотности:*


    Поскольку величины независимы:
    $ rho_(x, y) (x_0, y_0) = rho_x (x_0) dot rho_y (y_0) = (d1_[0, 2](x_0))/2 dot e^(-y_0) d1_[0, +oo) (y_0) $

    $ P(x > y)
        = int_{x > y} rho_(x, y) dd x dd y
        = ...
    $
    Плотность ненулевая только при $x in [0, 2], y in [0, +oo)$. Также по условию $x < y$.
    Несобственных интегралов не будет.
    $
        ... = int_(x=0)^2 int_(y=0)^x 1/2 e^(-y) dx dy
        = 1/2 int_(x=0)^2 with((-e^(-y)))_(y=0)^(x) dx
        = 1/2 int_(x=0)^2 (1 - e^(-y))\
        = 1/2 (2 - int_0^2 e^(-y) dy) = 1/2 (2 + with((e^(-y))_0^2) = 1/2 (1 + e^(-2)) = 1/2 + 1/2 e^(-2)
    $

    #sep

    *Решение через свёртку:*

    $ 
        rho_(x-y) (s)
        = int_RR rho_x (s+t) dot rho_y (t) dd t
        = int_0^(+oo) 1/2 d1(0 <= s+t <= 2) dot e^t dd t
        = ...
    $
    Пусть $s > 0$, т.к. нам нужны только они.
    $
        ... = cases( s >= 2 &: 0, 0 <= s <= 2 hh &: int_0^(2-s) 1/2 e^(-t) dt = 1/2 (1-e^(s-2)) )
    $
    $
        P(x - y > 0) = int_0^2 1/2 (1-e^(s-2)) dd s = 1 - 1/2 e^(-2) int_0^2 e^s dd s
        = 1/2 + 1/2 e^(-2)
    $
]

#task[
    #term[Задача про автобус]
    $ xi ~ exp(lambda) hhh P(xi > s + t | xi > t) = ? $
    
    _Если уже прождали $t$ минут на остановке, с какой вероятностью придётся ждать ещё $s$ минут?_
]
#proof[
    $ = P(xi > s + t)/P(xi > t) = e^(-lambda (s+t))/e^(-lambda t) = e^(-lambda s) = P(xi > s) $

    _В общем, если вероятность прихода автобуса экспоненциальная, то если прошло
    уже три часа, вероятность что он придёт в следующие 5 минут такая же, как и в начале._
    
    Можно сказать, что оно "не имеет памяти". С другими распределенями такое не работает.
]

#note[$xi ~ Geom(p) ==> P(xi > k) = (1-p)^k$. Его поведение похоже на $exp$]

#task[
    #term[Задача про треугольник]
    $ x ~ U(0, 2) hh y ~ exp(1) hh x indep y hh P("из" x, y, 1 "можно сложить треугольник") = ? $
]
#proof[
    Вспоминаем неравенство треугольника:
    $ 
        cases(x + y > 1, x + 1 > y, y + 1 > x)
        ==> cases(x + 1 > y > x - 1, y > 1 - x)
    $

    Также $x in [0, 2]$.

    #canvas({
        plot.axes(-1, -2, 3, 3)
        draw.line((-1, -2), (2, 1), stroke: (thickness: 0.5pt, dash: "dashed"))
        draw.line((-1, 0), (2, 3), stroke: (thickness: 0.5pt, dash: "dashed"))
        draw.line((-1, 2), (2, -1), stroke: (thickness: 0.5pt, dash: "dashed"))
        draw.line((2, -2), (2, 3), stroke: (thickness: 0.5pt, dash: "dashed"))
        draw.line((2, 3), (0, 1), (1, 0), (2, 1), close: true, stroke: orange, fill: orange.transparentize(90%))
        draw.content((1, 1))[$U$]
    })

    $
        P(Delta) = int_U rho_(x) (x) rho_y y dx dy
        = int_U 1/2 e^(-y) dx dy\
        = int_(y in [0, 1]) int_(x in [1 - y, 1 + y]) e^(-y) dx dy + int_(y in [1, 3]) int_(x in [y - 1, 2]) e^(-y) dx dy\
        = int_0^1 2y e^(-y) dy + int_1^3 (3 - y) e^(-y) dy
        = 2 - 3/e + 1/e^3

    $
]

#task[
    #term[Задача о точке с треугольника]

    Есть $xi, eta$. Их совместное распределение
    $ rho_(xi, eta) =  2dot d1(x >= 0, y >= 0, x + y <= 1) $
    (т.е. $vec(xi, eta)$ распределены равномерно на треуголнике).

    Найти их ковариацию.
]
#proof[
    #canvas(length: 2cm, {
        draw.line((0, 0), (1, 0), (0, 1), close: true, stroke: orange, fill: orange.transparentize(90%))
        plot.axes(0, 0, 1.3, 1.3)
        plot.xtick(1)
        plot.ytick(1)
    })

    $ Cov(xi, eta) = EE (xi eta) - EE xi EE eta $

    $ x in [0, 1] ==> rho_xi (x) = int_(y = 0)^(1-x) 2 dx = 2 (1-x) $
    $ forall x in.not [0, 1] : rho_xi (x) = 0 $

    $ EE xi = int_RR x dot rho_(xi) (x) dx = int_0^1 2 x (1-x) dx = 2 int_0^1 (x - x^2)
        =  2(1/2 - 1/3) = 1/3
    $

    $rho_eta$ и $EE eta$ аналогичны.

    $
        EE (xi eta) = int_(RR^2) x y dot rho_(xi,eta) (x, y) dx dy
        = 2 int_(x=0)^1 int_(y=0)^(1-x) x y dx dy\
        = 2 int_(x=0)^1 x (1-x)^2/2 dx = int_(x=0)^1 (x^3 - 2x^2 + x) dx\
        = 1/4 - 2/3 + 1/2  = 1/12
    $

    Ну и соответственно:

    $ Cov (xi, eta) = EE (xi eta) - EE xi EE eta = 1/12 - 1/9 = -1/36 $
]

