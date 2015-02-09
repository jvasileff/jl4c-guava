import ceylon.interop.java {
    CeylonIterable,
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
    JSet=Set,
    JMap=Map {
        JMapEntry=Entry
    }
}

shared final
class ImmutableSetMultimap<out Key, out Item>
    ({<Key->Item>*}|GuavaImmutableSetMultimap<out Key, out Item> entries)
    satisfies SetMultimap<Key, Item>
    given Key satisfies Object
    given Item satisfies Object {

    shared
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
    Boolean contains(Object entry)
        =>  if (is Key->Item entry)
            then delegate.containsEntry(entry.key, entry.item)
            else false;

    shared actual
    Boolean containsItem(Object item)
        =>  delegate.containsValue(item);

    shared actual
    Boolean defines(Object key)
        =>  delegate.containsKey(key);

    shared actual
    Boolean empty
        =>  delegate.empty;

    shared actual
    ImmutableSet<Item> get(Object key)
        // Stupid google. Get takes K, not Object
        //=>  ImmutableSet(delegate.get(key));
        =>  ImmutableSet(unsafeCast
                <GuavaImmutableSetMultimap<Object, out Item>>
                (delegate).get(key));

    shared actual
    {Item*} items
        =>  CeylonIterable(delegate.values());

    shared actual
    Iterator<Key->Item> iterator()
            // workaround https://github.com/ceylon/ceylon-compiler/issues/2028
        =>  let (JSet<out JMapEntry<out Key,out Item>> set = delegate.entries())
            CeylonIterable(set)
                .map((entry) => entry.key->entry.\ivalue)
                .iterator();

    shared actual
    ImmutableSet<Key> keySet
        =>  ImmutableSet(delegate.keySet());

    shared actual
    ImmutableMultiset<Key> keys
        =>  ImmutableMultiset(delegate.keys());

    shared actual
    Integer size
        =>  delegate.size();

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
}
