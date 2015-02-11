import ceylon.collection {
    MapMutator
}

shared
interface BiMapMutator<in Key, in Item>
        satisfies MapMutator<Key, Item> &
                  BiMap<Object, Object>
        given Key satisfies Object
        given Item satisfies Object {

    "An alternate form of put that silently removes any existing entry with the item
     `item` before proceeding with the `put(Key, Item)` operation. If the bimap
     previously contained the provided key-value mapping, this method has no effect."
    shared formal
    Anything forcePut(Key key, Item item);

    throws(`class Exception`,
        "if the given `item` is already bound to a different key in this bimap. The
         bimap will remain unmodified in this event. To avoid this exception, call
         forcePut(Key, Item) instead.")
    shared actual formal
    Anything put(Key key, Item item);

    throws(`class Exception`,
        "if an attempt to put any entry fails. Note that some map entries may have been
         added to the bimap before the exception was thrown.")
    shared actual default
    void putAll({<Key->Item>*} entries)
        =>  super.putAll(entries);
}