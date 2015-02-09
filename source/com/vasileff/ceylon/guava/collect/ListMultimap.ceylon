shared
interface ListMultimap<out Key, out Item>
        satisfies Multimap<Key, Item>
        given Key satisfies Object
        given Item satisfies Object {

    shared actual formal
    Map<Key,{Item*}> asMap;

    //Multimap returns `{Item*}`
    //Note: document break from Correspondence in that we never return null 
    shared actual formal
    List<Item> get(Object key);
}
