import com.google.common.collect {
    GuavaImmutableBiMap=ImmutableBiMap {
        GIBMBuilder=Builder
    }
}

shared final
throws(`class Exception`, "Throws exception when entries includes
                           duplicate keys or items.")
class ImmutableBiMap<out Key, out Item>
        ({<Key->Item>*}|GuavaImmutableBiMap<out Key, out Item> entries)
        satisfies BiMap<Key, Item>
        given Key satisfies Object
        given Item satisfies Object {

    shared actual
    GuavaImmutableBiMap<out Key, out Item> delegate;

    if (is {<Key->Item>*} entries) {
        value builder = GIBMBuilder<Key, Item>();
        for (entry in entries) {
            builder.put(entry.key, entry.item);
        }
        delegate = builder.build();
    }
    else {
        delegate = entries;
    }

    shared actual
    ImmutableSet<Key> keys
        =>  ImmutableSet(delegate.keySet());

    shared actual
    ImmutableSet<Item> items
        =>  ImmutableSet(delegate.values());

    shared actual
    ImmutableBiMap<Item,Key> inverse
        =>  ImmutableBiMap(delegate.inverse());

    shared actual
    ImmutableBiMap<Key,Item> clone()
        =>  this;

    shared actual
    Boolean equals(Object that)
        =>  (super of Map<Key, Item>).equals(that);

    shared actual
    Integer hash
        =>  (super of Map<Key, Item>).hash;
}
