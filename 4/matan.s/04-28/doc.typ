#import "../../../multibook/mb.typ": *
#show : mb.chapter(
    title: [Семинар 13. Эйлеровы интегралы, начало преобразований Фурье],
    date: [28 апреля]
)

= Вспоминаем Фубини/Тонелли

Пусть есть измеримое $E sub RR^(n+m), f in L_1 (E)$ (т-ма Фубини) или $f >= 0$ (т-ма Тонелли). Тогда:

$ int_E f dd mu = int_(RR^n) dx int_(E_x) dy f = int_(RR^m) dy int_(E_y) dx f $

Следоавтельно $f in L_1 <=> exists$ и конечен один из:
$ int_(RR^n) dx int_(E_x) dy abs(f), int_(RR^m) int_E_y dx abs(f) $

#task[
    #term[Задача 15.12]

    $ int_0^(+oo) (e^(-a x) - e^(-b x))/x dx hhh a, b > 0 $
    (решать с помощью Фубини/Тонелли, не Фруллани)
]
#proof[
    Разбить на два интеграла нельзя, т.к. $e^(-a x)/x ~ 1/x$, что интеграл которого расходится.

    Заметим, что:
    $ e^(-a x) - e^(-b x) = with(e^(-t x))_a^b = -int_a^b x e^(-t x) dt $

    Соответственно:

    $
        int_0^(+oo) (e^(-a x) - e^(-b x))/x dx 
        = int_0^(+oo) dx int_a^b dt e^(-t x)
        =^"Тонелли" int_a^b dt int_0^(+oo) e^(-t x) dx =\
        = - int_a^b dt with(e^(-t x)/t)_0^(+oo) = int_a^b 1/t dt = ln b - ln a
    $
]

#task[
    #term[Интеграл Пуассона]
    $ int_0^(+oo) e^(-x^2) dx = I = ? $
]
#proof[
    В прошлом семестре решали через полярные координаты.

    В этот раз заменим $x = y t$, $y$ параметр.

    $ int_0^(+oo) y e^(-y^2 t^2) dt = I ==> e^(-y^2) int_0^(+oo) y e^(-y^2 t^2) dt = I e^(-y^2) $

    Проинтегрируем по $y$.

    $ int_0^(+oo) dy int_0^(+oo) dt dot y e^(-y^2 (t^2 + 1)) = I^2 $

    Слева снова неотрицательная функция, Тонелли.

    #let zz = $з$

    $ 
        int_0^(+oo) dy int_0^(+oo) dt dot y e^(-y^2 (t^2 + 1))
         =[з := t^2]= 1/2 int_0^(+oo) dt int_0^(+oo) dd zz e^(-zz (t^2 + 1)) = \
         = 1/2 int_0^(+oo) -with(e^(-zz (t^2 + 1))/(t^2 + 1))_0^(+oo) = 1/2 int_0^(+oo) dt 1/(t^2 + 1) = pi/4\
         ==> int_(-oo)^(+oo) e^(-x^2) dx = sqrt(pi)
    $
    _note: $dd zz$ не какая-то новая запись, это просто группа коллективно решила так назвать переменную_
]

= Эйлеровы интегралы

*Гамма-функция* -- это такая функция:

$
    Gamma(p) = int_0^(+oo) x^(p-1) e^(-x) dx hhh p > 0
$

*Бета-функция* -- это такая:

$
    Beta(p, q) = int_0^1 x^(p-1) (1-x)^(q-1) dx hhh p, q > 0
$

Бета-функция симметрична.

#sep

Свойства гамма-функции:
 - $Gamma(1) = 1$
 - $Gamma(p+1) = p Gamma(p) => Gamma(n) = (n-1)!$
 - $Gamma(p) Gamma(1-p) = pi/(sin pi p) hh "при" 0 < p < 1$\
   $=> (Gamma(1/2))^2 = pi => Gamma(1/2) = sqrt(pi)$, интеграл Пуассона.

Дифференцируема ли $Gamma(p)$?

При $p in [p_1, p_2] sub (0, +oo)$:
$ abs(x^(p - 1) ln x e^(-x)) <= max { x^(p_1 - 1), x^(p_2 - 1) } dot abs(ln x) e^(-x) in L_1 (RR) $

Значит $Gamma$ дифференцируема, и:
$ Gamma'(p) = int_0^(+oo) x^(p-1) ln x e^(-x) dx\
    Gamma''(p) = int_0^(+oo) x^(p-1) (ln x)^2 e^(-x) dx > 0
