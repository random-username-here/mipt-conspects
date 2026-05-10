#import "../../../multibook/mb.typ": *
#import "../sym.typ": *
#show : mb.chapter(
    title: [Семинар 10. Считаем интегралы],
    date: [7 апреля]
)

Вспоминаем.

$ I(alpha) = int_a^(->b) f(x, alpha) dx hh alpha in E $
$ I "сх. равн. на " E <==> forall eps > 0 exists delta > 0 forall b in (b - delta, b) forall alpha in E : abs(I(alpha) - int_a^(b_1) f(x, alpha) dx) < eps $

Как доказать что есть равн. сходимость? Признак Вейерштрасса.
$ abs(f(x, alpha)) < g(x), hh int_a^(->b) g(x) "есть" =>  "есть равн. сх." $

Как доказать что равн. сходимости нет? Отрицание критерия Коши.

$ exists eps_0 > 0 forall delta > 0 exists xi_1, xi_2 in (b - delta, b) exists alpha in E : abs(int_(xi_1)^(xi_2) f(x, alpha) dx) >= eps_0 $

#task[
    #term[Задача 14.1.1]

    $ int_1^(+oo) dx/x^alpha hh E_1 = [alpha_0, +oo), alpha_0 > 1; hh E_2 = (1, +oo) $
]
#proof[
    *Первый*

    Поточеная сходимость есть, т.к. интеграл эталонный, $alpha > 1$.
    Равномерна: $abs(1/x^alpha) <= abs(1/x^(alpha_0))$, есть, по Вейерштрассу.

    *Вторая*

    Поточечная всё равно имеется.

    $ exists eps_0 = 1/2 forall b_0 > 0 exists xi_1 = N^N >= b_0, xi_2 = (2N)^N exists alpha = 1 + 1/N : abs(int_(xi_1)^(xi_2) dx/x^alpha) = \
    = 1/(alpha-1) (1/xi_1^(alpha-1) - 1/xi_2^(alpha-1)) = N (1/root(N, N^N) - 1/root(N, (2N)^N)) = N(1/N - 1/(2N)) = 1/2 = eps_0  $
]

#task[
    #term[Задача 14.7.2]

    $ int_0^(+oo) alpha e^(-alpha x) dx hh E = [0, 1] $
]
#proof[
    Если $alpha != 0$, то можно сделать $x = alpha y$, и получить интеграл $int_0^(+oo) e^(-y) dy = 1$.\
    Если $alpha = 0$, то интеграл равен нулю.

    $I(0) = 0, I(alpha != 0) = 1$. Поточечная сходимость есть.

    Равномерной сходимости нет, так как функция разрывная. Докажем это.
    
    Отрицание критерия Коши:

    $ exists eps_0 forall b_0 >= 0 exists xi_1 = N exists xi_2 = 2N exists alpha = 1/N : abs(int_(xi_1)^(xi_2) alpha e^(-alpha x) dx) =\
        = int_(alpha xi_1)^(alpha xi^2) e^(-y) dy = e^(-alpha xi_1) - e^(-alpha xi_2) = e^(-1) - e^(-2) = eps_0
    $
]

#task[
    #term[Задача 14.6.3]
    $ int_0^(+oo) dx/(4 + (x - alpha)^6) hh E_1 = (-oo, 0] hh E_2 = [0, +oo) $
]
#proof[
    Поточечно.
    $ 1/(4 + (x-alpha)^6) ~ 1/(4 + x^6) - "сх." $

    Равномерно на $E_1$.

    $ abs(1/(4 + (x - alpha)^6)) <= 1/(4 + x^6) $
    По признаку Вейерштрасса равн. сх. есть.

    Равномерно на $E_2$. Тут чуть сложнее, чем $N$/$2N$, рисуем график.
    
    #canvas({
        let sy = 6
        plot.axes(-2, 0, 6, 0.4 * sy)
        let plf(a) = { 
            plot.func(x => sy/(4 + calc.pow(x - a, 6)), -2, 6, c: blue)
        }

        plf(2)
        plot.xperp(2, 0.25 * sy, $a$)
        plot.xperp(1, 0.2 * sy, $a-1$)
        plot.xperp(3, 0.2 * sy, $a+1$)
    })

    Заметим, что при изменении $a$ весь график сдвигается вбок.

    $ exists eps_0 = 2/5 forall b_0 >= 0 exists xi_1 = N-1 exists xi_2 = N+1 exists alpha = N : abs(int_(xi_1)^(xi_2) dx/(4 + (x-alpha)^6)) =\
        = int_(-1)^1 dt/(4 + t^6) >= 2/5 = eps_0
    $
]

