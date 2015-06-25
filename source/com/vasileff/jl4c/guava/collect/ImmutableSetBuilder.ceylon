import com.google.common.collect {
    GuavaImmutableSet=ImmutableSet {
        GISBuilder=Builder
    }
}

shared final
class ImmutableSetBuilder<Element>()
        given Element satisfies Object {
 
    value delegate = GISBuilder<Element>();

    shared
    ImmutableSetBuilder<Element> add(Element* elements) {
        for (element in elements) {
            delegate.add(element);
        }
        return this;
    }

    shared
    ImmutableSetBuilder<Element> addAll({Element*}* elements) {
        for (it in elements) {
            for (element in it) {
                delegate.add(element);
            }
        }
        return this;
    }

    shared
    ImmutableSet<Element> build()
        =>  ImmutableSet.wrap(delegate.build());
}
