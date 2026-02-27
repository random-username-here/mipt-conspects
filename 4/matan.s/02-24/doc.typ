#import "../../../multibook/mb.typ": *
#show : mb.chapter(
    title: [Семинар 4. Задачи на ряд Фурье],
    date: [24 февраля] 
)

#let pp(x) = calc.rem(calc.rem(x / 2 - calc.pi/2, calc.pi) + calc.pi, calc.pi) * 2 - calc.pi

#task[
    #term[Задача С2.22.45.1]

    $ f(x) = x^2 hh x in [-pi, pi] $

    Разложить в РФ, нарисовать график и исследовать на равн. сходимость.
]

#proof[
    #canvas({
        plot.axes(-6, 0, 6, 4, yl: [РФ])
        plot.func(x => pp(x) * pp(x) / 4, -6, 6, c: blue)
        let t = calc.pi * calc.pi / 4
        plot.xperp(calc.pi, t, $pi$)
        plot.xperp(-calc.pi, t, $-pi$)
        plot.yperp(calc.pi, t, none)
        plot.yperp(-calc.pi, t, none)
        draw.content((0.4, t + 0.4), $pi^2$)
    })[Ряд Фурье $f(x) = x^2$.\ График сплющен в 4 раза, чтобы влез на страницу.]

    Равномерная сходимость есть по теореме.

    $ b_k = 0 $
    $ a_0 = 1/(2 pi) int_(-pi)^pi x^2 dx = 1/pi int_0^pi x^2 dx = pi^2/3 $
    $ 
        a_k = 2/pi int_0^pi x^2 dot ub(cos k x dx, dd ((sin k x)/k)) = 2/(pi k) with(x^2 sin k x)_0^pi - 2/(pi k) int_0^pi 2x dot ub(sin k x dx, dd(-(cos k x)/k)) \
        = 3/(pi k^2) with(x cos k x)_0^pi - 4/(pi k^2) cos k x dx = (4(-1)^k)/k^2
    $

    Итого:

    $ x^2 tilde.equiv_[-pi, pi] pi^2/3 + sum_(k=1)^oo (4(-1)^k)/k^2 cos k x $

    Равномерная сходимость будет тут и без теоремы, т.к. $abs((4(-1)^k)/k^2 cos k x) <= 4/k^2$.
    $sum 4/k^2$ сходится $=>$ есть равн. сходимость по Вейерштрассу.

    Этот вариант менее полезный, чем по теореме (т.к. не понятно, к чему равномерная
    сходимость), но чтобы проверить нормальный.

    #sep

    Можно вычислить несколько рядов, пользуясь данным разложением.

    При $x = pi$ ряд превращается в
    $ pi^2 = pi^2/3 + sum_(k=1)^oo (4 (-1)^k)/k^2 cos (pi k) = pi^2/3 + sum_(k=1)^oo 4/k^2
        ==> sum_(k=1)^oo 1/k^2 = pi^2/6
    $
   
    При $x = 0$:

    $
        0^2 = pi^2/3 + sum_(k=1)^oo (4 (-1)^k)/k^2 ==> sum_(k=1)^oo (-1)^k/k^2 = -pi^2/12
    $

    Из них можно вычислить ещё один ряд:
    $
        sum 1/(2k-1)^2 = 1/2 (sum 1/k^2 - sum (-1)^k/k^2) = pi^2/8
    $
]

