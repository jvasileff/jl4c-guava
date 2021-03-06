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
    Boolean remove(Key key, Item item)
        => delegate.remove(key, item of Object?);

    shared actual
    void clear()
        =>  delegate.clear();

    shared actual
    Boolean put(Key key, Item item)
        =>  delegate.put(key, item);
}
