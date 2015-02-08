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
