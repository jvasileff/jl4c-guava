import ceylon.interop.java {
    CeylonMap
}

import com.google.common.collect {
    GuavaImmutableListMultimap=ImmutableListMultimap {
        GILMMBuilder=Builder
    }
}
import com.vasileff.ceylon.guava.collect {
    TypeHoles {
        unsafeCast
    }
}

shared final
class ImmutableListMultimap<out Key, out Item>
    ({<Key->Item>*}|GuavaImmutableListMultimap<out Key, out Item> entries)
    satisfies ListMultimap<Key, Item> &
              ImmutableMultimap<Key, Item>
    given Key satisfies Object
    given Item satisfies Object {

    shared actual
    GuavaImmutableListMultimap<out Key, out Item> delegate;

    if (is {<Key->Item>*} entries) {
        value builder = GILMMBuilder<Key, Item>();
        for (key->item in entries) {
            builder.put(key, item);
        }
        delegate = builder.build();
    }
    else {
        delegate = entries;
    }

    shared actual
    Map<Key, Collection<Item>> asMap
        =>  CeylonMap(delegate.asMap()).mapItems((key, items)
                =>  CeylonCollection<Item>(items));

    shared actual
    ImmutableList<Item> get(Object key)
        // Stupid google. Get takes K, not Object
        //=>  ImmutableList(delegate.get(key));
        =>  ImmutableList(unsafeCast
                <GuavaImmutableListMultimap<Object, out Item>>
                (delegate).get(key));

    shared actual
    ImmutableListMultimap<Key, Item> clone()
        =>  this;

    // FIXME implement equals & hash in ListMultimap per Ceylon contract
    //shared actual
    //Boolean equals(Object that)
    //    =>  if (is ImmutableSetMultimap<Anything, Anything> that)
    //        then this.delegate == that.delegate
    //        else (super of Collection<Key->Item>).equals(that);

    //shared actual
    //Integer hash
    //    =>  (super of Collection<Key->Item>).hash;

}
