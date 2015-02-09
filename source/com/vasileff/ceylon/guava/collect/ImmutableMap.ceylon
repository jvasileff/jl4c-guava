import ceylon.interop.java {
    CeylonIterable
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
        ({<Key->Item>*}|GuavaImmutableMap<out Key, out Item> entries)
        satisfies Map<Key, Item>
        given Key satisfies Object
        given Item satisfies Object {

    shared
    GuavaImmutableMap<out Key, out Item> delegate;

    if (is {<Key->Item>*} entries) {
        value builder = GIMBuilder<Key, Item>();
        for (key->item in entries) {
            builder.put(key, item);
        }
        delegate = builder.build();
    }
    else {
        delegate = entries;
    }

    // TODO more methods?

    shared actual
    Boolean contains(Object key)
        =>  delegate.containsValue(key);

    shared actual
    Boolean defines(Object key)
        =>  delegate.containsKey(key);

    shared actual
    Item? get(Object key)
        =>  delegate.get(key);

    shared actual
    Iterator<Key->Item> iterator()
            // workaround https://github.com/ceylon/ceylon-compiler/issues/2028
        =>  let (JMap<out Key, out Item> map = delegate)
            CeylonIterable(map.entrySet())
                .map((entry) => entry.key->entry.\ivalue)
                .iterator();

    shared actual
    ImmutableMap<Key,Item> clone()
        =>  this;

    shared actual
    Boolean equals(Object that)
        =>  if (is ImmutableMap<Anything, Anything> that)
            then delegate == that.delegate
            else false;

    shared actual
    Integer hash
        =>  delegate.hash;

}
