#import "../../../multibook/mb.typ": *
#import "../sym.typ": *
#show : mb.chapter(
    title: [Семинар 4: Совместные распределения],
    date: [24 февраля]
)

#let sq = $#h(0.3em) ... #h(0.3em)$

= Совместные функции распределения и плотности

#def[
    #term[Совместная функция распределения]

    Имеем случайные величины $xi_1 ... xi_n$ (или случайный вектор $bar(xi)$, это то же самое).

    Тогда совместная функция распределения это:

    $ F_bar(xi) = F_(xi_1 sq xi_n) (x_1 sq x_n) = P (xi_1 <= x_1 and xi_2 <= x_2 and sq and xi_n <= x_n) $
]

Она:

 1. Непрерывна справа
 2. Неубывающая:
    $ Δ_i f = f(sq x'_i sq) - f(sq x_i sq)$\
    $ 0 <= Δ_1 Δ_2 sq Δ_n F = P(forall i :x_i <= xi <= x'_i)$
 3. $forall i : x_i -> +oo ==> lim F = 1$\
    $exists i : x_i -> -oo ==> lim F = 0$

Если имеем функцию, которая соотв. этим свойствам, то существует такие величины,
что у них такая совместная функция распределения.

#def[
    #term[Совм. ф. распределения независимых]
    
    Допустим, у нас есть независимые величины: $xi_1 indep xi_2 indep sq indep xi_n$. Тогда:

    $ F_bar(xi) = prod_(i=1)^n F_(xi_i) (x_i) $

    В обратную сторону тоже верно: если у величин такая совм. функция распределения, то
    величины независимы.
]

Рассмотрим $F(x, y) = d1(x + y >= 0)$.

Она удвлетворяет первым двум условиям, но ломается на третьем.

#def[
    #term[Совместная плотность]
    
    Аналогично совм. функции распределения: совместная плотность $rho_(xi_1 sq xi_n) = rho_bar(xi) (bar(t))$

    $ P(xi in B = int_B rho_bar(xi) bar(t) dd bar(t) =>
        rho_bar(xi) (bar(x)) = (pd^n F_bar(xi))/(pd x_1 sq pd x_n) $
]

= Формулы свёртки

Посчитаем плотность суммы величин:

$ F_(xi + eta) = P(xi + eta <= x) = int_(s + t <= x) rho_(xi,eta) (s, t) dd s dd t
    = int_RR int_(-oo)^(x-t) rho_(xi, eta) (s, t) dd s dd t\
    => int_RR rho_(xi, eta) (x - t, t) dd t = rho_(xi + eta) (x) $

Если они независимы:

$ xi indep eta
    ==> rho_(xi + eta) (x) = int_RR rho_xi (t) rho_eta (x-t) dt $

Аналогично с разностью:

$ rho_(xi - eta) (x) = int_RR rho_(xi,eta) (t, t - x) dt = int_RR rho(xi, eta) (x + t, t) dt $

#sep

В общем случае, если $phi$ диффеоморфизм:

$ rho_(phi(bar(xi))) (bar(x)) = rho_bar(xi) (phi^(-1) (bar(x))) abs(J_(phi^(-1))) $

И тогда плотность суммы считается через $vec(xi, eta) ->^phi vec(xi + eta, eta) => vec(s-t, t) <-^(phi^(-1)) vec(s, t)$,
и $ rho_phi(vec(xi, eta)) (s, t) = rho_(vec(xi, eta)) vec(s-t, t) abs(J_(phi^(-1))) $
$ rho_xi (x) = int_RR rho_(xi, eta) (x, y) dy $

#sep

Теперь посчитаем плотность произведения.

$ rho_(xi dot eta) (x) = ? $

$ vec(xi, eta) ->^phi vec(xi eta, eta) hhh vec(s/t, t) <-^(phi^(-1)) vec(s, t) $
$ J_(phi^(-1)) = mat(1/t, -s/t^2; 0, 1) ==> abs(J) = 1/t $
$ rho_vec(xi eta, eta) vec(s, t) = rho(xi, eta) vec(s/t, t) abs(1/t) $
$ rho_(xi eta) (s) = int_RR rho_(xi, eta) (s/t, t) 1/abs(t) dt $

Ну и деление:

$ rho_(xi/eta) (s) = int rho_(xi, eta) (s t, t) abs(t) dt $

