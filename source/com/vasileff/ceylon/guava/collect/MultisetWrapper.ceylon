import com.google.common.collect {
    GuavaMultiset=Multiset
}
import ceylon.interop.java {
    CeylonSet,
    CeylonIterator
}

class MultisetWrapper<out Element>(GuavaMultiset<out Element> delegate)
        satisfies Multiset<Element>
        given Element satisfies Object {

    variable
    Set<[Element, Integer]>? entriesMemo = null;

    shared actual default
    Boolean contains(Object element)
        =>  delegate.contains(element);

    shared actual default
    Integer occurences(Object element)
        =>  delegate.count(element);

    shared actual default
    Set<Element> elements
        =>  CeylonSet(delegate.elementSet());

    shared actual default
    Iterator<Element> iterator()
        =>  CeylonIterator(delegate.iterator());

    shared actual default
    ImmutableMultiset<Element> clone()
        =>  ImmutableMultiset(this);

    shared actual default
    Set<[Element, Integer]> entries => entriesMemo else (entriesMemo =
        object satisfies AbstractSet<[Element, Integer]> {
            contains(Object element)
                =>  if (is [Element, Integer] element)
                    then occurences(element[0]) == element[1]
                    else false;

            iterator()
                =>  elements.map((element)
                        => [element, occurences(element)]).iterator();

            size
                => elements.size;

            equals(Object other)
                => (super of Set<[Element, Integer]>).equals(other);

            hash
                => (super of Set<[Element, Integer]>).hash;
    });
}
