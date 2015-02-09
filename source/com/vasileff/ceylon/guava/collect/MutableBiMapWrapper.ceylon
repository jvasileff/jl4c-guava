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

shared sealed
class MutableBiMapWrapper<Key, Item>
        satisfies MutableBiMap<Key, Item>
        given Key satisfies Object
        given Item satisfies Object {

    GuavaBiMap<Key, Item> delegate;

    shared
    new MutableBiMapWrapper(GuavaBiMap<Key, Item> delegate, entries={}) {
        {<Key->Item>*} entries;
        this.delegate = delegate;
        for (key->item in entries) {
            delegate.put(key, item);
        }        
    }

    shared actual
    Item? put(Key key, Item item)
        =>  delegate.put(key, item);

    shared actual
    Item? forcePut(Key key, Item item)
        =>  delegate.forcePut(key, item);

    shared actual
    Item? remove(Key key)
        =>  delegate.remove(key);

    shared actual
    void clear()
        =>  delegate.clear();

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
    MutableBiMap<Item, Key> inverse
        =>  package.MutableBiMapWrapper<Item, Key>(delegate.inverse());

    shared actual
    MutableBiMap<Key, Item> clone()
        =>  HashBiMap<Key, Item>(this);

    //TODO implement "keys"; see ImmutableMap

    shared actual
    Set<Item> items
        //Would be nice to have mutable view
        =>  CeylonSet(delegate.values());

    shared actual
    Iterator<Key->Item> iterator()
            //workaround https://github.com/ceylon/ceylon-compiler/issues/2028
        =>  let (JMap<out Key, out Item> map = delegate)
            CeylonIterable(map.entrySet())
                .map((entry) => entry.key->entry.\ivalue)
                .iterator();

    shared actual
    Map<Key, Item> coalescedMap
        //Leave options open and don't return MutableBiMap<Key,Item> since
        //Guava's HashBiMap actually allows nulls (even though we don't)
        =>  this;

    shared actual
    Boolean equals(Object that)
        =>  (super of Map<Key, Item>).equals(that);

    shared actual
    Integer hash
        =>  (super of Map<Key, Item>).hash;

}