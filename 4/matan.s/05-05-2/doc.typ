#import "../../../multibook/mb.typ": *
#import "../sym.typ": *
#show : mb.chapter(
    title: [Семинар 14.2. Пространства $S$],
    msg: [Второй семинар в тот же день, чтобы компенсировать пропущенное],
    date: [5 мая]
)

= $S(RR)$ и его свойства

*Пространство быстроубывающих функций*, aka пространство Шварца $S(RR)$
такое пространство, что:

$ f in S(RR) hh <==> hh f in C^oo (RR) " и " forall K, n in NN_0 : x^K f^((n)) (x) ->^(x -> pm oo) 0 $

В нём имеются ноль, $e^(-x^2)$, функция "шапочка":

$ phi(x) = cases(e^(-a^2/(a^2 - x^2)) hh x in (-a, a), 0 hh "иначе") $

#canvas({
    let fa(a) = {
        plot.func(x => if -a < x and x < a { calc.exp(- a * a / (a * a - x * x)) * 4 } else { 0 }, -4, 4, c: blue)
    }
    fa(2)
    plot.xtick(2, $a$)
    plot.xtick(-2, $-a$)
    plot.axes(-4, 0, 4, 2)
})["Шапочка"]

#def[
    #term[$S$ содержится в $L_p$]

    $S(R) sub L_p (RR) forall p >= 1$
]

#proof[
    Пусть $exists M forall x in RR : abs((1 + x^2) f(x)) <= M$.
    $=> f(x) <= M/(1 + x^2) in L_p (RR) forall p >= 1$.
]

#def[
    #term[Дополнение $S$ это $L_p$]

    $bar(S(RR)) = L_p (RR) forall 1 <= p < oo$
]

#def[
    #term[$S$ замкнуто относитльн сложения, вычитания, умножения]

    $f, g in S(RR) => f + g, f - g, f g in S(RR)$
]

#def[
    #term[В $S(RR)$ определяется сходимость].

    Пусть ${f_n}_(n=1)^oo sub S(RR), f in S(RR)$.
    $ f_n ->^S f hh <==>^"def" hh forall K, m in NN_0 : x^K f_n^((m)) arrows_RR x^k f^((m)) (x) $
]
Это определение сходимости, как можно увидеть, достаточно "строгое".

Например, рассмотрим $f_n = 1/n e^(-(x-n)^2)$. Поточечно $f_n -> 0$.

Рассмотрим $x_n = n, k = 1, m = 0$. $f_n(x_n) = n 1/n e^0 cancel(->) 0$,
сходимости в $S(RR)$ нет.

#task[
    #term[Задача Т8]

    Для каких $f in S(RR)$ сходится в $S(RR)$ функция $f_n (x) = 2^(-n) f(x/n)$?
]

#proof[
    Поточечно сходится к нулю. Значит и в $S(RR)$ сходиться может
    только к нулю.

    $ 
        f in S(RR) ==> exists M > 0 forall y in RR abs(y^k f^((m)) (y)) <= M\
        abs(x^k 2^(-n) 1/n^m f^((m))(x/n)) = abs((x/n)^k f^((m)) (x/n) 2^(-n) 1/n^(m-k)) <= M n^(k-m)/2^n ->_(n->oo) 0
    $
]

= Связь $S(RR)$ с преобразованием Фурье

Чем $S(RR)$ удобно -- в нём очень хорошо чуствуют себя преобразования Фурье.

#def[
    #term[Теорема с лекции]

    Преобр. Фурье -- это непрерывная линейная биекция на $S$.

    (непрерывность -- то есть если $f_n ->^S f$, то $F[f_n] ->^S F[f]$).
]

Поскольку все в $S$ в $L_1$, то #vp в преобр. Фурье на $S$ не нужно,
поскольку производные есть, то формула обращения всегда работает.


#def[
    #term[Равенство Планшареля]

    $ (hat(f), hat(g))_(L_2) = (f, g)_(L_2) forall f, g in S(RR) $

    В $L_2$ скалярное произведение определено как:
    $ (f, g)_(L_2) = int_RR f(x) g(x) dx $
]

_Для тех, кто забыл: $hat(f)$ и $F[f]$ это два обозначения одного и того же._

#task[
    #term[Задача]

    Доказать, что в $S(RR)$: $F^2[phi](x) = phi(-x)$
]

