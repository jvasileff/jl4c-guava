import ceylon.interop.java {
    CeylonSet,
    JavaIterable
}
import com.google.common.collect {
    GuavaSetMultimap=SetMultimap
}

shared
interface MutableSetMultimap<Key, Item>
        satisfies SetMultimap<Key, Item> &
                  SetMultimapMutator<Key, Item> &
                  MutableMultimap<Key, Item>
        given Key satisfies Object
        given Item satisfies Object {

    shared actual formal
    GuavaSetMultimap<Key, Item> delegate;

    shared actual
    Set<Item> removeAll(Key key)
        =>  CeylonSet(delegate.removeAll(key));

    shared actual
    Set<Item> replaceItems(Key key, {Item*} items)
        =>  CeylonSet(delegate.replaceValues(
                key, JavaIterable(items)));
}
