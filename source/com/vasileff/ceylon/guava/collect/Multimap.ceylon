shared
interface Multimap<out Key, out Item> 
        satisfies Collection<Key->Item> &
                  Correspondence<Object, {Item*}>
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

    "lazy view ** Breaks from Correspondence in that it
     returns an empty collection, not null, on key not found"
    shared actual formal
    {Item*} get(Object key);

    shared actual formal
    Boolean empty;

    // FIXME From Correspondence *** Guava has keys and KeySet, which should this be???
    "Returns a view collection containing the key from each key-value
     pair in this multimap, without collapsing duplicates."
    shared actual formal
    Multiset<Key> keys;

    "Returns a view collection of all distinct keys contained in this multimap."
    shared formal
    Set<Key> keySet;

    "Returns a view collection containing the value from each key-value pair
     contained in this multimap, without collapsing duplicates
     (so values().size() == size())."
    shared formal
    {Item*} items; // values() in guava

    
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
