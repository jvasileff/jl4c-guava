import ceylon.interop.java {
    CeylonMap,
    CeylonList
}

import com.google.common.collect {
    GuavaListMultimap=ListMultimap
}
import com.vasileff.jl4c.guava.collect {
    TypeHoles {
        unsafeCast
    }
}

import java.util {
    JList=List
}

shared
interface ListMultimap<out Key, out Item>
        satisfies Multimap<Key, Item>
        given Key satisfies Object
        given Item satisfies Object {

    //Note: guava has "Collection<Map.Entry<K,V>> entries()" method
    //instead, we are a  a "Collection<Key->Item>"

    shared actual formal
    GuavaListMultimap<out Key, out Item> delegate;

    shared actual
    Map<Key,List<Item>> asMap
        =>  CeylonMap(delegate.asMap()).mapItems((key, items)
                =>  // Gauva apidocs guarantee items will be a JList
                    let (itemsList = unsafeCast<JList<out Item>>(items))
                    CeylonList<Item>(itemsList));

    //Note: document break from Correspondence in that we never return null 
    shared actual default
    List<Item> get(Object key)
        // Stupid google. Get takes K, not Object
        =>  CeylonList(unsafeCast
                <GuavaListMultimap<Object, out Item>>
                (delegate).get(key));

    shared actual formal
    ListMultimap<Key, Item> clone();
}
