#import "../../../multibook/mb.typ": *
#show : mb.chapter(
    title: [Семинар 3. Свертки и ряд Фурье],
    date: [17 февраля] 
)

= Продолжение свёрток

#def[
    #term[Утверждение]

    Пусть $f in L_1 (RR)$. Тогда 
    $ forall eps > 0 exists R > 0 : int_{abs(x) >= RR} abs(f) dd mu < eps $

    #canvas(length: 1.5cm, {

        let f(x) = 2/(calc.exp(x) + calc.exp(-x))
        let zero(x) = 0
        plot.func(f, -3, 3, c: blue)
        plot.fill2(f, zero, -3, -1, stroke: blue, fill: blue.transparentize(90%))
        plot.fill2(f, zero, 1, 3, stroke: blue, fill: blue.transparentize(90%))
        plot.xtick(1, $R$)
        plot.xtick(-1, $-R$)
        draw.content((2.5, 1))[$ int_{abs(x) > R} abs(f) dd mu < eps $]
        plot.axes(-3, 0, 3, 1.5)
    })
]

#proof[
    Рассмотрим $g_n = abs(f) d1_[-n, n] (x)$. $g_n -> abs(f)$ поточечно.
    По мажорируемой сходимости следует, что 
    $ int_{abs(x) >= n} abs(f) dd mu = int abs(g_n - abs(f)) dd mu stretch(->)^(n -> oo) 0 $
]

#def[
    #term[Функции с компактным носителем]

    #term[$C_c (RR)$] -- непрерывные функции с компактным носителем.

    $C_c^n (RR)$ -- дифференцируемые $n$ раз.
]

#def[
    #term[Теорема о приближении непр. функцией с компактным носителем]
    $ forall f in L_1 (RR) forall eps > 0 exists f_eps in C_c (RR) : norm(f - f_eps) = int_RR abs(f - f_eps) dd mu < eps $

    Это означает, что $bar(C_c (RR)) = L_1 (RR)$. Аналогично можно сказать про $C_c^oo (RR)$.
]

#task[
    #term[Т7]

    Пусть $f, g in L_1 (RR)$, $g$ ограничена. Доказать, что $(f * g) (x) stretch(->)^(x -> pm oo) 0$.
]
#proof[
    $ forall eps exists f_eps in C_c (RR) : norm(f - f_eps)_(L_1) < eps $
    $ abs((f * g)(x) - (f_eps * g)(x)) = abs(int_RR (f(x-t) - f_eps (x-t)) g(t) dd t)\
        <= sup_RR abs(g) dot int_RR abs(f(x-t) - f_eps (x-t)) dd t < eps dot sup_RR g
    $
    Теперь достаточно доказать, что $(f_eps * g)(x) stretch(->)^(x -> pm oo) 0$.

    $ 
        abs((f_eps * g)(x)) 
        &= abs(int_RR f_eps (x-t) g(t) dd t) = abs(int_RR f_eps (t) g(x-t) dd t)\
        &= abs(int_[-M, M] f_eps (t) g(x-t) dd t) "(т.к. " f_eps "на компактном носителе)"\
        &<= sup_RR abs(f_eps) int_[-M, M] abs(g(x-t)) dd t
            = sup_RR abs(f_eps) int_[x-M, x+M] abs(g(y)) dd y\
        & -> 0
    $

    Визуально: имеем $[-R, R]$, за пределами которой $int g < eps$. 
    Когда мы делаем $x -> pm oo$, то компактный носитель в конце концов 
    вылетает за эти пределы, и интеграл становится $< eps * sup abs(f_eps) -> 0$.
]

#def[
    #term[Теорема 3 (с лекции)]

    Пусть $h : X xx (a, b) -> RR$. 
    1. $h(x, y)$ интегрируема на $X$ $forall y in (a, b)$.
    2. $h(x, y)$ дифф. по $y forall x in X$
    3. $exists g in L_1 (X): forall y in (a, b) : abs(h'_y (x, y) <= g(x))$

    Тогда:

    $
        dd/(dy) int_X h(x, y) dx = int_X h'_y (x, y) dx
    $

    1 и 2 нужны чисто для корректности выражения.
]

