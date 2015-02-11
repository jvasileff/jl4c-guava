shared
interface BiMap<out Key, out Item>
        satisfies Map<Key, Item>
        given Key satisfies Object
        given Item satisfies Object {

    shared formal
    BiMap<Item, Key> inverse; // TODO inverse*d*?

    shared actual formal
    Integer size;

    shared actual formal
    Set<Item> items;

}
