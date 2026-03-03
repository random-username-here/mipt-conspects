#import "../../../multibook/mb.typ": *
#show : mb.chapter(
    title: [Семинар 5. РФ в комплексной форме и дифференцирование РФ],
    date: [3 апреля]
)

= Ряд Фурье в комплексной форме

Вспомним ряд Фурье:
$ f ~ a_0 sum_(k=1)^oo (a_k cos k x + b_k sin k x) $

А также что $cos k x$ и $sin k x$ выражаются через комплексные экспоненты:

$ cos k x = (e^(i k x) + e^(- i k x))/2 hhh sin k x = (e^(i k x) - e^(- i k x))/(2i) $

Тогда:
$
    a_k cos k x + b_k sin k x
    = e^(i k x) dot 1/2 (a_k - i b_k) + e^(-i k x) dot 1/2 (a_k + i b_k) $

$
    c_k 
    &:= 1/2 (a_k - i b_k) \
    &= 1/(2 pi) (int_(-pi)^pi f(x) cos k x dx 
    - i int_(-pi)^pi f(x) sin k x dx)\
    &= 1/(2pi) int_(-pi)^pi f(x) e^(- i k x) dx
$

Заметим также что:
$ c_0 = 1/(2pi) int_(-pi)^pi f(x) e^(i 0 x) dx = a_0 
hhh 1/2 (a_k + i b_k) = c_(-k) $

Итого, получили что РФ можно записать вот в такой форме:
$ f ~ sum_(k in ZZ) c_k e^(i k x) $

#task[
    #term[Задача]
    $ f(x) = e^x hhh x in [-pi, pi] hhh "РФ" f = ? $

]
#proof[
    $ c_k &= 1/(2pi) int^pi_(-pi) e^x e^(- i k x) dx
        = 1/(2pi) int_(-pi)^pi e^(x(1-i k)) dx =^((#footnote[Строго это равенство доказывается на 3-м курсе]))
        with(1/(2pi) 1/(1 - i k) e^(x(1-i k)))_(-pi)^pi\
        &= 1/(2pi) 1/(1-i k) (e^(pi(1 - i k)) - e^(-pi(1 - i k)))
        = 1/(2pi) 1/(1-i k) (-1)^k (e^pi - e^(-pi)) = (sh pi)/pi dot (-1)^k/(1 - i k)
    $

    Итого:

    $ e^x ~ sum_(k in ZZ) (sh pi)/pi dot (-1)^k/(1 - i k) e^(i k x) $

    В обычном ряду Фурье были бы интегралы $1/pi int_(-pi)^pi e^x sin k x dx$,
    их сложнее считать.

    Ну и график РФ:

    #canvas(length: 2cm, {
        plot.axes(-1.3, -1, 1.3, 2)
        plot.func(x => calc.exp(x * calc.pi) / 12, -1, 1, c: blue)
        plot.xpt(1, calc.exp(calc.pi) / 12, c: blue)
        plot.pt(1, calc.cosh(calc.pi) / 12, c: blue)
        plot.pt(-1, calc.cosh(calc.pi) / 12, c: blue)
        plot.yperp(1, calc.cosh(calc.pi) / 12, $ch pi$)
        plot.xtick(1, $pi$)
        plot.xtick(-1, $-pi$)
        plot.xpt(-1, calc.exp(-calc.pi) / 12, c: blue)
    })[График РФ]

    График поточечно сходится, т.к. есть односторонние производные.
    Равномерной нет, т.к. функция разрывна.
]

#let ipp = $int_(-pi)^pi$

