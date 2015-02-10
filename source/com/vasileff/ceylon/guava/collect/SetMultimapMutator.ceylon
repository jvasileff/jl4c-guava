shared
interface SetMultimapMutator<in Key, in Item>
        satisfies MultimapMutator<Key, Item>
        given Key satisfies Object
        given Item satisfies Object {

    // TODO document that sets in Ceylon cannot hold null,
    // therefore, Item satisfies Object

    shared actual formal
    Set<Object> removeAll(Key key);

    shared actual formal
    Set<Object> replaceItems(Key key, {Item*} items);

}