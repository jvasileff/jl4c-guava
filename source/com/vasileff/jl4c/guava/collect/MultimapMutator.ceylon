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

    shared default
    Boolean putEntries({<Key->Item>*} entries) {
        variable value result = false;
        for (key->item in entries) {
            result = put(key, item) || result;
        }
        return result;
    }

    shared default
    Boolean putMultiple(Key key, {Item*} items) {
        variable value result = false;
        for (item in items) {
            result = put(key, item) || result;
        }
        return result;
    }

    shared formal
    Boolean remove(Key key, Item item);

    shared default
    Boolean removeEntry(Key->Item entry)
        =>  remove(entry.key, entry.item);

    shared default
    Boolean removeEntries({<Key->Item>*} entries) {
        variable value result = false;
        for (key->item in entries) {
            result = remove(key, item) || result;
        }
        return result;
    }

    shared formal
    // TODO Object param in Guava, remember return val
    Collection<Anything> removeAll(Key key);

    shared formal
    Collection<Anything> replaceItems(Key key, {Item*} items);
}
