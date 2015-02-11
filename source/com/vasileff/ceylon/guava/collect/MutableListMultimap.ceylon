import ceylon.interop.java {
    CeylonList,
    JavaIterable
}
import com.google.common.collect {
    GuavaListMultimap=ListMultimap
}

shared
interface MutableListMultimap<Key, Item>
        satisfies ListMultimap<Key, Item> &
                  ListMultimapMutator<Key, Item> &
                  MutableMultimap<Key, Item>
        given Key satisfies Object
        given Item satisfies Object {

    shared actual formal
    GuavaListMultimap<Key, Item> delegate;

    shared actual
    List<Item> removeAll(Key key)
        =>  CeylonList(delegate.removeAll(key));

    shared actual
    List<Item> replaceItems(Key key, {Item*} items)
        =>  CeylonList(delegate.replaceValues(
                key, JavaIterable(items)));
}
