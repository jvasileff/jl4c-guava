import ceylon.interop.java {
    CeylonIterable
}

import com.google.common.collect {
    GuavaImmutableBiMap=ImmutableBiMap {
        GIBMBuilder=Builder
    }
}

import java.util {
    JMap=Map
}

shared final
throws(`class Exception`, "Throws exception when entries includes
                           duplicate keys or items.")
class ImmutableBiMap<out Key, out Item>
        ({<Key->Item>*}|GuavaImmutableBiMap<out Key, out Item> entries)
        satisfies BiMap<Key, Item>
        given Key satisfies Object
        given Item satisfies Object {

    shared
    GuavaImmutableBiMap<out Key, out Item> delegate;

    if (is {<Key->Item>*} entries) {
        value builder = GIBMBuilder<Key, Item>();
        for (entry in entries) {
            builder.put(entry.key, entry.item); // TODO fails/exception???
        }
        delegate = builder.build();
    }
    else {
        delegate = entries;
    }

    shared actual
    Boolean contains(Object entry)
        =>  delegate.containsValue(entry);

    shared actual
    Boolean defines(Object key)
        =>  delegate.containsKey(key);

    shared actual
    Item? get(Object key)
        =>  delegate.get(key);

    shared actual
    ImmutableBiMap<Item,Key> inverse
        =>  ImmutableBiMap(delegate.inverse());

    shared actual
    ImmutableSet<Item> items
        =>  ImmutableSet(delegate.values());

    shared actual
    Iterator<Key->Item> iterator()
            // workaround https://github.com/ceylon/ceylon-compiler/issues/2028
        =>  let (JMap<out Key, out Item> map = delegate)
            CeylonIterable(map.entrySet())
                .map((entry) => entry.key->entry.\ivalue)
                .iterator();

    shared actual
    Map<Key,Item> clone()
        =>  this;

    shared actual
    Boolean equals(Object that)
        =>  (super of Map<Key, Item>).equals(that);

    shared actual
    Integer hash
        =>  (super of Map<Key, Item>).hash;
}
