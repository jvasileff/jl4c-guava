import com.google.common.collect {
    GuavaMultiset=Multiset
}
import ceylon.interop.java {
    CeylonSet,
    CeylonIterator
}

shared
interface Multiset<out Element>
        satisfies Collection<Element> &
                  Correspondence<Object, Integer>
        given Element satisfies Object {

    shared formal
    GuavaMultiset<out Element> delegate;

    "Returns true if either 1) this multiset contains the specified
     element, or 2) if the parameter is of the form `element->Integer`,
     and this multiset contains the specified element with the given
     number of occurrences."
    shared actual
    Boolean contains(Object element)
        =>  if (delegate.contains(element)) then
                true
            else if (is Object->Integer element) then
                element.item == occurrences(element.key)
            else
                false;

    "Returns the number of occurrences of an element in this multiset"
    shared
    Integer occurrences(Object element)
        =>  delegate.count(element);

    "Returns the number of occurrences of an element in this multiset, or
     `null` if the element is not contained in this multiset."
    shared actual
    Integer? get(Object element)
        =>  let (num = occurrences(element))
            if (num == 0) then null else num;

    shared actual
    Boolean defines(Object element)
        =>  delegate.contains(element);

    "Returns the set of distinct elements contained in this multiset."
    shared actual
    Set<Element> keys
        =>  CeylonSet<Element>(delegate.elementSet());

    shared actual
    Iterator<Element> iterator()
        =>  CeylonIterator(delegate.iterator());

    "Returns a view of the contents of this multiset, grouped into Tuples,
     each providing an element of the multiset and the count of that element."
    shared
    // TODO consider Set<Element->Integer>, Map<Element,Integer>, or even
    // Set<Multiset.Entry<Element>>. The last one could support live views
    // as Guava's Entry does, although that really seems unnecessary.
    Set<[Element, Integer]> entries => object
            satisfies AbstractSet<[Element, Integer]> {

        shared actual
        Boolean contains(Object element)
            =>  if (is [Element, Integer] element)
                then occurrences(element[0]) == element[1]
                else false;

        shared actual
        Integer size
            =>  keys.size;

        shared actual
        Iterator<[Element, Integer]> iterator()
            =>  keys.map((element) => [element, occurrences(element)])
                    .iterator();

        shared actual
        Boolean equals(Object that)
            =>  (super of Set<[Element, Integer]>).equals(that);

        shared actual
        Integer hash
            =>  (super of Set<[Element, Integer]>).hash;
    };
}