#task[
    #term[Задача Т8.1]

    Пусть $f$ -- $2pi$-периодическая непрерывная на $RR$ функция.
    Доказать, что у неё коэфф.: 
    $ c_n = 1/(4 pi) int_(-pi)^pi (f(x) - f(x + pi/n)) e^(-i n x) dx hhh n in ZZ $
]
#proof[
    Так как $e^(i pi) = -1$, то можно сделать так:
    $
        c_n = 1/(2pi) int_(-pi)^pi f(x) e^(- i n x) dx
        = 1/(4 pi) (int_(-pi)^pi ... - e^(i pi) int_(-pi)^pi ...)\
        = 1/(4 pi) (ipp ... - ipp f(x) e^(-i n (x-pi/n)) dx)\
        = 1/(4 pi) (ipp f(x) e^(- i n x) dx - int_(-pi - pi/n)^(-pi + pi/n) f(y + pi/n) e^(- i n y) dy) = ...\
    $
    Воспользуемся тем что функция периодичная и $e^(- i n y)$ тоже.
    $
        ... = 1/(4 pi) (ipp f(x) e^(- i n x) dx - ipp f(y + pi/n) e^(- i n y) dy)\
        = 1/(4pi) ipp (f(x) - f(x + pi/n)) e^(-i n x) dx
    $
]

#task[
    #term[Задача Т8.2]

    Пусть $f$ удовлетворяет условию Гельдера с параметром $alpha in (0, 1)$ на $RR$,
    то есть 
    $ exists C > 0 forall x, y in RR : abs(f(x) - f(y)) <= C abs(x-y)^alpha $

    Доказать, что в этом случае $abs(c_n) in O(1/abs(n)^alpha)$
]

#note[
    На семинаре на доске будет $und(O)$ для $O(...)$ и $bar(bar(o))$ для $o(...)$,
    чтобы можно было их различить. Эти обозначения нестандартные.
]

#proof[
    $
        abs(c_n) &= 1/(4 pi) abs(ipp (f(x) - f(x+pi/4))  e^(-i n x) dx)
        <= 1/(4 pi) ipp abs(f(x) - f(x + pi/n)) dx\
        &<= 1/2 (pi/abs(n))^alpha dot C in O(1/abs(n)^alpha)
    $
]

#note[У функции удовлетворяющей условию Гельдера есть равномерная сходимость. Возможно на лекции будет.]

= Операции с рядом Фурье

Имеем ряд Фурье:
$
    f ~ a_0 + sum_(k=1)^oo (a_k cos k x + b_k sin k x)
$

Предполагаем, что иногда:

$
    f' ~ sum_(k=1)^oo (- k a_k sin k x + k b_k cos k_x)
$

Вопрос только -- когда?

#def[
    #term[Теорема о почленном дифференцировании]

    Пусть $f$ кусочно-гладкая на $[-pi, pi]$ и $f(pi) = f(-pi)$.

    _Следовательно $f(x)$ равна своему РФ и сходимость равномерная (см. теорему)._

    Тогда $f' ~ sum (-k a_k sin k x + k b_k cos k_x)$. Равенство не гарантируется.
]

Во втором семестре была чем-то похожая теорема о дифференцировании функционального ряда:

#def[
    $F(x) = sum f_k (x)$. Тогда $F'(x) = sum f'_k (x)$ если $sum f'_k (x)$ равномерно сходится.
]

#def[
    #term[Кусочно-гладкая функция]

    $f$ кусочно-гладкая на $[a, b]$ если она непрерывная и если есть разбиение,
    такое что на каждом кусочке $[t_i, t_(i+1)]$ она гладкая, по концам есть односторонние производные
]

/*
#note[
    Рассуждение ниже это попытки группой вывести следующую теорему.
]

Когда равенство всё-таки есть? Пусть $f in L_1$ и кусочно гладкая.
Тогда $int_0^x f' (t) dt = f(x) - f(0)$

Поскольку $f'$ гладкая на отрезках $(t_i, t_(i+1))$, то она продолжается до $[t_i, t_(i+1)]$
и следовательно $f'$ на отрезках ограничена.
Значит $f'$ ограничена на $[a, b]$.

В общем, получаем что $f' in L_1 ([-pi, pi])$. Тогда $a_k, b_k = o(1/k)$.
*/
#def[
    #term[Теорема о порядке убывание коэфф. Фурье]

    Пусть $f$ такая, что:
    $ forall i in {0 ... m-1} : f^((i)) "кусочно-гладкая" and f^((i)) (pi) = f^((i)) (-pi) $
    Тогда $a_k, b_k = o(1/k^m)$.
]

#task[
    #term[Задача]
    $ f(x) = (pi^2 - x^2)^2 $
    Построить график РФ, почленно единожды, дважды и трижды продифференцированного РФ.
    Сам РФ не вычислять.
]

