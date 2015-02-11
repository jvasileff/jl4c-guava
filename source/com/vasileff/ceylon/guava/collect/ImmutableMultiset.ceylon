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

    shared actual
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
    ImmutableMultiset<Element> clone()
        =>  ImmutableMultiset(this);
}
