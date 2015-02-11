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

/*
    Why this wrapper? Well..

        - The inverse function needs a wrapper
        - HashBiMap doesn't want to be that wrapper
        - Having something like "class MutableBiMap" w/constructors
          Wrapper, Hash, etc, might work, but wouldn't be consistent
          with the rest of the api.
*/

class MutableBiMapWrapper<Key, Item>(delegate)
        satisfies MutableBiMap<Key, Item>
        given Key satisfies Object
        given Item satisfies Object {

    GuavaBiMap<Key, Item> delegate;

    put(Key key, Item item) => delegate.put(key, item);

    forcePut(Key key, Item item) => delegate.forcePut(key, item);

    remove(Key key) => delegate.remove(key);

    clear() => delegate.clear();

    get(Object key) => delegate.get(key);

    defines(Object key) => delegate.containsKey(key);

    size => delegate.size();

    inverse => MutableBiMapWrapper(delegate.inverse());

    clone() => HashBiMap<Key, Item>(this);

    //TODO implement "keys"; see ImmutableMap

    //Would be nice to have mutable view
    items => CeylonSet(delegate.values());

    //Leave options open and don't return MutableBiMap<Key,Item> since
    //Guava's HashBiMap actually allows nulls (even though we don't)
    coalescedMap => this;

    iterator()
        //workaround https://github.com/ceylon/ceylon-compiler/issues/2028
        =>  let (JMap<out Key, out Item> map = delegate)
            CeylonIterable(map.entrySet())
                .map((entry) => entry.key->entry.\ivalue)
                .iterator();

    equals(Object that) => (super of Map<Key, Item>).equals(that);

    hash => (super of Map<Key, Item>).hash;

}
