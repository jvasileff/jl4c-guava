import ceylon.collection {
    MutableMap
}

shared
interface MutableBiMap<Key, Item>
        satisfies BiMap<Key, Item> &
                  BiMapMutator<Key, Item> &
                  MutableMap<Key, Item>
        given Key satisfies Object
        given Item satisfies Object {

    shared actual formal
    Item? put(Key key, Item item);

    shared actual formal
    Item? forcePut(Key key, Item item);

    shared actual formal
    Item? remove(Key key);

    shared actual formal
    MutableBiMap<Key, Item> clone();

    shared actual formal
    MutableBiMap<Item, Key> inverse;

}