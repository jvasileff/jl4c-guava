shared
interface Multimap<out Key, out Item> 
        satisfies Collection<Key->Item> &
                  Correspondence<Object, Collection<Item>>
        given Key satisfies Object {

    "Returns a view of this multimap as a Map from each distinct
     key to the nonempty collection of that key's associated values."
    shared formal
    Map<Key, {Item*}> asMap;

    // from Collection, entry is Key->Item (containsEntry in guava)
    shared actual formal
    Boolean contains(Object entry);

    // From Correspondence, key is Key (containsKey in guava)
    shared actual formal
    Boolean defines(Object key);

    // Multimap method, item is Item (containsItem in guava)
    shared formal
    Boolean containsItem(Object item);

    // TODO consider returning nulls, unlike guava?
    "lazy view ** Breaks from Correspondence in that it
     returns an empty collection, not null, on key not found"
    shared actual formal
    Collection<Item> get(Object key);

    shared actual formal
    Boolean empty;

    // TODO document difference w/Guava (keys are set, not multiset)
    "Returns a view collection of all distinct keys contained in this multimap."
    shared actual formal
    Set<Key> keys;

    "Returns a view collection containing the key from each key-value
     pair in this multimap, without collapsing duplicates."
    shared formal
    Multiset<Key> keyMultiset;

    // TODO document that this is not parallel with keys (items is flattened)
    "Returns a view collection containing the value from each key-value pair
     contained in this multimap, without collapsing duplicates
     (so values().size() == size())."
    shared formal
    Collection<Item> items; // values() in guava

    //shared actual
    //Iterator<Key->Item> iterator() => nothing;

    // from iterable
    shared actual formal
    Integer size;

    // getAll ** from Correspondence doesn't do what we would want (so we have "items")
    //shared actual formal
    //Iterable<{Item*}, Absent> getAll<Absent>(Iterable<Object,Absent> keys)
    //    given Absent satisfies Null;

}
