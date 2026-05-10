#import "../../../multibook/mb.typ": *
#show : mb.chapter(
    title: [Семинар 11. Решаем задачи...],
    date: [14 апреля]
)

#task[
    #term[Задача Т1]

    Вычислить интегралы Лапласа:

    $ I(alpha) = int_0^(+oo) (cos alpha x)/(1 + x^2) dx hhh K(alpha) = int_0^(+oo) (x sin alpha x)/(1 + x^2) dx $
]

#proof[
    $ int_0^(+oo) (sin x)/x^alpha : cases(alpha > 1 - "сх. абс", 0 < alpha <= 1 - "сх. усл", alpha <= 0 - "расх") $

    Соответственно, подинтегральная функция в первом в $L_1(0, +oo)$, во втором нет.

    $I'(alpha) =^? -K(alpha)$ при $alpha > 0$?

    Хотим использовать Т2.2. По Дирехле, оценивая на каждом подотрезке $[alpha_1, alpha_2] sub (0, +oo)$:
    $ f(x, alpha) = sin alpha x hhh g(x, alpha) = x/(1 + x^2) $
    $ abs(int_0^x f(t, alpha) dt) = abs(-(cos x alpha - 1)/alpha) <= 2/alpha_1 $
    $g'(x, alpha) = (1 - x^2)/(1 + x^2)^2$, так что при $x > 1$ $g$ убывает к нулю при всех $alpha$.

    Разобъём изначальный интеграл на два:

    $ K(alpha) = ub(int_0^1 (x sin alpha x)/(1 + x^2) dx, <= x/(1 + x^2) " и Вейерштрасс")
    + ub(int_1^(+oo) (x sin alpha x)/(1 + x^2) dx, "По Дирехле") $

    Итого, Т2.2 работает.

    При $alpha > 0$:

    $ I'(alpha) + pi/2 = - int_(0)^(+oo) (x sin alpha x)/(1 + x^2) dx + int_0^(+oo) (sin alpha x)/x dx
        = int_0^(+oo) (sin alpha x)/x(1+x^2) dx
    $

    $ (I'(alpha) + pi/2)'_alpha =^? I(alpha) $

    Применяем Т2.
    $ abs((cos alpha x)/(1 + x^2)) <= 1/(1 + x^2) in L_1 (0, +oo) => "Т2 можно использовать" $
    Итого, $I'(alpha) = I''(alpha) => I(alpha) = C_1 e^alpha + C_2 e^(-alpha)$, $alpha > 0$.

    $ I(0) = int_0^(+oo) (dx)/(1+x^2) = pi/2 =^? C_1 + C_2 $
    Приравнять просто так нельзя, так как $alpha > 0$. Нужна непрерывность $I$ в нуле.
    Нужна Т1. Мажорируемость написаная выше для Т2 подойдёт, непрерывность есть.

    Заметим, что $abs(I(alpha)) <= int_0^(+oo) dx/(1 + x^2) = pi/2 forall alpha$ $=> C_1 = 0$.

    Тогда $I(alpha) = pi/2 e^(-abs(alpha))$, $K(alpha) = -I'(alpha) = pi/2 e^(-abs(alpha)) sign alpha $.

    Заеметим, что $K in.not L_1$, но интеграл есть, поскольку мы ищем несобственный интеграл по Риману.
]

#task[
    #term[Задача с прошлого семинара]

    $ int_0^(+oo) (cos alpha x - cos beta x)/x^2 alpha x = I(alpha, beta) $
]

