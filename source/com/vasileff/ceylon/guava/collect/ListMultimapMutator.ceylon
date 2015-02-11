shared
interface ListMultimapMutator<in Key, in Item>
        satisfies MultimapMutator<Key, Item>
        given Key satisfies Object {

    shared actual formal
    List<Object> removeAll(Key key);

    shared actual formal
    List<Object> replaceItems(Key key, {Item*} items);

}