$

Получили, что $Gamma(p)$ выпукла вниз.

#sep

$ Beta(p, q) = (Gamma(p) Gamma(q))/(Gamma(p+q)) $

#task[
    #term[Задача 16.7.5]

    $ int_1^2 root(3, (2 - x)^2 (x-1)) dx = ? $
]
#proof[
    $ 
        int_1^2 root(3, (2 - x)^2 (x-1)) dx =[t := x-1]= int_0^1 (1-t)^(2/3) t^(1/3) dt =\
        = Beta(5/3, 4/3) = (Gamma(5/3) Gamma(4/3))/Gamma(3) = (2/3 Gamma(2/3) 1/3 Gamma(1/3))/2 =\
        = pi/(9 sin pi/3) = (2pi)/(9 sqrt(3))
    $
]

#task[
    #term[Задача 16.13.6]

    $
        int_0^(+oo) x^alpha/(a + b x^beta)^p dx = ? hhh "при" a, b, beta > 0, hh 0 < (alpha+1)/beta < p
    $
]
#proof[
    В нуле $f(x) ~ x^alpha -> alpha > -1$, в $+oo$ $f(x) ~ x^(alpha - beta p) -> alpha - beta p < -1$,
    оттуда и получили данные условия.

    $ 
        = 1/(a^p) int_0^(+oo) x^alpha/(1 - b/a x^beta)^p dx\
        = [t := 1/(1 + b/a x^beta) => x = root(beta, (1/t - 1)a/b) => dx = root(beta, a/b) 1/beta (1/t-1)^(1/beta-1) (-1/t^2) dt] =\
        = 1/(a^p) int_0^1 t^p (1/t - 1)^(alpha/beta) (a/b)^(alpha/beta) (a/b)^(1/beta) 1/beta (1/t-1)^(1/beta-1) (1/t^2) dt =\
        = 1/(beta a^p) (a/b)^((alpha+1)/beta) int_0^1 dt dot t^(p-2) (1/t - 1)^((alpha+1)/beta - 1) =\
        = 1/(beta a^p) (a/b)^((alpha+1)/beta) int_0^1 dt dot  t^(p-1-(alpha+1)/beta) (1-t)^((alpha+1)/beta - 1) =\
        = 1/(beta a^p) (a/b)^((alpha+1)/beta) Beta(p-(alpha+1)/beta, (alpha+1)/beta)
    $
]

= Интегралы Фурье и преобразования Фурье

== Интеграл в смысле главного значения

Пусть $f in L_1 ([-B, B]) forall B > 0$. *Интеграл в смысле главного значения* это:

#let vp = $"(v.p.)"$
#let iii = $int_(-oo)^(+oo)$
#let vpi = $vp iii$

$
    vp int_(-oo)^(+oo) f(x) dx = lim_(B -> +oo) int_(-beta)^beta f(x) dx
$

Например:

$
    vp int_(-oo)^(+oo) x dx = 0
$

Функцию можно разложить на чётную и нечётную как $f(x) = (f(x) + f(-x))/2 + (f(x) - f(-x))/2$.
Поскольку нечётная сокращается, то:

$
    vpi f(x) dx = vpi (f(x) + f(-x))/2 dx = int_0^(+oo) (f(x) + f(-x)) dx
$

== Преобразование Фурье

Есть $f in L_"loc"^1 (RR)$ (обозначим так $f in L_1 ([a, b]) forall [a, b] sub RR$).

Тогда преобразование Фурье:

$ F[f](y) = 1/sqrt(2 pi) vpi f(x) e^(-i x y) dx $

Обратное преобразование Фурье:

$ F^(-1) [f](y) = 1/sqrt(2 pi) vpi f(x) e^(i x y) dx $

Если $f in L_1 (RR)$, то можно не писать $vp$.

На лекции будет сказано, что если $f in L_1(RR)$, то $F[f], F^(-1)[f] ->_(y -> pm oo) 0$ и непрерывны.

== Интеграл Фурье

$f in L_1 (RR)$. Интегралом Фурье этой функции называется:
$ F^(-1)[F[f]](x) = 1/(2pi) vpi dy dot e^(i x y) iii dt dot e^(-i t y) f(t) $

Очень напоминает на ряд Фурье в комплексных, по сути интеграл Фурье это его непрерывное обобщение:

$ f ~ sum_(n in ZZ) c_n e^(i n x) hhh c_n = 1/(2pi) int_(-pi)^pi f(t) e^(-i t n) dt $

