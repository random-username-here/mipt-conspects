#import "../../../multibook/mb.typ": *
#show : mb.chapter(
    title: [Семинар 9. Интегралы, зависящие от параметра],
    date: [31 марта]
)

Имеем какой-то такой интеграл:
$ I(alpha) = int_X f(x, alpha) dx $

Наша цель -- понять их свойства (когда $I$ непрерывная/дифференцируемая) и научиться их считать.

= Непрерывность

#def[
    #term[Теорема 1]

    Пусть $X sub RR^n$ измеримое, будем по нему интегрировать. $A sub RR$ -- промежуток, на нём $alpha$.
    Имеем $f : X xx A -> RR$. $forall alpha: f(x, alpha)$ интегрируема на $X$.
    $ I(alpha) = int_X f(x, alpha) dx $

    Пусть $f$ непрерывна по $alpha$ для почти всех $x$. Пусть также 
    $ exists Phi in L_1 (X) forall x in X forall alpha in A : abs(f(x, alpha)) <= Phi(x) $
    Тогда $I(alpha)$ непрерывная на $A$ функция. Из этого следует, что $lim_(alpha -> ...) int f = int lim_(alpha -> ...) f$.
]

Рассмотрим $X = [bar(C), bar(D)]$. Если $f$ непрерывна на компакте $[bar(C), bar(D)] xx [c, d]$, то $I(alpha)$ непрерывна.
(так как она непрерывна на компакте $=>$ она ограничена $=>$ $Phi = max_(x in X) abs(f(x))$.

Теперь рассмотрим вместо $[c, d]$ какой-то промежуток $(a, b)$, возможно не ограниченный. 
$I(alpha)$ также непрерывна, так как $forall alpha exists [c, d] in.rev alpha$.

#task[
    #term[Задача 13.22]

    $ lim_(alpha -> 0) int_0^1 sqrt(x^2 + alpha^2) dx $
]
#proof[
    $sqrt(x^2 + alpha^2) in C([-1, 1]^2)$. 
    Условие теоремы выполнено, можно переставить интеграл с пределом.
    $ ... = int_(-1)^1 lim_(alpha -> 0) sqrt(x^2 + alpha^2) dx = int_(-1)^1 abs(x) dx = 1 $
]

#task[
    #term[Задача 13.4]

    $f in C[0, 1], f > 0$. Доказать, что следующая функция разрывна в $alpha = 0$.
    $ I(alpha) = int_0^1 alpha/(x^2 + alpha^2) f(x) dx $
]
#proof[
    Докажем, что $alpha/(alpha^2 + x^2) f(x)$ не непрерывна в $(0, 0)$.
    $
        (x, alpha) = (t, t)
        hh ==> hh alpha/(alpha^2 + x^2) f(x) = (t f(t))/(2 t^2) = f(t)/(2t) ->_(t -> +0) +oo
    $

    $$
    При $alpha > 0$:
    $ exists m forall x in [0, 1] : f(x) >= m hh ==> hh I(alpha) >= m int_0^1 (alpha dx)/(alpha^2 + x^2) = m alpha dot 1/alpha with(arctan x/alpha)_0^1 ->^(alpha -> +0) (pi m)/2 $
    Однако $I(0) = 0$. Непрерывности нет.
]

= Дифференцируемость

#def[
    #term[Теорема 2]

    Пусть $X sub RR^n$ измеримое, будем по нему интегрировать. $A sub RR$ -- промежуток, на нём $alpha$.
    Имеем $f : X xx A -> RR$. $forall alpha: f(x, alpha)$ интегрируема на $X$.
    $ I(alpha) = int_X f(x, alpha) dx $

    _(Условие выше дублируется из теоремы 1)_
    
    Пусть $f(x, alpha)$ дифференцируема на $A$ для всех $x$. 
    $ exists Phi in L_1 (X) forall alpha in A forall x in X : abs(f'_alpha (x, alpha)) <= Phi(x) $
    
    Тогда $exists I'(alpha) = int_X f'_alpha (x, alpha) dx$, и $pd/(pd alpha) int f = int pd/(pd alpha) f$
]

Если $f'_alpha (x, alpha)$ непрерывна на $[bar(C), bar(D)] xx (a, b)$, где $a, b in bar(RR)$,
то $I(alpha)$ дифф. на $(a, b)$. Доказывается аналогично похожему утверждению для непрерывности.

