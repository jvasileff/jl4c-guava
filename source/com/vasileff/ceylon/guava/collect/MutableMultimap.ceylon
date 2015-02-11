import com.google.common.collect {
    GuavaMultimap=Multimap
}

shared
interface MutableMultimap<Key, Item>
        satisfies Multimap<Key, Item> &
                  MultimapMutator<Key, Item>
        given Key satisfies Object {

    shared actual formal
    GuavaMultimap<Key, Item> delegate;

    shared actual formal
    Collection<Item> removeAll(Key key);

    shared actual formal
    Collection<Item> replaceItems(Key key, {Item*} items);

    shared actual
    Boolean remove(Key key, Item item) {
        assert (is Object? item);
        return delegate.remove(key, item);
    }

    shared actual
    void clear()
        =>  delegate.clear();

    shared actual
    Boolean put(Key key, Item item)
        =>  delegate.put(key, item);

    shared actual
    Boolean putAll(Multimap<Key, Item> multimap) {
        variable value result = false;
        for (key->item in multimap) {
            result = put(key, item) || result;
        }
        return result;
    }

    shared actual
    Boolean putMultiple(Key key, {Item*} items) {
        variable value result = false;
        for (item in items) {
            result = put(key, item) || result;
        }
        return result;
    }
}
