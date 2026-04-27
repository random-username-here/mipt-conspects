#import "../../../multibook/mb.typ": *
#import "../sym.typ": *
#show : mb.chapter(
    title: [Семинар 11. Задача со свободным концом],
    date: [17 апреля]
)

= Теория

$
    J(y) = int_a^b F(x, y, y') hhh y(a) = A
$

То есть $y(b)$ мы можем выбирать каким хочем.

Условно, мы хотим переехать реку по броду на машине. Мы в известной
начальной точке. Хотим выехать где угодно, главное перебраться
с минимальными возможными потерями.

$h in C'[a, b], h(a) = 0$.

$ dd/dx (pd F)/pdy' - (pd F)/pdy = 0 $
Решение $y$ будет иметь две константы. Закреплённая
точка даёт одну из них.

Пусть мы нашли функцию $hat(y) (b)$. Тогда она удвлетворяет такому:

$ (pd F)/pdy' (b, hat(y) (b), hat(y)' (b)) = 0 $

Это позволяет найти вторую константу. Откуда такая формула -- смотрите лекции.

Дальше точно так же как раньше, $J(hat(y) + h) - J(hat(y))$, только не забываем,
что $h$ другое.

= Практика

#task[
    #term[Задача]

    $ J(y) = int_1^3 ub((8 y y' ln x - x y'^2 + 6 x y'), F(x, y, y')) dx hhh y(3) = 15 $
]

#let hy = $hat(y)$

#proof[
    Расписываем уравнение Эйлера-Лагранжа.
    $ (pd F)/pdy = 8 y' ln x $
    $ (pd F)/pdy' = 8 y ln x - 2 x y' + 6x hhh dd/dx (pd F)/pdy' = (8y)/x + 8 y' ln x - 2y'  - 2 x y'' + 6 $
    $ x^2 y'' + x y' - 4y = 3x $

    Уравнение Эйлера.

    $ alpha(alpha - 1) + alpha - 4 = 0 ==> alpha = pm 2 => y_"одн" (t) = C_1 e^(2t) + C_2 e^(-2t) $
    $ y'' - 4y = 3e^t, y_2 = C e^t => C = 1 => y_2 = e^t $
    $ y(x) = C_1 x^2 + C_2 x^(-2) - x $

    Закреплённая точка и условие:

    $ y(3) = 15 = 9 C_1 - 1/9 C_2 - 3 = 15\ 
        (pd F)/pdy' (1, y(1), y'(1)) = -2 y'(1) + 6 = 0 => y'(1) = 3\
        y'(x) = 2 C_1 x - 2 C_2 x^(-3) - 1 ==> 2 C_1 - 2 C_2 - 1 = 3 => C_1 = C_2 + 2\
        ==> (9 + 1/9) C_2 = 0 => C_2 = 0 => C_1 = 2 => hat(y) = 2 x^2 - x
    $

    $
        J(hy + h) - J(hy) = int_1^3 (8 h h' ln x - x h'^2) dx =_"см. ниже" int_1^3 (-(4 h^2)/x - x h'^2) dx \
        int_1^3 8 h h' ln x dx = with(4 h^2 ln x)_1^3 - int_1^3 (4 h^2)/x dx 
    $
]

#task[
    #term[Задача]

    $ J(y) = int_1^2 (y'^3)/x^2 dx hhh y(1) = 1 $

    Найти допустимые экстремальные вариационные задачи.
]
#note[Если у вас имеются $y$ и $y'$, степени у которых $>2$, то посмотрите внимательно на условие. Обычно там только просят $hat(y)$.]
#proof[
    Быстро пишем уравнение Эйлера:
    $ dd/dx (3 y'^2)/x^2 = (6 y'' y')/x^2 - (6 y'^2)/x^3 <==> cases(delim: "[", y' = 0 => y eq.triple 1, x^2 6 y'' - 6 y' x = 0) $

    $ lambda(lambda - 1) - lambda = lambda^2 - 2 lambda = 0 => y = C_1 + C_2 x^2 $
    $ y'(2) = 0 => with(2 x C_2)_(x=2) = 5 C_2 = 0 => C_2 = 0, y(1) = C_1 = 1 $

    $ hat(y) eq.triple 1 => J(hy + h) - J(hy) = int_1^2 1/x^2((hy' + h')^3 - hy^3) dx = int_1^2 hy'^3/x^2 dx $

    $h(1) = 0$. Пусть $h_(1,n) (x) = (x-1)/n, h_(2, n) = (1-x)/n$.

    Тогда:
    $ 
        J(hy + h_(1,n)) = int_1^2 1/n^3 1/x^2 dx = with(-1/(x n^3))_1^2 > 0 hhh J(hy + h_(2,n)) = int_1^2 -1/n^3 1/x^2 dx < 0
    $

    Не экстремум.
]

