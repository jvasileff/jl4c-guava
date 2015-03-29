import ceylon.interop.java {
    CeylonIterable,
    CeylonCollection
}

import com.google.common.collect {
    GuavaImmutableMap=ImmutableMap {
        GIMBuilder=Builder
    }
}

import java.util {
    JMap=Map
}

shared final
class ImmutableMap<out Key, out Item>
        satisfies Map<Key, Item>
        given Key satisfies Object
        given Item satisfies Object {

    shared
    GuavaImmutableMap<out Key, out Item> delegate;

    shared
    new ({<Key->Item>*} entries) {
        value builder = GIMBuilder<Key, Item>();
        for (key->item in entries) {
            builder.put(key, item);
        }
        delegate = builder.build();
    }

    shared
    new Wrap(GuavaImmutableMap<out Key, out Item> delegate) {
        this.delegate = delegate;
    }

    shared actual
    Item? get(Object key)
        =>  delegate.get(key);

    shared actual
    Boolean defines(Object key)
        =>  delegate.containsKey(key);

    shared actual
    Integer size
        =>  delegate.size();

    shared actual
    ImmutableMap<Key,Item> clone()
        =>  this;

    shared actual
    ImmutableSet<Key> keys
        =>  ImmutableSet.Wrap(delegate.keySet());

    shared actual
    Collection<Item> items
        //TODO implement an ImmutableCollection class
        =>  CeylonCollection(delegate.values());

    shared actual
    Iterator<Key->Item> iterator()
        //workaround https://github.com/ceylon/ceylon-compiler/issues/2028
        =>  let (JMap<out Key, out Item> map = delegate)
            CeylonIterable(map.entrySet())
                .map((entry) => entry.key->entry.\ivalue)
                .iterator();

    shared actual
    ImmutableMap<Key, Item> coalescedMap
        =>  this;

    shared actual
    Boolean equals(Object that)
        =>  (super of Map<Key, Item>).equals(that);

    shared actual
    Integer hash
        =>  (super of Map<Key, Item>).hash;

}
