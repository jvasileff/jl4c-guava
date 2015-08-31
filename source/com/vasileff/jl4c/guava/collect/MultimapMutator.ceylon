shared
interface MultimapMutator<in Key, in Item>
        satisfies Multimap<Object, Anything>
        given Key satisfies Object {

    shared formal
    void clear();

    shared formal
    Boolean put(Key key, Item item);

    shared default
    Boolean putEntry(Key->Item entry)
        =>  put(entry.key, entry.item);

    shared formal
    Boolean putMultiple(Key key, {Item*} items);

    shared formal
    Boolean putAll({<Key->Item>*} entries);

    shared formal
    // TODO Objects in Guava interface???
    Boolean remove(Key key, Item item);

    shared default
    Boolean removeEntry(Key->Item entry)
        =>  remove(entry.key, entry.item);

    shared formal
    // TODO Object param in Guava, remember return val
    Collection<Anything> removeAll(Key key);

    shared formal
    Collection<Anything> replaceItems(Key key, {Item*} items);
}
