import ceylon.collection {
    MutableMap
}
import com.google.common.collect {
    GuavaBiMap=BiMap
}

shared
interface MutableBiMap<Key, Item>
        satisfies BiMap<Key, Item> &
                  BiMapMutator<Key, Item> &
                  MutableMap<Key, Item>
        given Key satisfies Object
        given Item satisfies Object {

    shared actual formal
    GuavaBiMap<Key, Item> delegate;

    shared actual
    Item? put(Key key, Item item)
        =>  delegate.put(key, item);

    shared actual
    Item? forcePut(Key key, Item item)
        =>  delegate.forcePut(key, item);

    shared actual
    Item? remove(Key key)
        =>  delegate.remove(key);

    shared actual
    void clear()
        => delegate.clear();

    shared actual
    MutableBiMap<Item, Key> inverse
        =>  MutableBiMapWrapper(delegate.inverse());

    shared actual formal
    MutableBiMap<Key, Item> clone();
}
