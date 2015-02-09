import ceylon.interop.java {
    CeylonMap,
    CeylonSet
}

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

import java.util {
    JSet=Set
}

shared final
class ImmutableSetMultimap<out Key, out Item>
    ({<Key->Item>*}|GuavaImmutableSetMultimap<out Key, out Item> entries)
    satisfies SetMultimap<Key, Item> & ImmutableMultimap<Key, Item>
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
    Map<Key,Set<Item>> asMap
        =>  CeylonMap(delegate.asMap()).mapItems((key, items)
                =>  // Gauva apidocs guarantee items will be a JSet
                    let (itemsSet = unsafeCast<JSet<out Item>>(items))
                    CeylonSet<Item>(itemsSet));

    shared actual
    ImmutableSet<Item> get(Object key)
        // Stupid google. Get takes K, not Object
        //=>  ImmutableSet(delegate.get(key));
        =>  ImmutableSet(unsafeCast
                <GuavaImmutableSetMultimap<Object, out Item>>
                (delegate).get(key));

    shared actual
    Set<<Key->Item>|Other> union<Other>(Set<Other> set)
            given Other satisfies Object
        =>  package.union(this, set);

    shared actual
    Set<<Key->Item>&Other> intersection<Other>(Set<Other> set)
            given Other satisfies Object
        =>  package.intersection(this, set);

    shared actual
    Set<Key->Item> complement<Other>(Set<Other> set)
            given Other satisfies Object
            // Consider returning an ImmutableSetMultimap
        =>  package.complement(this, set);

    shared actual
    Set<<Key->Item>|Other> exclusiveUnion<Other>(Set<Other> set)
            given Other satisfies Object
        =>  package.exclusiveUnion(this, set);

    shared actual
    Set<Key->Item> clone()
        =>  this;

    shared actual
    Boolean equals(Object that)
        =>  if (is ImmutableSetMultimap<Anything, Anything> that)
            then this.delegate == that.delegate
            else (super of Set<Key->Item>).equals(that);

    shared actual
    Integer hash
        =>  (super of Set<Key->Item>).hash;

    shared actual
    Boolean contains(Object entry)
        =>  (super of ImmutableMultimap<Key, Item>).contains(entry);

}
