shared
interface ListMultimap<out Key, out Item>
        satisfies Multimap<Key, Item>
        given Key satisfies Object
        given Item satisfies Object {

    //Note: guava has "Collection<Map.Entry<K,V>> entries()" method
    //instead, we are a  a "Collection<Key->Item>"

    shared actual formal
    Map<Key, Collection<Item>> asMap;

    //Note: document break from Correspondence in that we never return null 
    shared actual formal
    List<Item> get(Object key);
}
