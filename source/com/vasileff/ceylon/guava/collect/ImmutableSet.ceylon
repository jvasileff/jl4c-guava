import ceylon.interop.java {
    CeylonIterator
}

import com.google.common.collect {
    GuavaImmutableSet=ImmutableSet {
        GISBuilder=Builder
    }
}

shared final
class ImmutableSet<out Element>
        ({Element*}|GuavaImmutableSet<out Element> elements)
        satisfies Set<Element>
        given Element satisfies Object {

    shared
    GuavaImmutableSet<out Element> delegate;

    if (is {Element*} elements) {
        value builder = GISBuilder<Element>();
        for (element in elements) {
            builder.add(element);
        }
        delegate = builder.build();
    }
    else {
        this.delegate = elements;
    }

    shared actual
    Boolean contains(Object element)
        =>  delegate.contains(element);

    shared actual
    Integer size
        =>  delegate.size();

    shared actual
    Iterator<Element> iterator()
        =>  CeylonIterator(delegate.iterator());

    shared actual
    ImmutableSet<Element> clone()
        =>  this;

    shared actual
    Boolean equals(Object that)
        =>  (super of Set<Element>).equals(that);

    shared actual
    Integer hash
        =>  (super of Set<Element>).hash;

    shared actual
    ImmutableSet<Element|Other> union<Other>(Set<Other> set)
            given Other satisfies Object
        =>  package.union(this, set);

    shared actual
    ImmutableSet<Element&Other> intersection<Other>(Set<Other> set)
            given Other satisfies Object
        =>  package.intersection(this, set);

    shared actual
    ImmutableSet<Element> complement<Other>(Set<Other> set)
            given Other satisfies Object
        =>  package.complement(this, set);

    shared actual
    ImmutableSet<Element|Other> exclusiveUnion<Other>(Set<Other> set)
            given Other satisfies Object
        =>  package.exclusiveUnion(this, set);
}
