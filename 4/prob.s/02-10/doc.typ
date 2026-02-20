#import "../../../multibook/mb.typ": *
#import "../sym.typ": *
#show : mb.chapter(
    title: [Семинар 2: Случайные величины],
    date: [10 февраля],
    msg: [Первого не было, семинарист 3-го отсутствовал]
)

#def[
    #term[Случайная величина]

    Имеем $Omega ->^xi RR$, $(Omega, cF, P)$.
    $forall B in cB(RR) : xi^(-1) (B) in cF$
]

#def[
    #term[Функция распределеня величины]
    $ F_xi (x) = P(xi <= x) = P ({omega | xi^(-1) (omega) in (-oo, x]}) $
]

Имеет свойства:
 1. Непр. справа
 2. Неубывает
 3. $limxoon F_xi (x) = 0$, $limxoop F_xi (x) = 1$

Если имеем функцию, удовлетворяющая таким свойствам, то она распределение
некой случайной величины.

Случайные величины бывают:

#def[#term[Дискретные случайные величины] -- $exists X$ - конечное множество, $P(X) = 1$]

Бывают:

#table(
    columns: 4,
    stroke: 0.5pt + gray.lighten(50%),
    inset: 7pt,
    [*Название*],
        [*$ xi ~ ??? $*],
        [*$ X = ? $*],
        [*$ P = ? $*],
    [Бернулли\ _(монетка)_],
        [$Bern(p)$],
        [${0,1}$],
        [$P({1}) = p$\ $P({0}) = 1 - p $],
    [Дискр. равномерное\ _(кубик)_],
        [],
        ${0 ... n}$,
        $P({k}) = 1/n$,
    [Биноминальное\ _(сумма монеток)_],
        [$Bin(n, p)$],
        [${ 0 ... n }$],
        [$P({k}) = C_n^k p^k (1-p)^(n-k)$],
    [Пуассоновское\ _(редкие события)_],
        [$Pois(λ), λ > 0$],
        [$ZZ_+$],
        [$P({k}) = λ^k/k! e^(-λ)$],
    [Геометрическое\ _(количество бросков до орла в бернулли)_],
        [$Geom(p)$],
        $NN$,
        $P({k}) = p (1 - p)^(k-1)$
)

#sep

#def[
    #term[Абс. непрерывные случайные величины]
    -- $exists rho(t) : P(xi in B) = int_B rho(t) dd mu$
]

Тогда $F_xi = int_(-oo)^x rho(t) dd t$. $F'_xi (x) = rho(x)$ там где $F_xi$ непрерывна.

Бывают:

#table(
    columns: 4,
    stroke: 0.5pt + gray.lighten(50%),
    inset: 7pt,
    [*Название*],
        [*$ xi ~ ??? $*],
        [*$ rho_xi (t) = ? $*],
        [*$ F_xi (x) = ? $*],
    [Равномерное на отрезке],
        $ U(a, b) $,
        $ 1/(b-a) d1_[a, b] $,
        $$,
    [Нормальное],
        $ N(a, sigma^2) $,
        $ 1/sqrt(2 pi sigma^2) e^(-(x-a)^2/(2 sigma^2)) $,
        $$,
    [Стандартное нормальное распределение],
        $ N(0, 1) $,
        $ 1/sqrt(2 pi) e^(-x^2/2) $,
        $$,
    [Экспоненциальное],
        $ exp(lambda) $,
        $ lambda e^(- lambda x) d1_[0, +oo) $,
        $ (1 - e^(- lambda x)) d1_(0, +oo) $,
    [Гамма-распределение#footnote[$Gamma(alpha) = int_0^(+oo) t^(alpha-1) e^(-t) dd t$]],
        $ Gamma(alpha, lambda) $,
        $ (t^(alpha-1) lambda^alpha e^(-lambda t))/Gamma(alpha) d1_[0, +oo) $,
        $$,
    [Бета-распределение],
        $ B(alpha, beta) $,
        $ (t^(alpha-1) (1-t)^(beta-1))/B(alpha, beta) d1_[0, 1] $,
        $$,
    [Распределение Коши],
        $ Couchy(x_0, theta) $,
        $ 1/pi (theta)/(1 + (x - x_0)^2/theta^2) $,
        $$,
    [Стандартное расп. Коши],
        $ Couchy(0,1) $,
        $ 1/(pi (1 + x^2)) $,
        $ 1/pi arctan x $
)

