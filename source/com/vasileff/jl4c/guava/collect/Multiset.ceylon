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

    "Returns `true` if this multiset contains at least one occurrence of
     each given value, or `false` otherwise."
    shared actual default
    Boolean containsEvery({Object*} elements)
        =>  super.containsEvery(elements);

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

    "Returns a view of the contents of this multiset, grouped into Tuples,
     each providing an element of the multiset and the count of that element."
    shared
    Set<[Element, Integer]> entries => object
            satisfies AbstractSet<[Element, Integer]> {

        shared actual
        Boolean contains(Object element)
            =>  if (is [Element, Integer] element)
                then occurrences(element[0]) == element[1]
                else false;

        shared actual
        Integer size
            =>  elements.size;

        shared actual
        Iterator<[Element, Integer]> iterator()
            =>  elements
                    .map((element) => [element, occurrences(element)])
                    .iterator();

        shared actual
        Boolean equals(Object that)
            =>  (super of Set<[Element, Integer]>).equals(that);

        shared actual
        Integer hash
            =>  (super of Set<[Element, Integer]>).hash;
    };

}
