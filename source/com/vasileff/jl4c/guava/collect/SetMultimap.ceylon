import ceylon.interop.java {
    CeylonSet,
    CeylonMap
}
import com.google.common.collect {
    GuavaSetMultimap=SetMultimap
}
import com.vasileff.jl4c.guava.collect {
    TypeHoles {
        unsafeCast
    }
}
import java.util {
    JSet=Set
}

shared
interface SetMultimap<out Key, out Item>
        satisfies Set<Key->Item> &
                  Multimap<Key, Item>
        given Key satisfies Object
        given Item satisfies Object {

    //Note: guava has "Set<Map.Entry<K,V>>	entries()" method
    //instead, we *are* a "Set<Key->Item>"

    //Multimap returns `Map<Key, {Item*}>`
    shared actual
    Map<Key,Set<Item>> asMap
        =>  CeylonMap(delegate.asMap()).mapItems((key, items)
                =>  // Gauva apidocs guarantee items will be a JSet
                    let (itemsSet = unsafeCast<JSet<out Item>>(items))
                    CeylonSet<Item>(itemsSet));

    //Multimap returns `{Item*}`
    //Note: document break from Correspondence in that we never return null 
    shared actual default
    Set<Item> get(Object key)
        // Stupid google. Get takes K, not Object
        =>  CeylonSet(unsafeCast
                <GuavaSetMultimap<Object, out Item>>
                (delegate).get(key));

    //defined by both Set and Multimap (ultimately from Collection)
    shared actual
    Boolean contains(Object entry)
        => (super of Multimap<Key, Item>).contains(entry);

    shared actual formal
    SetMultimap<Key, Item> clone();

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
