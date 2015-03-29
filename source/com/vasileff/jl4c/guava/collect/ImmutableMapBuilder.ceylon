import com.google.common.collect {
    GuavaImmutableMap=ImmutableMap {
        GIMBuilder=Builder
    }
}

shared final
class ImmutableMapBuilder<Key, Item>()
        given Key satisfies Object
        given Item satisfies Object {

    value delegate = GIMBuilder<Key, Item>();

    shared
    ImmutableMapBuilder<Key, Item> put(Key key, Item item) {
        delegate.put(key, item);
        return this;
    }

    shared
    ImmutableMapBuilder<Key, Item> putAll({<Key->Item>*} entries) {
        for (key->item in entries) {
            delegate.put(key, item);
        }
        return this;
    }

    shared
    ImmutableMap<Key, Item> build()
        =>  ImmutableMap.Wrap(delegate.build());
}