#task[
    #term[Задача 5]

    Случайная величина $ξ$ принимает значения в интервале $(a, b)$ и имеет 
    плотность $f(x)$. Функция $ϕ(x)$ строго монотонна и дифференцируема на
    $(a, b)$, причем $ϕ'(x) != 0$ на $(a, b)$. Вычислите плотность случайной
    величины $η = ϕ(ξ)$.
]

#proof[
    Если $phi$ возрастает:

    $ F_(phi(xi)) (x) = P(phi(xi) <= x) = P(xi <= phi^(-1) (x)) = F_xi (phi^(-1)(x)) $
    $ rho_phi(xi) (x) = F'_phi(xi) = rho_xi (phi^(-1)(x)) dot (phi^(-1))' (x)
        = (rho_xi (phi^(-1) (x))) / (phi'(phi^(-1) (x))) $

    Если убывает:


    $ F_(phi(xi)) (x) = P(phi(xi) <= x) = P(xi >= phi^(-1) (x)) = 1 - F_xi (phi^(-1)(x)) $
    $ rho_phi(xi) (x) = - rho_xi (phi^(-1)(x)) dot (phi^(-1))' (x) $

    В общем, для любых случаев:

    $ rho_phi(xi) (x) = rho_xi (phi^(-1)(x)) dot abs((phi^(-1))' (x)) $
]

#task[
    #term[Задача 2(a)]

    Случайная величина $ξ$ имеет стандартное распределение Коши,
    т.е. плотность $ξ$ равна

    $ rho_xi (x) = 1/(π(1 + x^2)) hhh  x ∈ RR $

    Найти плотность распределения: $(xi^2)/(1 + xi^2)$
]

#proof[
    Сразу заметим, что $phi(x)$ не монтонна.

    #canvas(length: 3cm, {
        let f = x => (x * x)/(1 + x * x)
        plot.func(f, -2, 2, c: orange)
        plot.axes(-2, 0, 2, 1)
        plot.xperp(-1, f(-1), $-h(x)$)
        plot.xperp(1, f(1), $h(x)$)
        plot.yperp(-1, f(-1), $$)
        plot.yperp(1, f(1), $$)
        draw.content((0.1, 0.6))[$x$]
        draw.content((0.7, 0.9))[$ h(x) = sqrt(x/(1 - x)) $]
    })

    $
        F_phi(xi) (x) &= P(xi^2/(1 + xi^2) <= x) = P(xi in [-h(x), h(x)])\
        &= F_xi (h(x)) - F_xi (-h(x)) = 2 F_xi (h(x)) - 1\
        &= 2 (1/2 + 1/pi arctan(sqrt(x/(1-x)))) - 1\
        &= 2/pi arctan sqrt(x/(1-x))
    $

    $
        rho_phi(xi) = F'_phi(xi) = ...
    $
]

#task[
    #term[Задача 1]

    Случайная величина $ξ$ имеет стандартное нормальное распределение $N(0, 1)$.
    Найдите плотность случайной величины $ξ^2$.
]

#proof[
    При $x > 0$:
    $
        F_(xi^2) (x) = P(xi^2 <= x)
        = F_xi (sqrt(x) - F_xi (-sqrt(x))
        = 2 F_xi (sqrt(x)) - 1
    $
    $
        rho_(xi^2) (x) = 2 rho_xi (sqrt(x)) dot 1/(2 sqrt(x)) = (rho_xi (sqrt(x)))/sqrt(x)\
        = 1/sqrt(2 pi) 1/sqrt(lambda) e^(-x/2)
    $

    В случае $x <= 0$ $rho_(xi^2) (x) = 0$.

    Заметим, что $xi^2 ~ Gamma(1/2, 1/2)$.
]

#task[
    #term[Задача 3]

    Случайные величины $ξ$ и $η$ независимы. Пусть $F_ξ (x)$ и $F_η (x)$ -- их
    функции распределения. Положим $ζ_1 = max(ξ, η)$, $ζ_2 = min(ξ, η)$.
    Вычислите функции распределения случайных величин $ζ_1$ и $ζ_2$.
]

#proof[
    Велчины независимы, если:

    $ xi indep nu <==> forall A, B in cB(RR) : P(xi in A and nu in B) = P(xi in A) dot P(nu in B) $

    #sep

    $ F_max(xi, eta) (x) = P(max(xi, eta) <= x) &= P(xi <= x and nu <= x) = F_xi(x) F_eta(x) \
      F_min(xi, eta) (x) = P(min(xi, eta) <= x) &= P(xi <= x or nu <= x)\
        &= P(not(not(xi <= x) and not(nu <= x)) \
        &= 1 - (1 - F_xi(x)) (1 - F_eta(x)) $
]


