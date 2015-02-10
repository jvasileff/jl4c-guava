shared
interface MutableSetMultimap<Key, Item>
        satisfies SetMultimap<Key, Item> &
                  SetMultimapMutator<Key, Item> &
                  MutableMultimap<Key, Item>
        given Key satisfies Object
        given Item satisfies Object {

    shared actual formal
    Set<Item> removeAll(Key key);

    shared actual formal
    Set<Item> replaceItems(Key key, {Item*} items);
}
