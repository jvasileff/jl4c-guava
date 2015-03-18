import com.google.common.collect {
    GuavaHashBiMap=HashBiMap {
        ghbmCreate=create
    }
}

shared final
class HashBiMap<Key, Item>
        satisfies MutableBiMap<Key, Item>
        given Key satisfies Object
        given Item satisfies Object {

    shared actual
    GuavaHashBiMap<Key, Item> delegate = ghbmCreate<Key, Item>();

    shared
    new (entries={}) {
        {<Key->Item>*} entries;
        for (key->item in entries) {
            delegate.put(key, item);
        }
    }

    shared actual
    MutableBiMap<Key, Item> clone()
        =>  HashBiMap(this);

    shared actual
    Boolean equals(Object other)
        =>  (super of Map<Key, Item>).equals(other);

    shared actual
    Integer hash
        =>  (super of Map<Key, Item>).hash;
}
