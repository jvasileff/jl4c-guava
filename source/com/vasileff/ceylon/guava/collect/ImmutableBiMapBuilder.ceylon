import com.google.common.collect {
    GuavaImmutableBiMap=ImmutableBiMap {
        GIBMBuilder=Builder
    }
}

shared
class ImmutableBiMapBuilder<Key, Item>()
    given Key satisfies Object
    given Item satisfies Object {

    value delegate = GIBMBuilder<Key, Item>();

    shared
    ImmutableBiMapBuilder<Key, Item> put(Key key, Item item) {
        delegate.put(key, item);
        return this;
    }

    shared
    ImmutableBiMapBuilder<Key, Item> putAll({<Key->Item>*} entries) {
        for (entry in entries) {
            delegate.put(entry.key, entry.item);
        }
        return this;
    }

    shared
    throws(`class Exception`, "Throws exception when entries includes
                               duplicate keys or items.")
    ImmutableBiMap<Key, Item> build()
        // TODO: consider returning null on error, but nice thing about
        // exception is info about duplicate keys
        =>  ImmutableBiMap(delegate.build());
}
