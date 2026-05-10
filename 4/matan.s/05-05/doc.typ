#import "../../../multibook/mb.typ": *
#import "../sym.typ": *
#show : mb.chapter(
    title: [Семинар 14.1. Преобразования Фурье, связь Фурье с производной],
    date: [5 мая]
)

= Преобразования Фурье

Пусть $f$ интегр. на всех $[a, b] sub RR$. Тогда *преобр. Фурье*
называется:

$ F[f](y) = 1/sqrt(2 pi) vpi f(x) e^(-i x y) dx $

Обратное это то же самое, но с обратным знаком при $i$:

$ F^(-1)[f](y) = 1/sqrt(2 pi) vpi f(x) e^(i x y) dx $

*Интеграл в смысле главного значения* это:

$ vpi g(x) dx = lim_(B -> +oo) int_(-B)^(B) g(x) dx $

Если $f in L_1 (RR)$, то $vpi = iii$, тогда $F[f], F^(-1) [f]$ непрерывные 
функции, стремящиеся к 0 на $pm oo$ (на лекции доказывалось).

Если $f in L_1 (RR)$, то *интегралом Фурье* $f$ называется $F^(-1) [F[f]]$.

Если в точке $x_0$ у $f$ есть конечные односторонние обобщённые производные $f$, то $F^(-1)[F[f]] = (f(x_0 + 0) + f(x_0 - 0)/2$

Если $forall x in RR exists f'_+ (x), f'_- (x) in RR$, то $F^(-1)[F[f]] = F[F^(-1)[f]] = f$.
(Производные не обобщённые!). Данное равенство называется *формулой обращения*.

#task[
    #term[Задача С3.17.6.2]

    Представить интегралом Фурье $d1_[-1, 1] (x)$.
]
#proof[
    $f in L_1$, $vp$ не нужно.

    $ F[f](y) = 1/sqrt(2pi) int_(-1)^1 e^(-i x y) dx = 2/sqrt(2 pi) int_0^1 cos (x y) dx = sqrt(2/pi) (sin y)/y $
    Получили функцию не в $L_1 (RR)$.

    $
        F^(-1)[F[f]](x) = 1/pi vpi (sin y)/y e^(i x y) dy \
        = 2/pi int_0^(+oo) (sin y dot cos x y)/y dy = cases(
            1 & -1 < x < 1,
            1/2 hhh & x = pm 1,
            0 & "иначе"
        )
    $
]

#task[
    #term[Задача Т2а]

    Вычислить преобразование Фурье функции $f(x) = e^(- alpha abs(x)), alpha > 0$
]
#note[
    Есть ещё одно обозначение преобразования Фурье, оно используется на лекциях:
    $ F[f](y) = hat(f)(y) hhh F^(-1)[f](y) = caron(f)(y) $
]
#proof[
    $ F[f](y) &= 1/sqrt(2pi) iii e^(-alpha abs(x)) dot e^(-i x y) dx = sqrt(2/pi) int_0^(+oo) e^(-alpha x) cos x y dx\
     &= Re sqrt(2/pi) int_0^(+oo) e^(-alpha x) e^(i x y) dx = Re sqrt(2/pi) int_0^(+oo) e^(x(-alpha + i y)) dx\
     &= Re sqrt(2/pi) -1/(i y - alpha) = sqrt(2/pi) dot alpha/(alpha^2 + y^2)

    $
]

#task[
    #term[Задача Т2б]

    Вычислить преобразование Фурье функции $f(x) = alpha/(alpha^2 + x^2)$, $alpha > 0$.
]
#proof[
    Заметим, что такую функцию получили в прошлом задании, и $F[f] = F[F[sqrt(pi/2) e^(- alpha abs(x))]]$.
    Также заметим, что если функция чётная, то $F$ и $F^(-1)$ совпадают.

    Так что:
    $ F[f] = F[F[sqrt(pi/2) e^(- alpha abs(x))]] = F[F^(-1)[sqrt(pi/2) e^(- alpha abs(x))]] = sqrt(pi/2) e^(-alpha abs(x)) $
    Последнее равенство в силу формулы обобщения, т.к. односторонние производные есть.

    #sep

    Без формулы обращения пришлось бы считать такое:
    
    $ F[alpha/(alpha^2 + y^2)] = 1/sqrt(2pi) iii (alpha cos (x y))/(alpha^2 + y^2) dy $
    Это интеграл Лапласа, который так просто не считается.
]

= Связь Фурье и производной

