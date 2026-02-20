///
/// plot.typ -- Plotting utilities for cetz
///

#import "@preview/cetz:0.4.0": canvas as _canvas, draw
#import "theme.typ": makeTheme

/// Canvases are not breakable, cetz misses that point
#let canvas(..a) = {
    let title = none
    let cont = a.pos().at(0)
    if a.pos().len() > 1 {
        title = a.pos().at(1)
    }
    align(
        center,
        block(
            breakable: false,
            _canvas(cont, ..a.named())
        )
    )
    if title != none {
        align(center, text(title))
    }
}

///
/// Plot function `f()` in range `[xmin, xmax]`,
/// sampling it in `pts` points.
/// If `T` is set, X axis is swapped with Y (so we plot `f(y)`)
///
#let func(
        f, xmin, xmax,
        T: false,
        pts: 64,
        c: 1pt + green,
        ymin : -float.inf, ymax: float.inf
) = {
    draw.line(
        ..array.range(pts)
            .map(i => xmin + (xmax - xmin) / (pts - 1) * i)
            .map(x => if T { (f(x), x) } else {(x, f(x))} )
            .filter(((x, y)) => if T { ymin < x and x < ymax} else {ymin < y and y < ymax }),
        stroke: c
    )
}

#let pat_lines(..a) = tiling(size: (5pt, 5pt), {
    let c = green.lighten(80%)
    if a.pos().len() == 1 {
        c = a.pos().at(0)
    }
    if type(c) == color {
        c = 1pt + c
    }
    place(line(start: (0pt, 0pt), end: (5pt, 5pt), stroke: c))
    place(line(start: (-5pt, 0pt), end: (5pt, 10pt), stroke: c))
    place(line(start: (0pt, -5pt), end: (10pt, 5pt), stroke: c))
})

///
/// Fill between two functions
///
#let fill2(
        f1, f2, xmin, xmax, 
        T: false,
        pts: 64, 
        stroke: 1pt + green, 
        fill: color.transparentize(green, 90%),
        sides: true
) = {

    let xs = array.range(pts)
                .map(i => xmin + (xmax - xmin) / (pts - 1) * i)

    let top = xs.map(x => if T { (f1(x), x) } else {(x, f1(x))} )
    let bottom = xs.map(x => if T { (f2(x), x) } else {(x, f2(x))} ).rev()

    if T {
        top = top.map(((x, y)) => (y, x))
        bottom = bottom.map(((x, y)) => (y, x))
    }

    if sides {
        draw.line(
            ..top, ..bottom,
            stroke: stroke,
            fill: fill,
            close: true
        )
    } else {
        draw.line(..top, ..bottom, fill: fill, stroke: none)
        draw.line(..top, stroke: stroke)
        draw.line(..bottom, stroke: stroke)
    }
    
}
///
/// Draw X and Y axis over rect [xmin, xmax] × [ymin, ymax], labeling zero
/// If `extra` is set, it adds 10% of max size to each direction
///
/// `xl` and `yl` are X and Y labels
///
#let axes(xmin, ymin, xmax, ymax, extra: false, xl: $x$, yl: $y$, iz: false) = {

    let ex = if extra {
        calc.max(xmax - xmin, ymax - ymin) * 0.1 
    } else {
        0 
    }

    draw.line(
        (xmin - ex, 0), (xmax + ex, 0),
        mark: (end: "barbed")
    )
    draw.line(
        (0, ymin - ex), (0, ymax + ex),
        mark: (end: "barbed")
    )
    
    if iz {
        draw.content((-5pt, 5pt), $0$, anchor: "south-east")
    } else {
        draw.content((-5pt, -5pt), $0$, anchor: "north-east")
    }
    draw.content((xmax + ex, 0), h(5pt) + xl, anchor: "west")
    draw.content((0, ymax + ex), yl + v(5pt), anchor: "south")
}

#let TICK_SIZE = 3pt

///
/// Draw a X-axis tick
/// If `p` is set, label will be above x axis
/// 
#let xtick(x, ..name, p: false) = {
    let label = if name.pos().len() == 1 { name.at(0) } else { x }
    draw.line((x, -TICK_SIZE), (x, TICK_SIZE))
    if p {
        draw.content((x, TICK_SIZE + 5pt), $#label$, anchor: "south")
    } else {
        draw.content((x, -TICK_SIZE - 5pt), $#label$, anchor: "north")
    }
}

#let ytick(y, ..name, p: false) = {
    let label = if name.pos().len() == 1 { name.at(0) } else { y }
    draw.line((-TICK_SIZE, y), (TICK_SIZE, y))
    if p {
        draw.content((TICK_SIZE + 5pt, y), $#label$, anchor: "west")
    } else {
        draw.content((-TICK_SIZE - 5pt, y), $#label$, anchor: "east")
    }
}

#let xperp(x, y, ..name, c: (paint: black, thickness: 0.5pt, dash: "dashed")) = {
    draw.line((x, 0), (x, y), stroke: c)
    xtick(x, ..name, p: y < 0)
}

#let yperp(x, y, ..name, c: (paint: black, thickness: 0.5pt, dash: "dashed")) = {
    draw.line((0, y), (x, y), stroke: c)
    ytick(y, ..name, p: x < 0)
}
///
/// Draw a point at given coordinates
///
#let pt(x, y, c: black) = {
    draw.circle((x, y), radius: 2pt, fill: c, stroke: 1pt + c)
}

#let xpt(x, y, c: black) = {
    draw.circle((x, y), radius: 2pt, fill: white, stroke: 1pt + c)
}
