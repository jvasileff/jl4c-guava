import com.google.common.collect {
    GuavaImmutableMultiset=ImmutableMultiset {
        GIMSBuilder=Builder
    }
}

shared final
class ImmutableMultisetBuilder<Element>()
        given Element satisfies Object {

    value delegate = GIMSBuilder<Element>();

    shared
    ImmutableMultisetBuilder<Element> add(Element element) {
        delegate.add(element);
        return this;
    }

    shared
    ImmutableMultisetBuilder<Element> addCopies(Element element, Integer occurrences) {
        delegate.addCopies(element, occurrences);
        return this;
    }

    shared
    ImmutableMultisetBuilder<Element> addAll({Element*} elements) {
        elements.each(add);
        return this;
    }

    shared
    ImmutableMultisetBuilder<Element> setOccurances(
            Element element, Integer occurrences) {
        delegate.setCount(element, occurrences);
        return this;
    }

    shared
    ImmutableMultiset<Element> build()
        => ImmutableMultiset(delegate.build());
}
