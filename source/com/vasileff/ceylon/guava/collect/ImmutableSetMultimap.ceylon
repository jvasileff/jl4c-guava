import com.google.common.collect {
    GuavaImmutableSetMultimap=ImmutableSetMultimap {
        GISMMBuilder=Builder
    }
}
import com.vasileff.ceylon.guava.collect {
    TypeHoles {
        unsafeCast
    }
}

shared final
class ImmutableSetMultimap<out Key, out Item>
    ({<Key->Item>*}|GuavaImmutableSetMultimap<out Key, out Item> entries)
    satisfies SetMultimap<Key, Item> &
              ImmutableMultimap<Key, Item>
    given Key satisfies Object
    given Item satisfies Object {

    shared actual
    GuavaImmutableSetMultimap<out Key, out Item> delegate;

    if (is {<Key->Item>*} entries) {
        value builder = GISMMBuilder<Key, Item>();
        for (key->item in entries) {
            builder.put(key, item);
        }
        delegate = builder.build();
    }
    else {
        delegate = entries;
    }

    shared actual
    ImmutableSet<Item> get(Object key)
        // Stupid google. Get takes K, not Object
        //=>  ImmutableSet(delegate.get(key));
        =>  ImmutableSet(unsafeCast
                <GuavaImmutableSetMultimap<Object, out Item>>
                (delegate).get(key));

    shared actual
    ImmutableSetMultimap<Key, Item> clone()
        =>  this;

    shared actual
    Boolean equals(Object that)
        // FIXME review all equals/hash
        =>  if (is ImmutableSetMultimap<Anything, Anything> that)
            then this.delegate == that.delegate
            else (super of Set<Key->Item>).equals(that);

    shared actual
    Integer hash
        =>  (super of Set<Key->Item>).hash;
}
