import com.google.common.collect {
    GuavaHashBiMap=HashBiMap {
        ghbmCreate=create
    }
}

shared final
class HashBiMap<Key, Item>
        (entries={})
        satisfies MutableBiMap<Key, Item>
        given Key satisfies Object
        given Item satisfies Object {

    MutableBiMap<Key, Item> delegate;

    //see https://github.com/ceylon/ceylon-spec/issues/1227
    shared
    //new HashBiMap(entries={}) {
        {<Key->Item>*} entries;
        this.delegate = MutableBiMapWrapper(ghbmCreate<Key, Item>());
        for (key->item in entries) {
            delegate.put(key, item);
        }
    //}

    clear() => delegate.clear();

    clone() => delegate.clone();

    coalescedMap => delegate.coalescedMap;

    defines(Object key) => delegate.defines(key);

    forcePut(Key key, Item item) => delegate.forcePut(key, item);

    get(Object key) => delegate.get(key);

    inverse => delegate.inverse;

    items => delegate.items;

    iterator() => delegate.iterator();

    put(Key key, Item item) => delegate.put(key, item);

    remove(Key key) => delegate.remove(key);

    size => delegate.size;

    equals(Object other) => delegate.equals(other);

    hash => delegate.hash;

}
