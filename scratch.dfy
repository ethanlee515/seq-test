function method DoubleF(x: int) : int {
    2 * x
}

method DoubleM(x: int) returns (y: int)
{
    return 2 * x;
}
// ->: no pre-cond, no heap-read
// -->: pre-cond, no heap-read
// ~>: partial function (with pre-cond), heap reads allowed

function method Apply(f: int ~> int)
{

}

method Main() {
    print "hello";
}