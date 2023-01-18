include "libraries/src/Collections/Sequences/LittleEndianNat.dfy"

module Binary refines LittleEndianNat {
    function method BASE() : nat { 2 }
}

method Main() {
    var x := 183;
    var bits := Binary.FromNat(x);
    var y := Binary.ToNatRight(bits);
    print(bits);
    print "\n";
    print(y);
}