#task[
    #term[Задача 13.18.2]

    Посчитать:
    $ I(alpha) = int_0^pi ln(1 - 2 alpha cos x + alpha^2) dx hhh "при" abs(alpha) < 1 $
]

#proof[
    $ f(x, alpha) := ln (1 - 2 alpha cos x + alpha^2) = ln((1 - alpha cos x)^2 + alpha^2 sin^2 x) $

    Аргумент логарифма зануляется в $(alpha, x) in {(1, 0), (-1, pi)}$.
    $ f'_alpha (x, alpha) = (2 alpha -  2 cos x)/(1 - 2 alpha cos x + alpha^2) $
    Эта функция непрерывна на $[0, pi] xx (-1, 1)$. *Значит по теореме $I(alpha)$ дифференцируема*, чем и воспользуемся.

    $ I'(alpha) &
        = int_0^pi (2 alpha -  2 cos x)/(1 - 2 alpha cos x + alpha^2) dx
        = int_0^pi ((1 - 2 alpha cos x + alpha^2) 1/alpha - 1/alpha + alpha)/(1 - 2 alpha cos x + alpha^2) dx =\
        &= pi/alpha + (alpha - 1/alpha) int_0^pi dx/(1 - 2 alpha cos x + alpha^2) = ...
    $
    Делаем через тангенс половинного угла
    $ t := tg x/2 hh ==> hh x = 2 arctg t hh ==> hh dx = 2/(1 + t^2) dt) $
    $ cos x = cos(2 arctg t) = 2 cos^2 (arctg t) = 2/(1 + t^2) - 1 = (1 - t^2)/(1 + t^2) $

    $
        ... &= pi/alpha + (alpha^2 - 1)/alpha int_0^(+oo) dt/(1 - 2 alpha (1 - t^2)/(1 + t^2) + alpha^2) dot 2/(1 + t^2) =\
        &= pi/alpha + 2 (alpha^2 - 1)/alpha int_0^(+oo) dt/(t^2 (alpha+1)^2 + (alpha-1)^2)\
        &= pi/alpha + 2(alpha^2 - 1)/alpha 1/(alpha + 1) int_0^(+oo) dz/(z^2 + (alpha-1)^2)\
        &= pi/alpha + 2(alpha^2 - 1)/(alpha (alpha + 1)(alpha - 1)) ub(with(arctan z/(alpha-1))^(+oo)_0, = -pi/2) = 0
    $

    Итого, $I'(alpha) = 0$. Поскольку $I(0) = 0$, то $I(alpha) eq.triple 0$
]

= Равномерная сходимость несобс. интегралов, зависящих от параметра

$
    alpha in E hh I(alpha) int_a^(-> b) f(x, alpha) dx = lim_(b_1 -> b-0) int_a^b f(x, alpha) dx
$

Поточечная сходимость по $alpha$:
//$ forall alpha in E forall eps > 0 exists delta > 0 forall b_1 in circle(B)_delta^- (b) : abs(I(alpha) - int_a^(b_1) f(x, alpha) dx) < eps $
$ forall alpha in E forall eps > 0 #text(fill: blue)[$exists xi > 0$] forall b : xi < b_1 < b :  abs(I(alpha) - int_a^(b_1) f(x, alpha) dx) < eps $

Равномерная сходимость на $E$:

$ #text(fill: blue)[$exists xi > 0$] forall alpha in E forall eps > 0 > 0 forall b : xi < b_1 < b :  abs(I(alpha) - int_a^(b_1) f(x, alpha) dx) < eps $

Как доказать, что сходится равномерно? Признак Вейерштрасса. Ограничиваем $abs(f(x, alpha)) <= g(x)$, $int_a^(-> b) g(x) dx$ сходится.
Тогда $int_a^(->b) f(x, alpha) dx$ сходится равномерно на $E$.

#task[
    #term[Задача 14.1.1]

    $ int_1^(+oo) dx/x^alpha hhh E_1 = [alpha_0, +oo) hh alpha_0 > 1 hhh E_2 = (1, +oo) $

    Будут ли равномерные сходимости?
]
#proof[
    Сходимость есть.
    На $E_1$ равномерная есть: $abs(1/x^alpha) < 1/x^(alpha_0)$ + признак Вейерштрасса.
    На $E_2$ нет.
]
