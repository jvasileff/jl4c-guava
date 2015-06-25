import com.google.common.collect {
    GuavaImmutableList=ImmutableList {
        GILBuilder=Builder
    }
}

shared final
class ImmutableListBuilder<Element>()
        given Element satisfies Object {

    value builder = GILBuilder<Element>();

    shared
    ImmutableListBuilder<Element> add(Element element) {
        builder.add(element);
        return this;
    }

    shared
    ImmutableListBuilder<Element> addAll({Element*} elements) {
        elements.each(add);
        return this;
    }

    shared
    ImmutableList<Element> build()
        =>  ImmutableList.wrap(builder.build());
}