#task[
    #term[Задача]
    $ int_0^(pi/2) (y^2 cos 2 + y y' sin 2x + y'^2 + y cos x + y' sin x) dx hhh y(0) = 0 $
]
#proof[
    Составим уравнение Эйлера:

    $ (pd F)/pdy' = y sin 2x + 2 y' + sin x $
    $ (pd F)/pdy = 2 y cos 2x + y' sin 2x + cos x ==> dd/dx (pd F)/pdy' - (pd F)/pdy = 2 y'' = 0 $
    $ y = C_1 x + C_2 hhh y(0) = 0 => C_2 = 0 $
    $ (pd F)/pdy' (pi/2, y(pi/2), y'(pi/2)) = 0 => 2 y'(pi/2) + 1 = 0 => C_1 = -1/2 => hat(y) = -1/2 x $

    $ J(hy + h) - J(hy) = int_0^(pi/2) (h^2 cos 2 + h h' sin 2x + h'^2) dx = int_0^(pi/2) h'^2 dx >= 0\ => hat(y) = -x/2 - "лок. минимум" $
]

#task[
    #term[Задача]
    $ J(y) = int_0^(pi/2) (y'^2 - y^2 + 4 y y' + 4 y sin x + sin x^2) dx hhh y(0) = pi/2 $
]
#proof[
    $ (pd F)/pdy' = 2 y' + 4y hhh (pd F)/pdy = -2y + 4 y' + 4 sin x $
    $ d/dx (pd F)/pdy' - (pd F)/pdy = 2 y'' + 4 y' + 2y - 4y' - 4 sin x = 0 => y'' + y = 2 sin x $

    $ lambda^2 + 1 = 0 => lambda = pm i => y_"одн" = C_1 cos x + C_2 sin x $


    $ y_"ч" = a x sin x + b x cos x $
    $ y_"ч"' = a x cos x + a sin x - b x sin x + b cos x $
    $ y_"ч"'' = - a x sin x + a cos x + a cos x - b x cos x - 2 b sin x $
    $ 2 a cos x - 2 b sin x = 2 sin x => a = 0, b = -1\ => y = C_1 cos x + C_2 sin x - x cos x $

    $y(0) = pi/2 => C_1 = pi/2$

    $ y' = -pi/2 sin x + C_2 cos x + x sin x - cos x $
    $ 0 = (pd F)/pdy' (pi/2, y(pi/2), y'(pi/2) = 2 y'(pi/2) + 4 y(pi/2) $
    $ y(pi/2) = C_2, y'(pi/2) = 0 ==> C_2 = 0 => hy = pi/2 cos x - x cos x $

    #sep

    $ J(hy + h) - J(hy) = int_0^(pi/2) (h'^2 - h^2 + 4 h h') dx = ... $

    $ int_0^(pi/2) 4 h h' dx = 2 int_0^(pi/2) d h^2 = with(2 h^2)_0^(pi/2) = 2 h^2 (pi/2) $
    $ ... = 2 h^2 (pi/2) + int_0^(pi/2) (h'^2 - h^2) dx = ... $
    $ int_0^(pi/2) (h' - h cot x)^2 dx = int_0^(pi/2) (h'^2 - 2 h h' cot x + h^2 cot^2 x) dx $
    $ int_0^(pi/2) cot x h h' dx = ub(with(h^2 cot x)_0^(pi/2), 0) + int_0^(pi/2) h^2/sin^2 x dx $
    $ ... = int_0^(pi/2) (h'^2 - h^2/(sin^2 x) + h^2 (cos x)/(sin^2 x)) dx = int_0^(pi/2) h'^2 - h^2 >= 0 $

    Значит исходный интеграл $>= 0$, локальный минимум. Это было очень идейное решение
    задачи, которая решается Вертингером.
]


