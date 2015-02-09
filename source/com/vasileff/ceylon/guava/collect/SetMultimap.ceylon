shared
interface SetMultimap<out Key, out Item>
        satisfies Set<Key->Item> &
                  Multimap<Key, Item>
        given Key satisfies Object
        given Item satisfies Object {

    //Note: guava has "Set<Map.Entry<K,V>>	entries()" method
    //instead, we *are* a "Set<Key->Item>"

    //Multimap returns `Map<Key, {Item*}>`
    shared actual formal
    Map<Key,Set<Item>> asMap;

    //Multimap returns `{Item*}`
    //Note: document break from Correspondence in that we never return null 
    shared actual formal
    Set<Item> get(Object key);

    //defined by both Set and Multimap (ultimately from Collection)
    shared actual formal
    Boolean contains(Object entry);
}