#def[
    #term[Признак Дирехле равном. сходимости несобс. интегр.]

    _(Со 2-го семестра, для тех, кто забыл)_

    1. $int_a^x f(t, alpha) dt - "равн. огр. по" alpha$\
        (то есть $exists C forall alpha in E forall x in [a, b] : abs(int_a^x f(t, alpha) dt) <= C$)
    2. $g(x, alpha)$ монотонно убывает при каждом $alpha$
    3. $g(x, alpha) arrows^(alpha in E) 0$ при $x -> b - 0$\
        (то есть $forall eps > 0 exists delta > 0 forall dot(U)_delta(b) forall alpha in E : abs(g(x, alpha)) <= eps$

    Тогда $int_a^x f(x, alpha) g(x, alpha) dx$ сходится равномерно на $E$.
]

3-й пункт можно доказать через ограничение $abs(g(x, alpha)) <= phi(x) -> 0$.

#task[
    #term[Задача]

    $ int_1^(+oo) (sin x)/x^alpha dx hh E_1 = [alpha_0, +oo), alpha_0 > 0 hh E_2 = (0, +oo) $
]

#proof[
    Поточечно:
    $ int_1^(+oo) (sin x)/x^alpha dx : cases(alpha > 0 => "абс", 0 < alpha <= 1 => "усл", alpha <= 0 => "расх") $

    $E_1$: признак Дирехле. $f(x, alpha) = sin x$, $g(x, alpha) = 1/x^(alpha)$.

    $f(x, alpha)$ равн. огр. $g(x, alpha)$ монотонно убвает, равн. $arrows 0$. По Дирехле равн. сх. есть.

    $E_2$: отрицаем Коши.

    $
        exists eps_0 =
        forall b_0 >= 0
        exists xi_1 = 2 pi N
        exists xi_2 = 2 pi N + pi
        exists alpha = 1/N
        : abs(int_(xi_1)^(xi_2) (sin x)/x^alpha dx) =\
        = 1/xi_2^alpha int_(xi_1)^(xi_2) sin x dx = 2/ub(root(N, 2 pi N + pi), root(N, N) -> 1) -> 2 >= 1 "с какого-то" N
    $
]

= Вычисление интегралов

#def[
    #term[Теорема 1.2]

    Пусть $f(x, alpha)$ - непр. функция на $G = {a <= x < b, A <= alpha <= B }$.
    $I(alpha) = int_a^(->b) f(x, alpha) dx$ #underline[сходится равномерно] на $[A, B]$. Тогда $I(alpha)$ непрерывная функция.
]

#def[
    #term[Теорема 2.2]

    Пусть $f(x, alpha)$, $f'_alpha (x, alpha)$ непр. на $G$. $I(alpha)$ сходится при $alpha = A$.

    $int_a^(->b) f'_alpha (x, alpha) dx$ сходится равномерно на $[A, B]$.
    Тогда $I'(alpha) = int_a^(->b) f'_alpha (x, alpha) dx$ на $[A, B]$.
]

_На занятии эти теоремы обозначались Т1 c тильдой / Т2 с тильдой, но мне проще писать Т1.2/Т2.2_

Если надо доказать непрерывность/дифф. на $(A, B) : A, B in bar(RR)$, то доказываем для всех подотрезков $[c, d] sub (A, B)$.

Были подобные теоремы для интеграла Лебега (назовём их теорема 1/теорема 2), для собственных интегралов:

 1. *Теорема 1*: $abs(f(x, alpha)) <= Phi(x), Phi in L_1 => I(alpha) "непр"$
 2. *Теорема 2*: $abs(f'_alpha (x, alpha)) <= Phi(x), Phi in L_1 => I'(alpha) = int_a^(->b) f'_alpha (x, alpha) dx$



#sep

Факт с лекции:

$ int_0^(+oo) sin(alpha x)/x dx = pi/2 sign alpha $

Посмотрите, как это делали! Не обязательно с лекции, это стандартный пример.

#task[
    #term[Задача]

    Вычислить интеграл:

    $
        int_0^(+oo) (cos(alpha x) - cos(beta x))/x^2 dx
    $
]
#proof[
    Интеграл разбить не получится, так как части будут расходитсья в нуле.

    Обозначим интеграл как $I(alpha, beta)$. Тогда при $alpha, beta > 0$:
    $ I'_alpha (alpha, beta) =^? int_0^(+oo) (- x sin alpha x)/x^2 = int_0^(+oo) (-sin alpha x)/x = -pi/2 $

    Теорема 2 сработала, значит равенство есть.

    $I'_beta (alpha, beta) = pi/2$ таким же образом. Тогда $I(alpha, beta) = pi/2 (beta - alpha) + C$.
]