#proof[
    $ phi(x) = (phi(x) + phi(-x))/2 + (phi(x) - phi(-x))/2 = phi_"ч" + phi_"н" $

    $ F^2 phi = F^2 phi_"ч" + F^2 phi_"н" = ... $
    Так как функция $phi_"ч"$ чётная, то $F^2 phi_"ч" = (F compose F^(-1)) phi_"ч" = phi_"ч"$, так как в интеграле можно знак при $e$ поменять, и ничего не изменится.

    $ F phi_"н" = 1/sqrt(2pi) int_RR phi_"н"(t) e^(- i t x) dt = - 1/sqrt(2pi) phi_"н" (t) e^(i t x) dt = - F^(-1) phi_"н" $
    $ ... = phi_"ч" (x) - phi_"н" (x) = phi(-x) $
]

Собственные значения преобразования Фурье: $pm 1, pm i$, $e^(-x^2/2)$.

#task[
    #term[Задача Т7]

    Пусть:
    $ f in S(RR) hhh int_RR abs(f)^2 dx = 1 hhh supp hat(f) sub [-1, 1] $

    Доказать, что:
    $ forall x, y in RR : abs(f(x) - f(y)) <= 1/sqrt(pi) abs(x - y) $
]
#proof[
    Докажем, что $forall x in RR abs(f'(x)) <= 1/sqrt(pi)$.

    $ F[f'] = i y F[f] ==> f'(x) = F^(-1)[i y F[f]] = 1/sqrt(2pi) int_RR i y hat(f)(y) e^(i x y) dy
        = 1/sqrt(2pi) int_(-1)^1 i y hat(f)(y) e^(i x y) dy
    $

    $
        abs(f'(x)) = abs(1/sqrt(2pi) int_(-1)^1 i y hat(f)(y) e^(i x y) dy)
        <= 1/sqrt(2pi) int_(-1)^1 abs(y) abs(hat(f)(y)) dy\
        <=_"КБШ" 1/sqrt(2 pi) (int_1^(-1) y^2 dy)^(1/2) (int_(-1)^1 abs(hat(f)(y))^2 dy)^(1/2) = 1/sqrt(2pi) sqrt(2/3) dot 1 = 1/sqrt(3 pi) <= 1/sqrt(pi)
    $
    Второй интеграл посчитали через равенство Планшареля.
]

=== Лирическое отступление: Зачем вообще нужно это ваше $S(RR)$?

Есть $delta$-функция Дирака. Она такая, что:

$ int_RR f(x) delta(x) dx = f(0) $

Она существует в $S'$, которое выводится из $S$. Затем в $S'$ будет обобщение
производной, такое что, например, $(sign x)' = 2 delta(x)$.

Будет всё это в следующем году. Так что этот раздел -- это "заготовка" на будующее,
явного применения для него прямо сейчас нет.

#task[
    #term[Задача Т9]

    Пусть $f in S(RR)$ и $hat(f) = 0$ на $RR \\ [-pi, pi]$.
    Доказать, что:
    $ forall x in RR : f(x) = sum_(k in ZZ) f(k) sin(pi(x-k))/pi(x-k) $
]
#proof[
    $hat(f) (pm pi) = 0$. Тогда ряд Фурье $hat(f)$ сходится к ней равномерно.

    $ hat(f)(y) = sum_(k in ZZ) c_k e^(i k y) hhh c_k = 1/(2 pi) int_(-pi)^pi hat(f)(x) e^(- i k x) dx f(k)/sqrt(2 pi) ==> hat(f)(y) = 1/sqrt(2pi) sum_(k in ZZ) f(k) e^(- i k y) $
    $ 
        f(x) = 1/sqrt(2 pi) int_(-pi)^pi hat(f)(y) e^(i x y) dy = 1/sqrt(2 pi) int_(-pi)^pi sum_k f(k) e^(- i k y) e^(i x y) dy\
        = 1/(2 pi) sum_k f(k) int_(-pi)^pi dy e^(i y(x - k)) = 1/pi sum_(k in ZZ) f(k) int_0^pi cos(y(x-k)) dy\
        = sum_(k in ZZ) f(k) sin(pi(x-k))/pi(x-k)
    $

    Переставить местами сумму и интеграл можно было, т.к. сумму сверху можно ограничить $sum_(k in ZZ) abs(f(k))$, которая конечная, так как $f in S$.
]