#proof[
    На два интеграла не получится разбить, так как тогда интегралы будут расходиться из-за особенности в нуле
    А так при $x -> 0$ выражение стремится к $(beta^2 - alpha^2)/2$. 

    $ I'_alpha (alpha, beta) =^? int_0^(+oo) (sin alpha x)/x dx = -pi/2 "при" alpha > 0 $
    
    Применяем Т2.2 на всех подотрезках ${alpha_1, alpha_2] sub (0, +oo)$.
    $f(x, alpha) = sin alpha x$, $g(x, alpha) = 1/x$, признак Дирехле. Т2.2 работает, равенство есть.

    $I(alpha, beta) = -pi/2 alpha + C_1 (beta)$.

    Аналогично для $beta$. $I'_beta (alpha, beta) = pi/2 => I(alpha, beta) = pi/2 beta + C_2 (alpha)$.

    Соответственно:

    $ I(alpha, beta) = pi/2 (beta - alpha) + C hh alpha, beta > 0 $

    $I(alpha, alpha) = 0 = C$. Тогда $I(alpha, beta) = pi/2 (beta - alpha)$ при $alpha, beta > 0$.

    Что на осях? Нужна непрерывность. Зафиксируем $beta$, устремим $alpha$ к нулю, будем доказывать,
    что есть непрерывность по $alpha$ в нуле.

    Воспользуемся Т1 при $0 <= alpha <= 1$.

    $ I(alpha, beta) = ub(int_0^1, I_1) + ub(int_1^(+oo), I_2) $
    $ I_2 : abs((cos alpha x - cos beta x)/x^2) <= 2/x^2 in L_1 (1, +oo) $ 
    $ I_1 : abs((cos alpha x - cos beta x)/x^2) = 2 abs((sin (alpha + beta)/2 x sin (alpha - beta)/2 x)/x^2)
        <= abs(alpha^2 - beta^2)/2 <= (1 + beta^2)/2 in L_1 (0, 1)
    $

    Значит непрерывна, и тогда $I(0, beta) = pi/2 beta$. Аналогично $I(alpha, 0) = -pi/2 alpha$.

    Итого:

    $
        I(alpha, beta) = pi/2 (abs(beta) - abs(alpha))
    $
]

#task[
    #term[Задача 15.6.1]

    $ I(alpha, beta) = int_0^(+oo) (1 - cos alpha x)/x e^(-beta x) dx hhh beta > 0, alpha in RR $
]

#proof[
    $ I'_alpha (alpha, beta) =^? int_0^(+oo) sin alpha x e^(- beta x) dx $
    Равенство доказываем через Т2. $abs(sin alpha x e^(-beta x)) <= e^(-beta x) in L_1 (0, +oo)$. Равенство имеется.

    Считаем интеграл через комплексные.

    $  int_0^(+oo) e^(i alpha x) e^(- beta x) = int_0^(+oo) e^(x (i alpha - beta)) dx = 1/(beta - i alpha) = (beta + i alpha)/(alpha^2 + beta^2) $

    Соответственно $I'_alpha (alpha, beta) = alpha/(alpha^2 + beta^2)$.

    $ I(alpha, beta) = 1/2 ln(alpha^2 + beta^2) + C_1 (beta) $

    #sep

    $ I'_beta (alpha, beta) = int_0^(+oo) (cos alpha x - 1) e^(- beta x) dx $
    Снова используем Т2. Для любого отрезка $[beta_1, beta_2] sub (0, +oo)$: $abs(cos alpha x - 1) abs(e^(- beta x)) <= 2 e^(-beta_1 x) in L_1 (0, +oo)$.
    Соответственно функция дифф. на всём луче, равенство верно.

    $ I'_beta (alpha, beta) = int_0^(+oo) cos alpha x e^(-beta x) dx - int_0^(+oo) e^(-beta x) dx = beta/(alpha^2 + beta^2) - 1/beta $
    $ I(alpha, beta) = 1/2 ln(alpha^2 + beta^2) - ln(beta) + C_2 (alpha) $

    #sep

    Объединяем.

    $ I(alpha, beta) = 1/2 ln(alpha^2 + beta^2) - ln(beta) + C $

    Поскольку $I(0, beta) = 0$, то $C = 0$

    Итого:

    $ I(alpha, beta) = ln(sqrt(alpha^2 + beta^2)/beta) $
]

#task[
    #term[Задача 15.15.2]

    $ int_0^(+oo) (e^(-alpha x^2) - cos beta x)/x^2 dx hhh alpha > 0, beta in RR $
]
#proof[
    Вспомним, что 
    $ int_(-oo)^(+oo) e^(-x^2) dx = sqrt(pi) ==> int_0^(+oo) e^(-alpha x^2) dx = 1/2 sqrt(pi/alpha) $

    По частям:

    $
        = int (e^(- alpha x^2) - cos beta x) dd(-1/x) = with(-1/x (e^(- alpha x^2) - cos beta x))_0^(+oo)
        + int_0^(+oo) 1/x (-2 alpha x e^(- alpha x^2) + beta sin beta x) dx
    $
    Первое слагаемое зануляется, второе это интеграл вспомненный выше и интеграл Дирехле.
    $ = sqrt(pi alpha) + pi/2 abs(beta) $
]