#def[
    #term[Теорема 1]

    Пусть $f$ непрерывна и $f, x f seq x^n f in L_1 (RR)$. Тогда
    существуют производные $(F[f](y))^((n))$, и они равны $F[(-i x)^n f](y)$.
]

Например, рассмотрим $n = 1$.

$
    (F[f](y))' = (1/sqrt(2 pi) iii f(x) e^(-i x y) dx)'_y = 1/sqrt(2 pi) iii (- i x) f(x) e^(- i x y) dx = F[(- i x) f](y)    
$

Чтобы результат существовал, нужно чтобы $abs(i x f(x) e^(-i x y)) <= abs(x f(x)) in L_1 (RR)$.

#def[
    #term[Теорема 2]

    Пусть $f^((n-1))$ кусочно гладкая на всех $[a, b] sub RR$, $f, f' seq f^((n)) in L_1 (RR)$. Тогда:

    $ hat(f^((n)) (x)) (y) = (i y)^n hat(f(x)) (y) $
]

Снова, при $n = 1$:

$ 1/sqrt(2 pi) iii f'(x)  e^(- i x y) dx = 1/sqrt(2 pi) with(f(x) e^(-i x y))_(-oo)^(+oo) + 1/sqrt(2 pi) iii i y f(x) e^(- i x y) dx
    = i y dot hat(f(x)) (y)
$

#sep

Вспомним задачу Т2.

$ x^n e^(-alpha abs(X)) in L_1 forall n in NN hh ==> hh alpha/(alpha^2 + x^2) in C^(oo) (RR) $
$ (alpha/(alpha^2 + x^2))^((n)) in L_1 (RR) hh ==>^"теорема 2" hh e^(-alpha abs(x)) = o(1/x^n) forall n $

#task[
    #term[С3.17.2]

    Вычислить $hat(f)(y)$, где $f(x) = e^(-x^2/2)$.
]
#proof[
    Можно было бы напрямую посчитать, но мы сделаем по другому.

    По теорема 2:
    $ hat(f')(y) = i y hat(f) $
    Заметим, что:
    $ hat(f')(y) = - hat(x f) (y) = 1/i hat(-i x f)(y) = -i (hat(f))' (y) $
    $ (hat(f))' = - y hat(f) ==> (dd hat(f))/(hat(f)) = y dy ==> ln hat(f) = -y^2/2 + tilde(C) ==> hat(f) = C e^(-y^2/2) $

    Поскольку функция чётная, то $hat(hat(f)) = e^(-x^2/2)$. С другой стороны это $C^2 e^(-x^2/2) => C = pm 1$.

    $ C = hat(f)(0) = 1/sqrt(2 pi) iii e^(-x^2/2) > 0 ==> C = 1 $

    В очередной раз посчитали интеграл Пуассона...

    Итого, $F[e^(-x^2/2)] = e^(-y^2/2)$
]

= Свёртки

#def[
    #term[Фурье от свёртки]
    $ hat(f * g) = sqrt(2 pi) dot hat(f) dot hat(g) hhh forall f, g in L_1 (RR) $
]

#note[
    $1/sqrt(2pi)$ в преобразовании Фурье пишут не всегда,
    иногда его убирают чтобы это равенство было, но тогда нет такого свойства
    у $e^(-y^2/2)$ и не работают некоторые теоремы, которые будут позже.
]

#proof[
    Докажем теорему выше.

    $ (f * g) (x) = int_RR f(x-t) g(t) dt in L_1 (RR) $

    #let zz = $з$
    #let tt = $tilde(t)$

    $ hat(f * g) (y) = 1/sqrt(2 pi) int_RR dx int_RR dt dot f(x-t) g(t) e^(- i x y)
        = 1/sqrt(2pi) int_(RR^2) dx dt f(x - t) g(t) e^(- i x y)\
        = vec(delim: "[", zz = x - t, tt = t, pd(zz, tt)/pd(x, t) = mat(1, -1; 0, 1), abs(J) = 1)
        = 1/sqrt(2 pi) int_(RR^2) dd zz dd tt f(zz) g(tt) e^(-i(zz + tt) y)
        = sqrt(2pi) hat(f) hat(g)
    $

    Переходы с кратного на повторный и обратно возможны по Фубини,
    для этого нужа конечность $int_(RR^2) dx dt abs(f(x-t) g(x)) = int_(RR^2) dd zz dd tt abs(f(zz)) abs(g(tt)) = norm(f)_1 norm(t)_1$

    _Для читающих не из группы: cтаранный выбор названий переменных -- результат коллективного разума группы, не удивляйтесь_
]
