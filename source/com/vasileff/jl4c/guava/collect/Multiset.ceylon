import com.google.common.collect {
    GuavaMultiset=Multiset
}
import ceylon.interop.java {
    CeylonSet,
    CeylonIterator
}

shared
interface Multiset<out Element>
        satisfies Collection<Element>
        given Element satisfies Object {

    shared formal
    GuavaMultiset<out Element> delegate;

    "Determines whether this multiset contains the specified element"
    shared actual
    Boolean contains(Object element)
        =>  delegate.contains(element);

    "Returns the number of occurrences of an element in this multiset"
    shared
    Integer occurrences(Object element)
        =>  delegate.count(element);

    "Returns the set of distinct elements contained in this multiset."
    shared
    Set<Element> elements
        =>  CeylonSet<Element>(delegate.elementSet());

    shared actual
    Iterator<Element> iterator()
        =>  CeylonIterator(delegate.iterator());

    "Returns a map view of the contents of this multiset."
    shared
    Map<Element, Integer> asMap => object
            satisfies Map<Element, Integer> {

        // https://github.com/google/guava/issues/419

        shared actual
        Integer? get(Object key)
            =>  let (num = occurrences(key))
                if (num == 0) then null else num;

        shared actual
        Boolean defines(Object key)
            =>  occurrences(key) > 0;

        shared actual
        Iterator<Element -> Integer> iterator()
            =>  elements.map((element) => element -> occurrences(element))
                    .iterator();

        shared actual
        Map<Element, Integer> clone()
            =>  ImmutableMap(this);

        shared actual
        Boolean equals(Object other)
            =>  (super of Map<Element, Integer>).equals(other);

        shared actual
        Integer hash
            =>  (super of Map<Element, Integer>).hash;
    };
}
