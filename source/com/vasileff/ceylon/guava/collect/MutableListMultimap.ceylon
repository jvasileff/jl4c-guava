shared
interface MutableListMultimap<Key, Item>
        satisfies ListMultimap<Key, Item> &
                  ListMultimapMutator<Key, Item> &
                  MutableMultimap<Key, Item>
        given Key satisfies Object
        given Item satisfies Object {

    shared actual formal
    List<Item> removeAll(Key key);

    shared actual formal
    List<Item> replaceItems(Key key, {Item*} items);
}
