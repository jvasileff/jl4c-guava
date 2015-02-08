import java.util {
    JComparator=Comparator
}

class JavaComparator<Element>(comparator, nulls=smaller)
        satisfies JComparator<Element> {

    Comparison comparator(Element x, Element y);
    \Ismaller|\Ilarger nulls;

    function toInteger(Comparison comparison)
        =>  switch (comparison)
            case (equal)    0
            case (larger)   1
            case (smaller) -1;

    Comparison ceylonCompare(Element? first, Element? second)
        =>  if (is Element first, is Element second) then
                // Element may actually support Null
                comparator(first, second)
            else if (exists first) then
                if (exists second) then
                    comparator(first, second)
                else
                    nulls.reversed // second is null
            else if (exists second) then
                nulls // first is null
            else
                equal; // both are null

    shared actual Integer compare(Element? first, Element? second)
        =>  toInteger(ceylonCompare(first, second));

    shared actual Boolean equals(Object that)
        =>  (super of Basic).equals(that);

}
