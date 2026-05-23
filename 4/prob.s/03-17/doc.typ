#import "../../../multibook/mb.typ": *
#import "../sym.typ": *
#show : mb.chapter(
    title: [Семинар 6: Условный матож],
    date: [17 марта]
)

#note[На КР не будет вроде бы?]

Есть разные ваианты условного матожа:

 - $EE[xi | B]$, $B$ -- событие
 - $EE[xi | cF]$, $cF$ -- σ-алгебра
 - $EE[xi | eta]$, $eta$ -- случайная величина

== Условный по событию

В дискретном случае, обычный матож -- $EE xi = sum k dot P[xi = k]$.\
Условный: 
$ EE [xi | B] = sum k dot P(xi = k | B) = sum_(k in B) (k P(xi = k))/P(B) $
В недискретном похоже.

== Условный по алгебре

В случае σ-алгебры $eta = EE[xi | cF]$ это такая случайная величина, что:
1. $eta$ $cF$-измерима
2. $forall A in cF : EE[xi dot d1_A] = EE[eta dot d1_A]$

Если $xi$ уже $cF$-измерима, то $eta = xi$.

Например при $cF = {void, Omega}$, $cF$-измеримые только константы.

Если $Omega = D_1 uu.sq D_2 uu.sq ...$, $cF = sigma({D_i})$, то
$EE[xi | cF] = sum C_i d1_D_i$.\
$EE[xi I_(D_i)] = C_i P(D_i)$

Итого $E[xi | cF] = sum EE[xi | D_i] I_(D_i)$

#note[Много отсылок к лекции, нужно глянуть]

Хорошие свойства:
    - Если $cF_1 sub cF_2$, то $EE[EE[xi | cF_2] | cF_1] = EE[EE[xi | cF_1] | cF_2] = EE[xi | cF_1]$
    - $EE[EE[xi | cF]] = EE xi$

== Условный по случайной величине

$ EE[xi | eta] eq.def EE[xi | sigma(eta)] = EE[xi | { eta^(-1) (B) | B in cB(RR) }] $

Есть утверждение, что $xi$ измерима относительно $sigma(eta)$ $<==>$ $exists$ борелевская $phi : xi = phi(eta)$.

Так что $EE[xi | eta] = phi(eta)$.

#task[
    #term[Задача 1]

    $ x ~ U[1, 6] hhh EE[x | (x-2)^2] = ? $
]

#proof[
    ...
]

#task[
    #term[Задача 2]
]