#def[
    #term[Производная свёртки]

    Рассмотрим $f, f'$ -- ограниченные, $g in L_1 (RR)$.
    Дифференцируема ли $(f * g) (x) = int_RR f(x-t) g(t) dd t$?
]
#proof[
    Тут $h(x, y)$ соответствует $(t, x) |-> f(x-t) g(t)$, условия выполняются.

    Тогда:

    $ abs(f' (x-t) g(t)) <= C abs(g(t)) $
    $ dd/dx (f * g) (x) = int_RR f' (x-t) g(t) dd t = ((dd f)/dx * g)(x) $
]

= Ряд Фурье

#def[
    #term[Ряд Фурье]

    Пусть имеем функцию $f in L_1 [-pi, pi]$.
    Ставим ей в соответствие тригонометрический ряд:

    $ f ~ a_0 + sum_(k=1)^oo (a_k cos k x + b_k sin k x) $

    Где:
    $ a_0 &= 1/(2pi) int_[-pi, pi] f(x) dx\ 
        a_k &= 1/pi int_[-pi, pi] f(x) cos k x dx\
        b_k &= 1/pi int_[-pi, pi] f(x) sin k x dx $

    Этот ряд называется рядом Фурье функции (РФ функции).

    Условие на принадлежность $L_1$ нужно, чтобы интегралы были.
]

== Откуда такие коэффициенты?

Можно определить скалярное произведение в $L_2$:
$ (g, h) = int_RR g(x) h(x) dx $

Рассмотрим такую систему функций: ${ 1, cos k x, sin k x }_(k=1)^oo$.
Она ортогональна:

$ (cos k x, sin m x)
    = int_(-pi)^pi cos k x sin m x dx
    = 1/2 int_(-pi)^pi (sin(k+m) x - sin(k-m) x) dx = 0
$
Аналогично $(1, cos k x) = (cos k x, cos m x)$ и все другие скалярные произведения $=0$.

Пусть $f$ как-то разложили по этой системе:

$ f = a_0 dot 1 + sum_(k=1)^oo (a_k cos k x + b_k sin x) $

Тогда рассмотрим $(f, cos m x)$.
$ (f, cos m x) = a_m (cos m x, cos m x) $
$ (cos m x, cos m x) = int_(-pi)^pi cos^2 m x dx = pi $
$ ==> a_m = 1/pi (f, cos m x) = 1/pi int_[-pi, pi] f(x) cos m x dx $

Ну и другие коэффициенты так же.

$ (f, 1) = a_0 dot (1, 1) = 2 pi a_0 $

== Зачем?

Дальше докажем, что это базис в неком пространстве функций.
И тогда мы можем выражать сложные действия как преобразования базиса.

== Когда ряд Фурье равен функции?

#def[
    #term[Критерий равенства ряда Фурье и функции]

    Пусть $f in L_1 [-pi, pi]$. Пусть в $x_0 in (-pi, pi)$ существуют
    конечные обобщенные односторонние производные, то есть есть правая такая
    производная:
    $ lim_(Delta x -> +0) (f(x_0 + Delta x) - f(x_0 + 0))/(Delta x) $
    _(тут $f(x_0 + 0)$ -- предел сверху!)_ и ещё левая такая же.

    Тогда РФ в точке $x_0$ сходится к $(f(x_0 - 0) + f(x_0 + 0))/2$.

    Если $x_0 = pm pi$, то нужны конечные обобщ. производная слева в $pi$ и справа в $-pi$.
    Они должны существовать одновременно, даже если нам нужна только одна сторона!
    РФ в этих точках сходится к $(f(-pi+0) + f(pi-0))/2$
]

Если функция дифференцируемая, то все условия выполняются, и ряд Фурье равен функции.

#task[
    #term[С2 #sym.section 22.12]
    $ f(x) = sign x hhh x in [-pi, pi] $

    Разложить в РФ и построить график суммы РФ.
]

