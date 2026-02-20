#import "../../../multibook/mb.typ": *
#import "../sym.typ": *
#show : mb.chapter(
    title: [Семинар 3: Матож и дисперсия],
    date: [17 февраля]
)

= Матож

#def[
    #term[Матожидание]

    1. $xi$ дискретная величина.\
        $ EE xi = sum k dot P(xi = k) $
    2. $xi$ абс. непрерывна.
        $ EE xi = int_RR x rho_xi (x) dd x $
    3. В общем
        $ EE xi = int_RR x dd F_xi (x) $
]

=== Примеры

==== Дискретные

#table(
    columns: (120pt, auto),
    stroke: 0.5pt + gray.lighten(50%),
    inset: 8pt,
    [*$xi ~ ?$*], [*$EE xi = ?$*],
    $Bern(p)$, $p dot 1 + (1-p) dot 0 = p$,
    $Bin(n, p)$, $display(xi =^d sum nu_i\, nu_i ~ Bern(p) ==> EE xi = n p)$,
    $Pois(lambda)$, $display(sum_(k=0)^oo k lambda^k/k! e^(-lambda) = lambda sum_(k=1)^oo lambda^(n-1)/(k-1)! e^(-lambda) = lambda)$,
    $Geom(p)$, $display(sum_(k=1)^oo k p (1-p)^(k-1) = 1/p hh "(см. доказ. ниже)")$,
)

#note[Очередное обозначение: $xi =^d eta$ -- величины равны по распределению]

#proof[
    *Вычисление $Geom(p)$*
    #todo[переписать оба способа]
]

==== Абс. непрерывные

/ $xi ~ U(a, b)$:
    $ int_RR x dot 1/(b-a) d1_[a, b] dx = (a + b)/2 $

/ $xi ~ N(a, sigma^2)$:
    $ rho_xi (x) = 1/sqrt(2 pi sigma^2) dot e^(-(x-a)^2/(2 sigma^2)) $
    $ => EE xi = int_RR x 1/sqrt(2 pi sigma^2) dot e^(-(x-a)^2/(2 sigma^2)) dx $
    Хитрый способ: подинтегральное симметрично отн. $a$.
    Другой способ: $xi =^d sigma eta + a, eta ~ N(0, 1)$, он 

/ $xi ~ exp(lambda)$:
    $ rho_xi (x) = lambda e^(-lambda x) d1(x > 0) $
    $ EE xi = int_0^(+oo) x lambda e^(-lambda x) dd x = 1/x $

Небольшие спойлеры к матану:

#def[
    #term[$Gamma$-функция]
    $ Gamma(s) = int_0^(+oo) t^(s-1) e^(-t) dd t\
        Gamma(1) = 1, Gamma(s+1) = s Gamma(s) => Gamma(n in NN) = (n-1)!\
        Gamma(1/2) = sqrt(pi) $
]
#def[
    #term[$Beta(alpha, beta)$]
    $ int_0^1 t^(alpha-1) (1-t)^(beta-1) dd t $
    $ Beta(alpha, beta) = (Gamma(alpha) Gamma(beta))/Gamma(alpha + beta) $
]

Продолжаем примеры.

/ $xi ~ Gamma(alpha, lambda)$:
    $ rho_xi (t) = (t^(alpha-1) lambda^alpha e^(-lambda t))/Gamma(alpha) dot d1_(t >= 0) $
    $ EE xi = int_0^(+oo) ((t^alpha) lambda^alpha)/Gamma(alpha) e^(lambda alpha) dd t = 1/lambda (Gamma(alpha+1))/(Gamma(alpha)) = alpha/lambda $


/ $xi ~ Cauchy (0, 1)$:
    $ EE xi = 1/pi int_RR x dot 1/(x^2 + 1) dx eq.not $
    У величины с распределением Коши матожа нет.

Есть и дискр. распределения без матожа. Например можно взять $P(xi = k) = 1/k^2 dot 6/pi^2$

= Дисперсия

#def[
    #term[Дисперсия]
    $ DD xi = EE(xi - EE xi)^2 = EE xi^2 - (EE xi)^2 $

    В дискретном случае:
    $ DD xi = sum P(xi = k) dot (k - EE xi)^2 $
]

Дисперсия существует не всегда (даже если есть матож), но если дисперсия есть, то матож
тоже обязан быть.

Например берём $P(xi = k) = 1/k^3 dot 6/pi^2$. Матож есть, дисперсии нет.

=== Считаем дисперсии

/ $xi ~ Bern(p)$:
    $ DD xi = p(1-p) $

/ $xi ~ Bin(n, p)$:
    $ DD xi = n p (1-p) $
    Доказываем либо по определению, либо через дисперсию суммы.

/ $xi ~ Pois(lambda)$:
    $ EE xi(xi - 1) = sum k(k-1) lambda^k/k! e^(-lambda) = lambda^2 ==> DD xi = lambda $

/ $xi ~ Geom(p)$:
    $ f'' (x) = sum k (k-1) x^(k-2) $
    #todo[расписать]

#task[
    #term[Лист 1, задача 8]

    Пусть $xi_1 ... xi_n$ -- независимые одинаково распределённые случайн. величины с
    функцией распр. $F(x)$ и плотностью $f(x)$.

    Упорядочим значения $ξ_1 ... ξ_n$ по неубыванию. Возникает новая
    последовательность случайных величин $ξ_((1)) ≤ ... ≤ ξ_((n))$
    (т.е. $ξ_((k))$ — $k$-я по порядку величина из $ξ_1 ... ξ_n$).
    Найдите:
    1. функцию распределения случайной величины $ξ_((k)), k = 1 ... n$.
    2. плотность случайной величины $ξ_((k)), k = 1 ... n$.
]

#proof[
    #let br(x) = $(#x)$
    $ 
        F_xi_br(k) (s) = P(xi_br(k) <= s) = P("хотя бы" k "из" xi_1 ... x_n <= s)\
        = sum_(i <= k)^n C_n^i F(s)^i (1 - F(s))^(n-i)
    $

    $
        rho_xi_br(k) (s) &= sum_(i=k)^n C_n^i rho(s) (i (F(s))^(i-1) (1 - F(s))^(n-i) - (n-i) (F(s))^i (1 - F(s))^(n-i-1))\
        &= C_n^k dot k dot rho(s) dot (F(s))^(k-1) (1 - F(s))^(n-k)\
        &= C_(n-1)^(k-1) dot n dot rho(s) dot (F(s))^(k-1) (1 - F(s))^(n-k)
    $
]


