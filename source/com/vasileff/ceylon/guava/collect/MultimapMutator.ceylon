shared interface
MultimapMutator<in Key, in Item>
        satisfies Multimap<Object, Anything>
        given Key satisfies Object {

    shared formal
    void clear();

    shared formal
    Boolean put(Key key, Item item);

    shared formal
    Boolean putMultiple(Key key, {Item*} items);

    shared formal
    Boolean putAll(Multimap<Key, Item> multimap);

    shared formal
    // TODO Objects in Guava interface???
    Boolean remove(Key key, Item item);

    shared formal
    // TODO Object param in Guava, remember return val
    Collection<Anything> removeAll(Key key);

    shared formal
    Collection<Anything> replaceItems(Key key, {Item*} items);

    "Returns the number of key-value pairs in this multimap."
    shared actual formal
    Integer size;
}
