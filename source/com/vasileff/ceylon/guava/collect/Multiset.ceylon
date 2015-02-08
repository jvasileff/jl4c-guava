shared
interface Multiset<out Element>
        satisfies Collection<Element>
        given Element satisfies Object {

    "Determines whether this multiset contains the specified element"
    shared actual formal
    Boolean contains(Object element);

    "Returns `true` if this multiset contains at least one occurrence of
     each given value, or `false` otherwise."
    shared actual default
    Boolean containsEvery({Object*} elements)
        =>  super.containsEvery(elements);

    "Returns the number of occurrences of an element in this multiset"
    shared formal
    Integer occurences(Object element);

    "Returns the set of distinct elements contained in this multiset."
    shared formal
    Set<Element> elements;

    "Returns a view of the contents of this multiset, grouped into Tuples,
     each providing an element of the multiset and the count of that element."
    shared formal
    Set<[Element, Integer]> entries;
}
