import com.google.common.collect {
    GuavaImmutableSetMultimap=ImmutableSetMultimap {
        GISMMBuilder=Builder
    }
}

shared
class ImmutableSetMultimapBuilder<Key, Item>()
        given Key satisfies Object
        given Item satisfies Object {

    value delegate = GISMMBuilder<Key, Item>();

    shared ImmutableSetMultimapBuilder<Key, Item> put(Key key, Item item) {
        delegate.put(key, item);
        return this;
    }

    shared ImmutableSetMultimapBuilder<Key, Item> putMultiple(Key key, Item* items) {
        for (item in items) {
            delegate.put(key, item);
        }
        return this;
    }

    shared ImmutableSetMultimapBuilder<Key, Item> putAll({<Key->Item>*} entries) {
        // possible optimization opportunity when entries is an ImmutableSetMultimap
        for (entry in entries) {
            delegate.put(entry.key, entry.item);
        }
        return this;
    }

    shared ImmutableSetMultimapBuilder<Key, Item> orderKeysBy(compare) {
        Comparison compare(Key x, Key y);
        delegate.orderKeysBy(JavaComparator(compare));
        return this;
    }

    shared ImmutableSetMultimapBuilder<Key, Item> orderItemsBy(compare) {
        Comparison compare(Item x, Item y);
        delegate.orderValuesBy(JavaComparator(compare));
        return this;
    }

    shared ImmutableSetMultimap<Key, Item> build()
        =>  ImmutableSetMultimap(delegate.build());
}