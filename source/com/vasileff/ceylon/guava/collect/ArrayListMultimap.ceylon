import ceylon.interop.java {
    CeylonMap,
    CeylonSet,
    CeylonIterable,
    JavaIterable,
    CeylonList
}

import com.google.common.collect {
    GuavaArrayListMultimap=ArrayListMultimap {
        galmmCreate=create
    }
}
import com.vasileff.ceylon.guava.collect {
    TypeHoles {
        unsafeCast
    }
}

import java.util {
    JList=List,
    JCollection=Collection,
    JMap=Map {
        JMapEntry=Entry
    }
}

shared
class ArrayListMultimap<Key, Item>
        satisfies MutableListMultimap<Key, Item>
        given Key satisfies Object
        given Item satisfies Object {

    value delegate = galmmCreate<Key, Item>();

    shared
    new ArrayListMultimap(entries = {}) {
        {<Key->Item>*} entries;
        for (key->item in entries) {
            delegate.put(key, item);
        }
    }

    shared actual
    Map<Key,List<Item>> asMap
        =>  CeylonMap(delegate.asMap()).mapItems((key, items)
                =>  // Gauva apidocs guarantee items will be a JList
                    let (itemsList = unsafeCast<JList<out Item>>(items))
                    CeylonList<Item>(itemsList));

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
    List<Item> get(Object key)
        // Stupid google. Get takes K, not Object
        =>  CeylonList(unsafeCast
                <GuavaArrayListMultimap<Object, out Item>>
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
    List<Item> removeAll(Key key)
        =>  CeylonList(delegate.removeAll(key));

    shared actual
    List<Item> replaceItems(Key key, {Item*} items)
        =>  CeylonList(delegate.replaceValues(
                key, JavaIterable(items)));

    shared actual
    Integer size
        =>  delegate.size();

    shared actual
    HashMultimap<Key, Item> clone()
        =>  package.HashMultimap<Key, Item> { *this };

//  FIXME ceylon list like equals/hash
//    shared actual
//    Boolean equals(Object that)
//        =>  (super of List<Key->Item>).equals(that);
//
//    shared actual
//    Integer hash
//        =>  (super of List<Key->Item>).hash;

}
