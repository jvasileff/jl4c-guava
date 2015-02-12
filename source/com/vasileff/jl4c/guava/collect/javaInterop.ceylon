import java.util {
    JSet=Set,
    JMap=Map,
    JList=List
}

shared
JList<Element> unwrapList<Element>
        (ImmutableList<Element> list)
        given Element satisfies Object
    =>  TypeHoles.unsafeCast<JList<Element>>(list.delegate);

shared
JSet<Element> unwrapSet<Element>
        (ImmutableSet<Element> set)
        given Element satisfies Object
    =>  TypeHoles.unsafeCast<JSet<Element>>(set.delegate);

shared
JMap<Key, Item> unwrapMap<Key, Item>
        (ImmutableMap<Key, Item>|ImmutableBiMap<Key, Item> map)
        given Key satisfies Object
        given Item satisfies Object
    =>  if (is ImmutableMap<Key, Item> map)
        then TypeHoles.unsafeCast<JMap<Key, Item>>(map.delegate)
        else TypeHoles.unsafeCast<JMap<Key, Item>>(map.delegate);

shared
JList<Element> javaList<Element>({Element*} elements)
        given Element satisfies Object
    =>  unwrapList(ImmutableList(elements));

shared
JSet<Element> javaSet<Element>({Element*} elements)
        given Element satisfies Object
    =>  unwrapSet(ImmutableSet(elements));

shared
JMap<Key, Item> javaMap<Key, Item>({<Key->Item>*} entries)
        given Key satisfies Object
        given Item satisfies Object
    =>  unwrapMap(ImmutableMap(entries));
