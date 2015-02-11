import ceylon.interop.java {
    CeylonMap,
    CeylonSet,
    CeylonIterable,
    JavaIterable
}

import com.google.common.collect {
    GuavaHashMultimap=HashMultimap {
        ghmmCreate=create
    }
}
import com.vasileff.ceylon.guava.collect {
    TypeHoles {
        unsafeCast
    }
}

import java.util {
    JSet=Set,
    JCollection=Collection,
    JMap=Map {
        JMapEntry=Entry
    }
}

shared
class HashMultimap<Key, Item>
        satisfies MutableSetMultimap<Key, Item>
        given Key satisfies Object
        given Item satisfies Object {

    GuavaHashMultimap<Key,Item> delegate;

    shared
    new HashMultimap(delegate = ghmmCreate<Key, Item>(),
                     entries = {}) {
        GuavaHashMultimap<Key,Item> delegate;
        {<Key->Item>*} entries;
        this.delegate = delegate;
        for (key->item in entries) {
            delegate.put(key, item);
        }
    }

    shared actual
    Map<Key,Set<Item>> asMap
        =>  CeylonMap(delegate.asMap()).mapItems((key, items)
                =>  // Gauva apidocs guarantee items will be a JSet
                    let (itemsSet = unsafeCast<JSet<out Item>>(items))
                    CeylonSet<Item>(itemsSet));

    shared actual
    void clear()
        =>  delegate.clear();

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
    Set<Item> get(Object key)
        // Stupid google. Get takes K, not Object
        =>  CeylonSet(unsafeCast
                <GuavaHashMultimap<Object, out Item>>
                (delegate).get(key));

    shared actual
    Collection<Item> items
        =>  CeylonCollection<Item>(delegate.values());

    shared actual
    Iterator<Key->Item> iterator()
        // workaround https://github.com/ceylon/ceylon-compiler/issues/2028
        =>  let (JCollection<out JMapEntry<out Key,out Item>>
                    entries = delegate.entries())
            CeylonIterable(entries)
                .map((entry) => entry.key->entry.\ivalue)
                .iterator();

    shared actual
    Set<Key> keys
        =>  CeylonSet(delegate.keySet());

    shared actual
    Multiset<Key> keyMultiset
        // TODO MutableMultiset
        =>  MultisetWrapper(delegate.keys());

    shared actual
    Boolean put(Key key, Item item)
        =>  delegate.put(key, item);

    shared actual
    Boolean putAll(Multimap<Key, Item> multimap) {
        variable value result = false;
        for (key->item in multimap) {
            result = put(key, item) || result;
        }
        return result;
    }

    shared actual
    Boolean putMultiple(Key key, {Item*} items) {
        variable value result = false;
        for (item in items) {
            result = put(key, item) || result;
        }
        return result;
    }

    shared actual
    Boolean remove(Key key, Item item)
        =>  delegate.remove(key, item);

    shared actual
    Set<Item> removeAll(Key key)
        =>  CeylonSet(delegate.removeAll(key));

    shared actual
    Set<Item> replaceItems(Key key, {Item*} items)
        =>  CeylonSet(delegate.replaceValues(
                key, JavaIterable(items)));

    shared actual
    Integer size
        =>  delegate.size();

    shared actual
    HashMultimap<Key, Item> clone()
        =>  package.HashMultimap<Key, Item> { *this };

    shared actual
    Boolean equals(Object that)
        =>  (super of Set<Key->Item>).equals(that);

    shared actual
    Integer hash
        =>  (super of Set<Key->Item>).hash;

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
        =>  package.complement(this, set);

    shared actual
    Set<<Key->Item>|Other> exclusiveUnion<Other>(Set<Other> set)
            given Other satisfies Object
        =>  package.exclusiveUnion(this, set);
}
