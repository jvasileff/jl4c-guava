import ceylon.interop.java {
    CeylonSet,
    CeylonIterable
}

import com.google.common.collect {
    GuavaBiMap=BiMap
}

import java.util {
    JMap=Map
}

shared
interface BiMap<out Key, out Item>
        satisfies Map<Key, Item>
        given Key satisfies Object
        given Item satisfies Object {

    shared formal
    GuavaBiMap<out Key, out Item> delegate;

    shared actual
    Item? get(Object key)
        =>  delegate.get(key);

    shared actual
    Boolean defines(Object key)
        =>  delegate.containsKey(key);

    shared actual default
    Set<Key> keys
        // TODO mutable view for MutableBiMap
        =>  CeylonSet(delegate.keySet());

    shared actual default
    Set<Item> items
        // TODO mutable view for MutableBiMap
        =>  CeylonSet(delegate.values());

    //Leave options open and don't return MutableBiMap<Key,Item> since
    //Guava's HashBiMap actually allows nulls (even though we don't)
    shared actual
    BiMap<Key, Item> coalescedMap
        =>  this;

    shared actual
    Integer size
        =>  delegate.size();

    shared actual
    Iterator<Key->Item> iterator()
        //workaround https://github.com/ceylon/ceylon-compiler/issues/2028
        =>  let (JMap<out Key, out Item> map = delegate)
            CeylonIterable(map.entrySet())
                .map((entry) => entry.key->entry.\ivalue)
                .iterator();

    shared formal
    BiMap<Item, Key> inverse;
}
