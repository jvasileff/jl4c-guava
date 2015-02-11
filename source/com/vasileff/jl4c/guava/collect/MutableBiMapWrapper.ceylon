import com.google.common.collect {
    GuavaBiMap=BiMap
}

class MutableBiMapWrapper<Key, Item>(delegate)
        satisfies MutableBiMap<Key, Item>
        given Key satisfies Object
        given Item satisfies Object {

    shared actual
    GuavaBiMap<Key, Item> delegate;

    shared actual
    MutableBiMap<Key, Item> clone()
        =>  HashBiMap<Key, Item>(this);

    shared actual
    Boolean equals(Object other)
        =>  (super of Map<Key, Item>).equals(other);

    shared actual
    Integer hash
        =>  (super of Map<Key, Item>).hash;
}
