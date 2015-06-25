import com.google.common.collect {
    GuavaImmutableMultiset=ImmutableMultiset {
        GIMSBuilder=Builder
    }
}

shared final
class ImmutableMultiset<out Element>
        satisfies Multiset<Element>
        given Element satisfies Object {

    shared actual
    GuavaImmutableMultiset<out Element> delegate;

    shared
    new ({Element*} elements) {
        value builder = GIMSBuilder<Element>();
        for (element in elements) {
            builder.add(element);
        }
        delegate = builder.build();
    }

    shared
    new wrap(GuavaImmutableMultiset<out Element> delegate) {
        this.delegate = delegate;
    }

    shared actual
    ImmutableMultiset<Element> clone()
        =>  ImmutableMultiset(this);
}
