///
/// sym.typ -- Custom symbols
///


///---------------------------------------------------------
/// Under/overlines


#let bar(x) = $overline(#x)$
#let und(x) = $underline(#x)$


///---------------------------------------------------------
/// Limits


/// Limits with changeable variable
#let limoo(x)   = $lim_(#x ->  oo)$
#let limoop(x)  = $lim_(#x -> +oo)$
#let limoon(x)  = $lim_(#x -> -oo)$
#let limz(x)    = $lim_(#x ->   0)$
#let limzp(x)   = $lim_(#x ->  +0)$
#let limzn(x)   = $lim_(#x ->  -0)$

/// Natural limits
#let limnoo     = limoo($n$)
#let limmoo     = limoo($m$)

/// X limits
#let limxoo     = limoo($x$)
#let limxoop    = limoop($x$)
#let limxoon    = limoon($x$)
#let limxz      = limz($x$)
#let limxzp     = limzp($x$)
#let limxzn     = limzn($x$)

/// Lower/Upper limits
#let llimoo(x)  = $op(limits: #true, und(lim))_(#x -> oo)$
#let ulimoo(x)  = $op(limits: #true, bar(lim))_(#x -> oo)$
#let llimnoo    = llimoo($n$)
#let ulimnoo    = ulimoo($n$)

///---------------------------------------------------------
/// Misc. shorthands

/// Operator shorthands
#let prod       = math.product
#let int        = math.integral
#let iint       = math.integral.double
#let iiint      = math.integral.triple
#let iiiint     = math.integral.quad
#let xx         = sym.times
#let pm         = sym.plus.minus
#let void       = sym.emptyset
#let sdiff      = $op(triangle)$ // symmetric difference, for sets
#let uu         = sym.union
#let uuu        = sym.union.big
#let nn         = sym.inter
#let nnn        = sym.inter.big
#let sub        = sym.subset
#let sups       = sym.supset
#let grad       = sym.gradient
#let cc         = sym.complement

/// Epsilon shorthand
#let eps        = sym.epsilon

// Properly spaced quantors
#let forall     = $ #h(0.5em) #math.forall $
#let exists     = $ #h(0.5em) #math.exists $
#let hh         = $ #h(1em) $
#let hhh        = $ #h(2em) $
#let dd         = $ dif $
#let pd         = $ partial $

#let ub(t, b) = math.underbracket(t, b)
#let ob(t, b) = math.overbracket(t, b)

///---------------------------------------------------------
/// Functions

#let sign       = math.op("sign")
#let rk         = math.op("rk")
#let ch         = math.op("ch")
#let sh         = math.op("sh")
#let th         = math.op("th")
#let tg         = math.op("tg")
#let Re         = math.op("Re")
#let Im         = math.op("Im")
#let Ker        = math.op("Ker")

#let supp       = math.op("supp")
#let PMF        = math.op("PMF")
#let Bin        = math.op("Bin")
#let Ber        = math.op("Ber")
#let Pois       = math.op("Pois")
#let Geom       = math.op("Geom")
#let Cov        = math.op("Cov")

#let dp         = math.op("dp")

#let _bexpand(v) = {
    v.pos().join([,])
}

#let with(..x)    = $lr("" #_bexpand(x) |)$
#let shell(..v)   = $lr(angle.l #_bexpand(v) angle.r)$

//#let sep = align(center, line(length: 20%, stroke: 0.5pt))
#let sep = align(center, v(1em) + image("img/fancy-sep.svg") + v(1em))


// now go copypasted ones

#let cA         = $cal(A)$
#let cB         = $cal(B)$
#let cC         = $cal(C)$
#let cD         = $cal(D)$
#let cE         = $cal(E)$
#let cF         = $cal(F)$
#let cG         = $cal(G)$
#let cH         = $cal(H)$
#let cI         = $cal(I)$
#let cJ         = $cal(J)$
#let cK         = $cal(K)$
#let cL         = $cal(L)$
#let cM         = $cal(M)$
#let cN         = $cal(N)$
#let cO         = $cal(O)$
#let cP         = $cal(P)$
#let cR         = $cal(R)$
#let cS         = $cal(S)$
#let cT         = $cal(T)$
#let cU         = $cal(U)$
#let cV         = $cal(V)$
#let cW         = $cal(W)$
#let cX         = $cal(X)$
#let cY         = $cal(Y)$
#let cZ         = $cal(Z)$

#let fA         = $frak(A)$
#let fB         = $frak(B)$
#let fC         = $frak(C)$
#let fD         = $frak(D)$
#let fE         = $frak(E)$
#let fF         = $frak(F)$
#let fG         = $frak(G)$
#let fH         = $frak(H)$
#let fI         = $frak(I)$
#let fJ         = $frak(J)$
#let fK         = $frak(K)$
#let fL         = $frak(L)$
#let fM         = $frak(M)$
#let fN         = $frak(N)$
#let fO         = $frak(O)$
#let fP         = $frak(P)$
#let fR         = $frak(R)$
#let fS         = $frak(S)$
#let fT         = $frak(T)$
#let fU         = $frak(U)$
#let fV         = $frak(V)$
#let fW         = $frak(W)$
#let fX         = $frak(X)$
#let fY         = $frak(Y)$
#let fZ         = $frak(Z)$

#let sA         = $scr(A)$
#let sB         = $scr(B)$
#let sC         = $scr(C)$
#let sD         = $scr(D)$
#let sE         = $scr(E)$
#let sF         = $scr(F)$
#let sG         = $scr(G)$
#let sH         = $scr(H)$
#let sI         = $scr(I)$
#let sJ         = $scr(J)$
#let sK         = $scr(K)$
#let sL         = $scr(L)$
#let sM         = $scr(M)$
#let sN         = $scr(N)$
#let sO         = $scr(O)$
#let sP         = $scr(P)$
#let sR         = $scr(R)$
#let sS         = $scr(S)$
#let sT         = $scr(T)$
#let sU         = $scr(U)$
#let sV         = $scr(V)$
#let sW         = $scr(W)$
#let sX         = $scr(X)$
#let sY         = $scr(Y)$
#let sZ         = $scr(Z)$

#let dt         = $dd t$
#let du         = $dd u$
#let dv         = $dd v$
#let dw         = $dd w$
#let dx         = $dd x$
#let dy         = $dd y$
#let dz         = $dd z$
#let d1         = $bb(1)$ // double-struck 1 for indicators

