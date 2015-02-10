shared
interface MutableMultimap<Key, Item>
        satisfies Multimap<Key, Item> &
                  MultimapMutator<Key, Item>
        given Key satisfies Object {

    shared actual formal
    Collection<Item> removeAll(Key key);

    shared actual formal
    Collection<Item> replaceItems(Key key, {Item*} items);
}