#proof[
    Расписывая ряд Фурье ничего хорошего не получим. Нужно пользоваться теоремой.

    Везде кроме $0$, $pi$ и $-pi$ производные есть, сходится к $sign x$.
    В нуле ряд Фурье будет сходится к $0$, в $pm pi$ тоже.

    За пределами $[-pi, pi]$ ряд Фурье будет повторяться.

    РФ сходится к разрывной функции, так что равномерной сходимости не будет
    (по т-ме с первого курса).

    #sep

    Теперь посчитаем. Функция нечётная, так что $a_0 = a_k = 0$.
    Ненулевые только $b_k$.

    $ b_k = 1/pi int_(-pi)^pi sign x dot sin k x dx = 2/pi int_0^pi sin k x dx = with(-2/(pi k) cos k x)^pi_0 = 2/(pi k) (1 - (-1)^k) $

    Итого:

    $ sign x ~ sum_(k=1)^oo 2/(pi k) (1 - (-1)^k) sin k x = sum_(n=1)^oo 4/(pi(2n - 1)) sin ((2n-1)x) $

    #canvas(length: 0.6cm, {
        let l = -calc.pi * 3
        let r = calc.pi * 3
        let approx(x, cnt: 10) = {
            let res = 0
            for n in range(1, cnt+1) {
                res += 4/(calc.pi * (2 * n - 1)) * calc.sin((2 * n - 1) * x)
            }
            return res
        }
        let cnts = (1, 2, 3, 5, 7, 9, 11)

        for (i, n) in cnts.enumerate() {
            let y = i * 2
            plot.func(
                x => approx(x, cnt: n)/2 + y,
                l, r,
                pts: 512,
                c: blue.transparentize(70% - 5% * n)
            )
            draw.content((r + 1.5, y))[$N = #n$]
            draw.line((l, y), (r, y), stroke: 0.5pt + black, mark: (end: "barbed"))
        }
    })[Постепенные приближения]
    
    /*
    #sep

    // получили разложение синуса...

    Если посмотреть на ряд фурье в $pi/2$, то там можно увидеть что 
    $ sum^oo_(n=1) 4/pi (-1)^(n-1)/(2n-1) ==> sum_(n=1)^oo (-1)^(n-1)/(2n-1) = pi/4 $

    Это никак ни к чему не относится, просто почему-то заметили на семинаре.
    Посчитать его без 
    */
]


#def[
    #term[Кусочно гладкая функция]

    $f$ кусочно гладкая на $[a, b]$ если $f$ непр. на $[a, b]$ и отрезок
    можно разбить на $[t_1 = a, t_2] uu.sq ... uu.sq [t_(n-1), t_n = b]$,
    так что $f$ непр. дифференцируема на всех отрезках $[t_i, t_(i+1)]$.
]

#def[
    #term[Теорема]

    $f$ кусочн-гладкая на $[-pi, pi]$ и $f(pi) = f(-pi)$. Тогда
    РФ сходится к $f$ равномерно на $[-pi, pi]$.
]

// map x to [-pi, pi]
#let pp(x) = calc.rem(calc.rem(x / 2 - calc.pi/2, calc.pi) + calc.pi, calc.pi) * 2 - calc.pi

Например рассмотрим ряд Фурье, сходящийся к $f(x) = abs(x)$.
Равномерная сходимость будет.

#canvas(length: 0.5cm, {
    plot.axes(-8, 0, 8, 4)
    plot.func(x => calc.abs(pp(x)), -8, 8, c: blue, pts: 128)
    plot.xtick(calc.pi, $pi$)
    plot.xtick(-calc.pi, $-pi$)
})[Ряд Фурье для $f(x) = abs(x)$]

Если $f(x) = x$, то равномерной сходимости нет, так как предельная функция
не непрерывная. Тут не ссылаемся на теорему, так как она просто даёт следствие.

#canvas(length: 0.5cm, {
    plot.axes(-8, 0, 8, 4)
    plot.func(x => x, -calc.pi, calc.pi, c: blue, pts: 2)
    plot.func(x => x - 2 * calc.pi, calc.pi, 8, c: blue, pts: 2)
    plot.func(x => x + 2 * calc.pi, -8, -calc.pi, c: blue, pts: 2)
    plot.xpt(calc.pi, calc.pi, c: blue)
    plot.xpt(calc.pi, -calc.pi, c: blue)
    plot.xpt(-calc.pi, -calc.pi, c: blue)
    plot.xpt(-calc.pi, calc.pi, c: blue)
    plot.xtick(calc.pi, $pi$)
    plot.xtick(-calc.pi, $-pi$)
    plot.pt(calc.pi, 0, c: blue)
    plot.pt(-calc.pi, 0, c: blue)
})[Ряд Фурье для $f(x) = x$]

#def[
    #term[Лемма Римана об осциляции]

    Пусть $f in L_1 (X)$. Тогда 
    $ 
        cases(reverse: #true,
            display(int_X f(x) cos omega x dd mu(x)) hh,
            #v(1em),
            display(int_X f(x) sin omega x dd mu(x))
        ) stretch(->)^(omega -> pm oo) 0 
    $

    Из этого для рядов Фурье следует, что $a_k, b_k stretch(->)^(k -> oo) 0$
]


