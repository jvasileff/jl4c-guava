interface AbstractSet<Element>
        satisfies Set<Element>
        given Element satisfies Object {

    shared actual formal
    Integer size;

    shared actual default
    ImmutableSet<Element|Other> union<Other>(Set<Other> set)
            given Other satisfies Object
        =>  package.union(this, set);

    shared actual default
    ImmutableSet<Element&Other> intersection<Other>(Set<Other> set)
            given Other satisfies Object
        =>  package.intersection(this, set);

    shared actual default
    ImmutableSet<Element> complement<Other>(Set<Other> set)
            given Other satisfies Object
        =>  package.complement(this, set);

    shared actual default
    ImmutableSet<Element|Other> exclusiveUnion<Other>(Set<Other> set)
            given Other satisfies Object
        =>  package.exclusiveUnion(this, set);

    shared actual default
    ImmutableSet<Element> clone()
        =>  ImmutableSet(this);
}

ImmutableSet<First|Second> union<First, Second>
        (Set<First> first, Set<Second> second)
        given First satisfies Object
        given Second satisfies Object
    =>  ImmutableSetBuilder<First|Second>()
            .addAll(first)
            .addAll(second)
            .build();

ImmutableSet<First&Second> intersection<First, Second>
        (Set<First> first, Set<Second> set)
        given First satisfies Object
        given Second satisfies Object {
    value builder = ImmutableSetBuilder<First&Second>();
    for (element in first) {
        if (is Second element, set.contains(element)) {
            builder.add(element);
        }
    }
    return builder.build();
}

ImmutableSet<First> complement<First, Second>
        (Set<First> first, Set<Second> second)
        given First satisfies Object
        given Second satisfies Object {
    value builder = ImmutableSetBuilder<First>();
    for (element in first) {
        if (!second.contains(element)) {
            builder.add(element);
        }
    }
    return builder.build();
}

ImmutableSet<First|Second> exclusiveUnion<First, Second>
        (Set<First> first, Set<Second> second)
        given First satisfies Object
        given Second satisfies Object {
    value builder = ImmutableSetBuilder<First|Second>();
    for (element in first) {
        if (!second.contains(element)) {
            builder.add(element);
        }
    }
    for (element in second) {
        if (!first.contains(element)) {
            builder.add(element);
        }
    }
    return builder.build();
}
