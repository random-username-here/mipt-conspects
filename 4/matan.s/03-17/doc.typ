#import "../../../multibook/mb.typ": *
#show : mb.chapter(
    title: [Семинар 7. Базисы, ортогональные системы],
    date: [17 марта]
)

#let sumkoo = $sum_(k=1)^oo$
#let sumkooz = $sum_(k=1)^oo$

== Повторение

$X$ нормированное пространство. ${e_k}_(k=1)^oo sub X$ полная, если $bar(shell(e_k)) = X$ (лин. оболочки конечные)

Теоремы Вейерштрасса:

    1. ${1, cos k x, sin k x}_(k=1)^oo$ полна в $C^*[-pi, pi]$
    2. ${x^k}_(k=0)^oo$ полна в $C[a, b]$

== Продолжаем

#def[
    #term[Базис]

    $X$ нормированное пространство. ${e_k in X}_(k=1)^oo$ базис, если $forall x in X exists! {alpha_k}_(k = 1)^oo$,
    такая что $x = sum_(k=1)^oo alpha_k e^k$.

    Соответственно $norm(x - sum_(k=1)^N alpha_k e_k) ->_(N -> oo) 0$ _(исходя из свойств суммы ряда выше)_.
]

Базис -- полная система. Обратное не всегда.

#task[
    #term[${x^k}$ не базис]

    Доказать, что ${x^k}_(k=0)^oo$ не базис в $C[-1, 1]$
]
#proof[
    Если $sum a_k x^k arrows f, f in C[-1, 1]$, то $f in C^oo (-1, 1)$ (по т-ме с первого курса).
    Есть $abs(x)$, который так не раскладывается.
]

#task[
    #term[${1, sin k x, cos k x}$ не базис]

    Доказать, что ${1, sin k x, cos k x}$ не базис $C^*[-pi, pi]$
]
#proof[
    От противного. Берём $f in C^*[-pi, pi]$. Имеем $a_0 + sum (a_k cos k x + b_k sin k x) arrows f$.

    Докажем, что $a_0, a_k, b_k$ -- коэфф. Фурье. 
    $
        int_(-pi)^pi f sin m x dx = int_(-pi)^pi [a_0 + sumkoo (a_k cos k x + b_k sin k x)] sin m x dx
    $
    В силу равномерной сходимости можно внести интегралы, и получить в итоге $pi dot b_m$.

    Ну а дальше, существует $f in C^* [-pi, pi]$, к которой РФ не сходится даже поточечно.
    Про её существование есть теорема, но она редко встречается и вроде бы не входит в курс,
    так что тут без доказательства.

    Для тех кому всё-таки пример понадобился, #url("https://math.stackexchange.com/questions/2227/example-of-a-function-whose-fourier-series-fails-to-converge-at-one-point")[можете глянуть тред на math.stackexchange.com].
]

#task[
    #term[${(0 seq 0, 1, 0 seq)}$ базис в $l_1$ и $l_2$]

    Доказать, что $e_k = \(0 seq 0, ub(1, k), 0 seq \)$ образуют базис в $l_1$ и $l_2$
]
#proof[
    Имеем $x = (x^1, x^2 seq)$. Докажем, что $x = sum x^k e_k$.

    $ norm(x - sum_(k=1)^N x^k e_k)_1 = sum_(k=N+1)^oo abs(x^k) -> 0 hhh "(т.к. " x in l_1 ")" $

    Аналогично и с $l_2$. Теперь единственность. Пусть:

    $ sumkoo tilde(x^k) e_k = x = sum x^k e_k ==> sumkoo (x^k - tilde(x^k)) e_k = 0 $
    $ sum_(k=0)^N (x^k - tilde(x^k)) e_k = (x^1 - tilde(x^1), x^2 - tilde(x^2) seq) -> 0 => x^k = tilde(x^k) $
]

#def[
    #term[Орт. система базис $<=>$ полна]

    Пусть ${e_k}_(k=1)^oo$ *ортогональная* система в евклидовом пространстве. Тогда ${e_k}_(k=1)^oo$ базис $<==>$ ${e_k}$ полна.
]
Следствие: ${1, sin k x, cos k x}$ базис в $l_2$.

Если имеется ортогональный базис ${e_k}$, то $x = sum_(k=1)^oo alpha_k e_k$.
$alpha_k = (e_k, x)/(e_k, e_k)$. 

$ norm(x) = (x, x) = (sumkoo alpha_k e_k, sumkoo alpha_n e_n) = sumkoo norm(alpha_k e_k) = sumkoo alpha_k^2 norm(e_k) = sumkoo (x, e_k)^2/((e_k, e_k)) $

Это называетсяравенство равенство Парсеваля.

Если ${e_k}$ ОНБ, то $(x, x) = sumkoo (x, e_k)^2$.

#sep

#task[
    #term[Пример]

    $ x^2 =_(norm(.)_L_2) pi^2/3 + sumkoo (4(-1)^k)/k^2 cos k x hhh norm(x^2)_2^2 = ? $
]

#proof[
    Переведём в ОНБ.

    $ x^2 = pi^2/3 sqrt(2 pi) ub(1/sqrt(2pi), e_1) + sumkoo (4(-1)^k)/k^2 sqrt(pi) ub((cos k x)/sqrt(pi), e_k)  $

    Тогда:

    $ norm(x^2)_2^2 = (2 pi^5)/9 + sumkoo (16 pi)/k^4 $

    #sep

    Если посчитать нормальным способом $norm(x^2)_2^2$ не через РФ, то будет $int_(-pi)^pi x^4 dx = (2 pi^5)/5$.

    Как побочный результат, получили $sumkoo 1/k^4 = pi^4/90$.
]

#def[
    #term[Неравенство Бесселя]
    _(с первого семинара)_

    Если ${f_k}$ орт. система, то:
    $ forall f : norm(f)^2 >= sumkoo (f, f_k)^2/(f_k, f_k) $
]

#note[
    На КР: будем раскладывать функцию в РФ по обычной системе / нестандартной.
    Также будет что-то на убывание коэффициентов и полные системы.\
    Комплексных РФ и свёрток не будет.
]

#task[
    Доказать, что $sum_(n=2)^oo (sin n x)/(ln n)$ не является РФ функции $f in L_2 [-pi, pi]$
]
#proof[
    От противного. Пусть $f$ существует.
    Пользуемся равенством Парсеваля.
    $ norm(f)^2 = sum_(n=1)^oo pi/(ln^2 n) $
    Не сходится, противоречие.
]

#task[
    Пусть $f, g in C^*[-pi, pi]$. У них равные коэфф. Фурье.
    Доказать, что $f = g$.
]
#proof[
    $f, g in L_2 [-pi, pi]$. $h := f - g in L_2 [-pi, pi]$, и РФ $h$ нулевой.
    Соответственно $h = 0$ в $L_2 ==> h = 0$ почти всюду $==> h = 0$.
]

#note[В следующий раз КР, затем пойдут интегралы с параметрами]