#task[
    #term[Задача C2.22.45.2]

    $f(x) = x^2$. Разложить по $sin k x$ на $(0, pi)$.
]
#proof[
    Рассмотрим $g(x) = sign x dot x^2$.

    #canvas(length: 0.7cm, {
        let sign(x) = if x < 0 { -1 } else { 1 }
        let g(x) = sign(x) * x * x
        plot.axes(-8, -4, 8, 4)
        plot.func(x => g(x) / 3, -calc.pi, calc.pi, c: blue)
        plot.func(x => g(x - calc.pi * 2) / 3, calc.pi, 8, c: blue)
        plot.func(x => g(x + calc.pi * 2) / 3, -8, -calc.pi, c: blue)
        let t = calc.pi * calc.pi / 3
        plot.xperp(calc.pi, t, $pi$)
        plot.xperp(-calc.pi, -t, $-pi$)
        plot.xpt(calc.pi, t, c: blue)
        plot.xpt(calc.pi, -t, c: blue)
        plot.xpt(-calc.pi, t, c: blue)
        plot.xpt(-calc.pi, -t, c: blue)
        plot.pt(calc.pi, 0, c: blue)
        plot.pt(-calc.pi, 0, c: blue)
    })[Ряд Фурье $g(x)$. Сплющен в 3 раза.]

    У ряда фурье нет равн. сходимость, т.к. функция разрывная.

    $
        b_k = 1/pi int_(-pi)^pi g(x) sin k x dx = 2/pi int_0^pi x^2 sin k x dx = (2 pi)/k (-1)^k + 4/(pi k^3) ((-1)^k - 1)
    $

    Так как $g(x) = x^2$ на $(0, pi)$, то:
    $
        ==> x^2 tilde.equiv_((0, pi)) sum_(k=1)^oo  ((2 pi)/k (-1)^k + 4/(pi k^3) ((-1)^k - 1))
    $
]

#task[
    #term[Задача С2.22.45.3]

    Разложить $f(x) = x^2$ по $cos$ и $sin$ на $(0, 2pi)$.
]

#proof[
    $f in L_1 [a - l, a + l]$.
    Берём вместо обычной системы ${1, cos k x, sin k x}$ систему ${1, cos (pi k x)/l, sin (pi k x)/l }$.

    $ a_0 = 1/(2 l) int_(a-l)^(a+l) f(x) dx hhh b_k = 1/l int_(a-l)^(a+l) f(x) sin (pi k x)/l dx hhh a_k = "...аналогично" b_k $

    #sep

    Разложим таким образом.

    #canvas(length: 0.4cm, {
        plot.axes(-5, 0, 12, 16)
        let f(x) = x * x
        plot.func(x => f(x) / 3, 0, calc.pi * 2, c: blue)
        plot.func(x => f(x - calc.pi * 2) / 3, calc.pi * 2, calc.pi * 4, c: blue)
        plot.func(x => f(x + calc.pi * 2) / 3, -5, 0, c: blue)
        let t = f(calc.pi * 2)/3
        plot.xperp(calc.pi * 2, t, $2pi$)
        plot.yperp(calc.pi * 2, t, $4pi^2$)
        plot.pt(calc.pi * 2, t/2, c: blue)
        plot.xpt(calc.pi * 2, t, c: blue)
        plot.xpt(calc.pi * 2, 0, c: blue)
        plot.pt(0, t/2, c: blue)
        plot.xpt(0, t, c: blue)
        plot.xpt(0, 0, c: blue)
    })

    $ a_0 = 1/(2pi) int_0^(2pi) x^2 dx = (4pi^2)/3 $
    $ b_k = 1/pi int_0^(2pi) x^2 sin k x dx = ... "оставляется читателю" $
]

#task[
    #term[Задача]

    $ f(x) = abs(x - pi/4) "на" [-pi/4, (3pi)/4] $
    Ряд Фурье по системе ${1, cos 2 k x, sin 2 k x}$.
]

#proof[
    $ a_k = 2/pi int_(-pi/4)^((3pi)/4) f(x) cos 2 k x dx $

    Сделаем подинтегральное периодическим.
    Подинтегральное имеет период, можем подвигать. Можем функцию опустить на константу и получим что все $a_k$
    после первого нулевые.
]

#task[
    #term[Задача С2.22.65]

    $ f in L_1 [0, pi] hhh f(pi - x) = f(x) $

    Доказать, что:

    1. При разложении по $cos$ все нечётные коэфф. равны нулю: $a_(2n-1) = 0$
    2. При разложении по $sin$ всё чётные коэфф. нулевые: $b_(2n) = 0$
]

