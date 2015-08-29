import ceylon.interop.java {
    CeylonSet,
    CeylonIterable,
    CeylonCollection
}

import com.google.common.collect {
    GuavaMultimap=Multimap
}

import java.util {
    JCollection=Collection,
    JMap=Map {
        JMapEntry=Entry
    }
}

shared
interface Multimap<out Key, out Item>
        satisfies Collection<Key->Item> &
                  Correspondence<Object, Collection<Item>>
        given Key satisfies Object {

    shared formal
    GuavaMultimap<out Key, out Item> delegate;

    "Returns a view of this multimap as a Map from each distinct
     key to the nonempty collection of that key's associated values."
    shared formal
    Map<Key, {Item*}> asMap;

    //has to be default so satisfying types can choose this one
    //https://github.com/ceylon/ceylon-spec/issues/1241
    // from Collection, entry is Key->Item (containsEntry in guava)
    shared actual default
    Boolean contains(Object entry)
        =>  if (is Object->Anything entry)
            then delegate.containsEntry(
                    entry.key, entry.item of Object?)
            else false;

    // From Correspondence, key is Key (containsKey in guava)
    shared actual
    Boolean defines(Object key)
        =>  delegate.containsKey(key);

    // Multimap method, item is Item (containsItem in guava)
    shared
    Boolean containsItem(Object item)
        =>  delegate.containsValue(item);

    // TODO consider returning nulls, unlike guava?
    "lazy view ** Breaks from Correspondence in that it
     returns an empty collection, not null, on key not found"
    shared actual formal
    Collection<Item> get(Object key);

    shared actual
    Boolean empty
        =>  delegate.empty;

    // Note: must be distinct to support Correspondence.getAll()
    "Returns a view collection of all distinct keys contained in this multimap."
    shared actual default
    Set<Key> keys
        =>  CeylonSet(delegate.keySet());

    "Returns a view collection containing the key from each key-value
     pair in this multimap, without collapsing duplicates."
    shared default
    Multiset<Key> keyMultiset
        // TODO MutableMultiset
        =>  MultisetWrapper(delegate.keys());

    // TODO document that this is not parallel with keys (items is flattened)
    "Returns a view collection containing the value from each key-value pair
     contained in this multimap, without collapsing duplicates
     (so values().size() == size())."
    shared
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

    // from iterable
    shared actual
    Integer size
        =>  delegate.size();

    // getAll ** from Correspondence doesn't do what we would want (so we have "items")
    //shared actual formal
    //Iterable<{Item*}, Absent> getAll<Absent>(Iterable<Object,Absent> keys)
    //    given Absent satisfies Null;

}