#proof[
    $ f' (x) = -4(pi^2 - x^2) x hhh f''(x) = 12 x^2 - 4 pi^2 hhh f'''(x) = 24x $

    #block(breakable: false, stack(dir: ltr,
        canvas(length: 0.5cm, {
            let pi = calc.pi
            plot.axes(-2 * pi, -3, 2 * pi, 4, yl: $"РФ" f$)
            plot.ytick(pi*pi*pi*pi/30)[$π^4$]
            plot.func(x => calc.pow(calc.pi * calc.pi - x * x, 2) / 30, -pi, pi, c: blue)
            plot.func(x => calc.pow(calc.pi * calc.pi - calc.pow(x + 2 * pi, 2), 2) / 30, -2 * pi, -pi, c: blue)
            plot.func(x => calc.pow(calc.pi * calc.pi - calc.pow(x - 2 * pi, 2), 2) / 30, pi, 2 * pi, c: blue)
            plot.xtick(pi, $π$)
            plot.xtick(-pi, $-π$)
        })[РФ. $f' ~ $ почленно\ проидфференированному.],
        h(1em),
        canvas(length: 0.5cm, {
            let pi = calc.pi
            let f(x) = -4 * (pi * pi - x * x) * x
            plot.axes(-2 * pi, -3, 2 * pi, 4, yl: $"РФ" f'$)
            plot.func(x => f(x) / 30, -pi, pi, c: blue)
            plot.func(x => f(x + 2 * pi) / 30, -2*pi, -pi, c: blue)
            plot.func(x => f(x - 2 * pi) / 30, pi, 2*pi, c: blue)
            plot.xtick(pi, $π$)
            plot.xtick(-pi, $-π$)
        })[Также $f'' ~ ...$]
    ))
    #block(breakable: false, stack(dir: ltr,
        canvas(length: 0.5cm, {
            let pi = calc.pi
            let f(x) = 12 * x * x - 4 * pi * pi
            plot.axes(-2 * pi, -3, 2 * pi, 4, yl: $"РФ" f''$)
            plot.func(x => f(x) / 30, -pi, pi, c: blue)
            plot.func(x => f(x + 2 * pi) / 30, -2*pi, -pi, c: blue)
            plot.func(x => f(x - 2 * pi) / 30, pi, 2*pi, c: blue)
            plot.xtick(pi, $π$)
            plot.xtick(-pi, $-π$)
        })[Все ещё $~$],
        h(1em),
        canvas(length: 0.5cm, {
            let pi = calc.pi
            let f(x) = 24 * x
            plot.axes(-2 * pi, -3, 2 * pi, 4, yl: $"РФ" f'''$)
            plot.func(x => f(x) / 30, -pi, pi, c: blue)
            plot.func(x => f(x + 2 * pi) / 30, -2*pi, -pi, c: blue)
            plot.func(x => f(x - 2 * pi) / 30, pi, 2*pi, c: blue)
            plot.xtick(pi, $π$)
            plot.xtick(-pi, $-π$)
        })[Не подходит под теорему,\ следующий РФ $cancel(~)$ почленно\ проидфференцированному]
    ))
]

#task[
    #term[Задача]

    $ f(x) = x^2026 hhh x in [-pi, pi] $

    Оценить порядок убывания коэфф. Фурье.
]

#proof[
    В теореме о порядку убыв. коэфф. РФ. $m > 1$ мы не можем взять, т.к. $f'(pi) != f'(-pi)$,
    так что $a_k, b_k = o(1/k)$.
]

#task[
    #term[Задача]
    $ f(x) = (x^2 - pi^2)^3 $
    Также оценить порядок убывание коэфф. Фурье.
]
#proof[
    Будем дифференцировать и смотреть, нарушится ли условие из теоремы.

    1. Для $f$ условие теоремы верно.
    2. $f' = 6x(x^2 - pi^2)^2$. Условие верно.
    3. $f'' = 6(x^2 + pi^2)^2 + 24x^2 (x^2 - pi^2)$. Всё ещё подходит под условие.
    4. $f''' (pm pi) = 0 pm 48 pi^3$. Условие не работает.

    Итого, $a_k, b_k = o(1/k^3)$
]
