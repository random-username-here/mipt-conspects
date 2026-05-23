#import "../../../multibook/mb.typ": *
#import "../sym.typ": *
#show : mb.chapter(
    title: [Семинар 5: Ещё практика перед КР],
    date: [10 марта]
)

#let bbxi = $bar(xi)$
#let bbeta = $bar(eta)$
#let bbx = $bar(x)$

Допустим мы имеем случайный вектор $bar(xi)$, знаем его распределение
$rho_bar(xi) (bar(x))$.

Тогда можем узнать распределение функции от него:

$ bar(eta) = phi(bbxi) rho_bbxi (phi^(-1) (bbx)) abs(J_(phi^(-1)) (bbx)) $

Собственно это было на прошлом семинаре.

#task[
    #term[Задача 1]
    $ xi, eta ~ U(0, 1) hhh xi eta ~ ? hhh xi / eta ~ ? $
]

#proof[
    *Способ 1*

    $ rho_(xi eta) (x) = int_RR 1/abs(t) rho_xi (1 / t) rho_eta (t) dt
        = int_RR 1/abs(t) d1(0 <= x/t <= 1) d1(0 <= t <= 1) dt\
        = int_RR 1/abs(t) d1(x >= 0) d1(x <= t) d1(t >= 0) d1(t <= 1) dt\
        = cases(
            x < 0 &: hh 0,
            x in (0, 1) &: hh int_x^1 1/t dt = - ln x,
            x > 1 &: hh 0
        )
    $

    И аналогично для $xi / eta$.

    *Способ 2*

    $
        phi : vec(x, y) --> vec(x y, x / y) hhh phi^(-1) : vec(sqrt(s t), sqrt(s/t)) <-- vec(s, t)
    $
    Обратное имеет проблемы со знаками, но поскольку $xi, eta > 0$, то без разницы.

    $
        rho_bbeta vec(s, t) = rho_bbxi (phi^(-1) vec(s, t)) abs(J_(phi^(-1)) vec(s, t))
    $
    Раскрываем, интегрируем по ненужной координате.
]

#task[
    #term[Задача 2]
    $ x indep y ~ exp(lambda) hhh u = x/(x+y), hh v = x + y, hh u indep^? v $
]
#proof[
    $
        phi : vec(x, y) --> vec(x/(x+y), x+y) hhh phi^(-1) : vec(s t, t - s t) <-- vec(s, t)
    $ 

    $ J_(phi^(-1)) vec(s, t) = mat(t, s; -t, 1 - s) ==> abs(J_(phi^(-1))) vec(s, t) = abs(t (1-s) + t s) = abs(t) $
    $
        rho_(phi(x, y)) vec(s, t) &= rho_(x,y) (phi^(-1) vec(s, t)) abs(J_(phi^(-1)) vec(s, t))\
        &= rho_x (s t) rho_y (t - s t) abs(t) \
        &= lambda^2 e^(-lambda(s t + t - s t)) d1(s t >= 0) d1(t - s t >= 0) abs(t)\
        &= lambda^2 e^(-lambda t) d1(t >= 0 and s >= 0 and 1 - s >= 0)\
        &= ub(lambda^2 t e^(- lambda t) d1(t >= 0), rho_v (t)) dot ub(d1(0 <= s <= 1), rho_u (s))
    $
    Получили, что совместное распределение это произведение двух
    распределений, значит независимы.
]
/*
#task[
    #term[Задача]

    $ xi_1 seq xi_n ~ U(0, 1) $
    $  $
]*/

#todo[Ещё две задачи]
