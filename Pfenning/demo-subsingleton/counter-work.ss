#options --work=send
#options --time=none

type bin = +{b0 : bin , b1 : bin , e:1}
type ctr = &{
    inc: <{3}|ctr,
    val: <{2}|bin}

proc bit0 : ctr |{2}- ctr
proc bit1 : ctr |{3}- ctr
proc empty : . |- ctr

proc bit0 = caseR ( inc => bit1
                  | val => L.val ;
                           R.b0 ;
                           <->
                   )

proc bit1 = caseR ( inc => L.inc ; bit0
                  | val => L.val ; R.b1 ; <->)
proc empty = caseR ( inc => empty || bit1
                   | val => R.e ; closeR)

proc six : . |{8}-ctr
proc six = empty || bit1 || bit1 || bit0
exec six

proc eight : . |{14+2}- ctr
proc eight = six || (L.inc ; L.inc ; <-> )
exec eight