#proof[
    *Пункт 1*

    Продлим функцию чётно на $[-pi, pi]$, тогда синусов в разложении не будет.

    Идейно: $cos$ нечётных степеней не симметричны отн. $pi/2$, и зануляются.
    #canvas(length: 1.5cm, {
        plot.func(x => calc.cos(x), 0, calc.pi, c: blue.lighten(70%))
        plot.func(x => calc.cos(2 * x), 0, calc.pi, c: blue)
        plot.func(x => calc.cos(3 * x), 0, calc.pi, c: blue.lighten(70%))
        plot.func(x => calc.cos(4 * x), 0, calc.pi, c: blue)
        plot.axes(0, -1, 4, 1)
        plot.xtick(calc.pi, $pi$)
        plot.xtick(calc.pi/2, $pi/2$)
    })

    $ a_(2n-1) &= 2/pi int_0^pi f(x) (cos(2n-1) x) dx\
        &stretch(=)^(x = pi - y) 2/pi int_0^pi ub(f(pi - y), = f(y)) dot ub(cos((2n-1)(pi-y)), = - cos ((2n-1) y)) dy\
        &= - 2/pi int_0^pi f(y) cos ((2n-1)y) dy ==> a_(2n-1) = 0
    $

    Для $a_(2n)$ подинтегральное симметрично отн. $pi/2$, поэтому:

    $
        a_(2n) = 2/pi int_0^pi f(x) cos (2 k x) dx = 4/pi int_0^(pi/2) f(x) cos (2 k x) dx
    $

    *Пункт 2*

    Аналогично. Также можно рассмотреть $f(pi - x) = - f(x)$, там нулёвость чётных/нечётных коэфф.
    противоположные.
]

#task[
    #term[Задача]

    $ f(x) = pi/2 - x hh x in (0, pi/2) $
    Разложить по ${cos (2 k x)}$, ${cos ((2k-1)x)}$, ${sin 2k x}$, ${cos((2k-1) x)}$.
]

#proof[
    *По чётным косинусам*

    Продлеваем. Чтобы избавиться от синусов, делаем функцию чётной.
    Чтобы избавиться от нечётных, продлеваем на $(pi/2, pi)$ вверх. Сходится равномерно.

    #canvas(length: 1.5cm, {
        plot.axes(-2.3, 0, 2.3, 1.3)
        draw.line((-2, 1), (-1, 0), (0, 1), (1, 0), (2, 1), stroke: 1pt + blue)
        plot.xtick(1, $pi/2$)
        plot.xtick(2, $pi$)
        plot.xtick(-1, $-pi/2$)
        plot.xtick(-2, $-pi$)
    })

    $
        a_(2 k) 
        &= 4/pi int_0^(pi/2) (pi/2 - x) cos 2 k x dx
        = 4/(2 pi k) (pi/2 - x) with(sin 2 k x)_0^(pi/2) + 2/(pi k) int_0^(pi/2) sin 2 k x dx\
        &= -2/(pi k) 1/(2k) with(cos 2 k x)_0^(pi/2) = 1/(pi k^2) (1 - (-1)^k)
    $

    #note[Подобная задача будет на КР]
    #note[
        Некоторые определяют продолженную функцию как кусочную, и получают 4 интеграла.
        Не будьте такими, пользуйтесь симметрией.
     ]

    *По чётным синусам*

    Продлеваем. Равномерной сходимости нет.

    #canvas({
        plot.axes(-2.5, -2.5, 2.5, 2.5)
        draw.line((-1, 2), (2, -1), stroke: blue)
        draw.line((-2, -1), (-1, -2), stroke: blue)
        plot.xpt(-1, -2, c: blue)
        plot.xpt(-1, 2, c: blue)
        plot.xtick(1, $pi/2$)
        plot.xtick(-1, $-pi/2$)
        plot.xtick(-2, $-pi$)
        plot.xtick(2, $pi$)
        plot.pt(-1, 0, c: blue)
    })

    $
        b_(2k) = 4/pi int_0^(pi/2) (pi/2 - x) sin 2 k x dx = ...
    $

    Ну а дальше очев, как и с оставшимися пунктами.
]