#task[
    #term[Задача 3.1]

    $ xi_1 indep xi_2 hhh xi_1, xi_2 ~ U(0, 1) hhh rho_(xi_1 + xi_2) (x) = ? $
]
#proof[
    Просто подставляем в формулу.

    $ rho_(xi_1 + xi_2) (x) = int_RR rho_(xi_1) (t) rho_xi_2 (x-t) dt = ... $
    $ rho_xi_1 = d1_[0, 1] ==> ... = int_RR d1_(0 <= t <= 1) dot d1_(0 <= x-t <= 1) dt
     = int_RR d1_(x-1 <= t <= x) $
    
    Аналогично с разностью.

    #align(center, stack(dir: ltr, canvas(length: 1.5cm, {
        plot.axes(-0.5, 0, 2.5, 2, yl: none)
        let f(x) = calc.max(0, 1 - calc.abs(x - 1))
        plot.func(f, -0.5, 2.5, c: orange)
        plot.xperp(1, 1)
        plot.yperp(1, 1)
        plot.xtick(2)
        draw.content((1.7, 1))[$rho_(xi_1 + xi_2) (x)$]
     })[Плотность суммы], h(2em),
    canvas(length: 1.5cm, {
        plot.axes(-1.5, 0, 1.5, 2, yl: none)
        let f(x) = calc.max(0, 1 - calc.abs(x))
        plot.func(f, -1.5, 1.5, c: orange)
        plot.xtick(1)
        plot.xtick(-1)
        plot.ytick(1)
        draw.content((0.7, 1))[$rho_(xi_1 - xi_2) (x)$]
     })[Плотность разности]))
]

#task[
    #term[Задача]

    Имеем независимые $xi_1$ и $xi_2$.
    $ xi_1 ~ Pois(lambda_1) hhh xi_2 ~ Pois(lambda_2) hhh xi_1 + xi_2 ~ op(?) $
    
]

#proof[
    $ 
        P(xi_1 + xi_2 = k) = sum_(s=0)^oo P(xi_1 = s) P(xi_2 = k - s)
        = sum_(s=0)^oo lambda_1^s/s! e^(-lambda_1) lambda_2^(k-s)/(k-s)! e^(-lambda_2) dot d1_(s in ZZ_+) d1_(k - s in ZZ_+)\ 
        = sum_(s=0)^k (lambda_1^s lambda_2^(k-s))/(s! (k-s)!) e^(-lambda_1 - lambda_2)  = (lambda_1 + lambda_2)^k/k! e^(-lambda_1 - lambda_2)        
    $

    Итого, получили что $xi_1 + xi_2 ~ Pois(lambda_1 + lambda_2)$.
]

#task[
    #term[Задача]

    $ xi_1 perp xi_2, xi_1, xi_2 ~ exp(lambda) hhh rho_(xi_1 + xi_2) (x) = ? $
]
#proof[
    Считаем.
    $ rho_(xi_1 + xi_2) (x) = lambda^2 x e^(- lambda x) d1_(x >= 0) ==> xi_1 + xi_2 ~ Gamma(2, lambda) $
    На самом деле $exp(lambda) = Gamma(1, lambda)$.

    В общем случае $xi_1 ~ Gamma(alpha, lambda), xi_2 ~ Gamma(beta, lambda) ==> xi_1 + xi_2 ~ Gamma(alpha + beta, lambda)$
]

#task[
    #term[Задача]

    $ xi_1 ~ N(a_1, sigma_1^2), xi_2 ~ N(a_2, sigma_2^2) hhh xi_1 + xi_2 ~ ?? $
]
#proof[
    Догадываемся, что:
    $ xi_1 + xi_2 ~ N(a_1 + a_2, sigma_1^2 + sigma_2^2) $

    Доказываем, что распределение нормальное.

    $ rho_(xi_1 + xi_2) (x) 
        = int_RR 1/sqrt(2 pi sigma_1^2) 1/sqrt(2 pi sigma_2^2) e^(-(t-a_1)^2/sigma_1^2 - (x-t-a_2)^2/sigma_2^2) dt = ...
    $

    Заметим, что у нас интеграл вида 
    $ e^(-a t^2 + b t + c) dt = int_RR e^(-a(t-alpha)^2 + c) dt $

    Подгоним коэфф. $alpha$, интеграл сократится, и получим, что
    $ ... = 1/sqrt(2pi (omega_1^2 + omega_2^2)) e^(-(x-a_1-a_2)^2/(2sigma_1^2 + 2 sigma_2^2)) $
]
