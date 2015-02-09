import ceylon.interop.java {
    CeylonSet,
    CeylonIterator
}

import com.google.common.collect {
    GuavaImmutableMultiset=ImmutableMultiset {
        GIMSBuilder=Builder
    }
}

shared final
class ImmutableMultiset<out Element>
        ({Element*}|GuavaImmutableMultiset<out Element> es)
        satisfies Multiset<Element>
        given Element satisfies Object {

    shared
    GuavaImmutableMultiset<out Element> delegate;

    // TODO use named constructors when possible 
    // https://github.com/ceylon/ceylon-spec/issues/1225
    if (is {Element*} es) {
        value builder = GIMSBuilder<Element>();
        for (element in es) {
            builder.add(element);
        }
        delegate = builder.build();        
    }
    else {
        delegate = es;
    }

    shared actual
    Set<Element> elements
        =>  CeylonSet<Element>(delegate.elementSet());

    shared actual
    Integer occurences(Object element)
        =>  delegate.count(element);

    shared actual
    Boolean contains(Object element)
        =>  delegate.contains(element);

    shared actual
    Iterator<Element> iterator()
        =>  CeylonIterator(delegate.iterator());

    shared actual
    Set<[Element, Integer]> entries = object
            satisfies Set<[Element, Integer]> {

        shared actual
        Boolean contains(Object element)
            =>  if (is [Element, Integer] element)
                then occurences(element[0]) == element[1]
                else false;

        shared actual
        ImmutableSet<[Element, Integer]|Other> union<Other>(Set<Other> set)
                given Other satisfies Object
            =>  package.union(this, set);
    
        shared actual
        ImmutableSet<[Element, Integer]&Other> intersection<Other>(Set<Other> set)
                given Other satisfies Object
            =>  package.intersection(this, set);
    
        shared actual
        ImmutableSet<[Element, Integer]> complement<Other>(Set<Other> set)
                given Other satisfies Object
            =>  package.complement(this, set);
    
        shared actual
        ImmutableSet<[Element, Integer]|Other> exclusiveUnion<Other>(Set<Other> set)
                given Other satisfies Object
            =>  package.exclusiveUnion(this, set);

        shared actual
        Iterator<[Element, Integer]> iterator()
            =>  elements
                    .map((element) => [element, occurences(element)])
                    .iterator();

        shared actual
        ImmutableSet<[Element, Integer]> clone()
            =>  ImmutableSet(this);

        shared actual
        Boolean equals(Object that)
            =>  (super of Set<[Element, Integer]>).equals(that);

        shared actual
        Integer hash
            =>  (super of Set<[Element, Integer]>).hash;
    };

    shared actual
    ImmutableMultiset<Element> clone()
        =>  ImmutableMultiset(this);
}
