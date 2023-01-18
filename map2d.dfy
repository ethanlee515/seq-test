include "libraries/src/Collections/Sequences/Seq.dfy"
import opened Seq

function method MapRange<T>(f: T --> T, xs: seq<T>, j1: int, j2: int) : (ys: seq<T>)
requires 0 <= j1 < j2 <= |xs|
requires forall j :: j1 <= j < j2 ==> f.requires(xs[j])
ensures |xs| == |ys|
ensures forall j :: 0 <= j < |xs| ==> ys[j] == if j1 <= j < j2 then f(xs[j]) else xs[j]
//ensures forall j :: j1 <= j < j2 ==> ys[j] == f(xs[j])
{
    xs[0 .. j1] + Map(f, xs[j1 .. j2]) + xs[j2 ..]
}

function method Map2D<T>(f: T --> T, xs: seq<seq<T>>, i1: int, i2: int, j1: int, j2: int) : (ys: seq<seq<T>>)
requires 0 <= i1 < i2 <= |xs|
requires forall i :: 0 <= i < |xs| ==> 0 <= j1 < j2 <= |xs[i]|
requires forall i, j :: 0 <= i < |xs| && 0 <= j < |xs[i]| ==> f.requires(xs[i][j])
ensures forall i, j ::
    0 <= i < |xs| ==>
    0 <= j < |xs[i]| ==>
    |ys| == |xs| && |ys[i]| == |xs[i]| &&
    ys[i][j] == if i1 <= i < i2 && j1 <= j < j2 then f(xs[i][j]) else xs[i][j]
{

    MapRange(x
        requires j2 <= |x|
        requires forall j :: j1 <= j < j2 ==> f.requires(x[j])
        => MapRange(f, x, j1, j2), xs, i1, i2)
}

function method Double(x: int) : (y : int)
requires x >= 0
{
    2 * x
}

method Main() {
    var xs := [11, 22, 33, 44, 55, 66, 77, 88, 99];
    var ys := MapRange(Double, xs, 2, 5);
    var xs2d := [
        [11, 12, 13, 14],
        [21, 22, 23, 24],
        [31, 32, 33, 34],
        [41, 42, 43, 44],
        [51, 52, 53, 54]
    ];
    var ys2d := Map2D(Double, xs2d, 1, 5, 2, 4);
    print ys2d;
}
