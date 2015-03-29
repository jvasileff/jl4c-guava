import com.google.common.collect {
    GuavaLinkedListMultimap=LinkedListMultimap {
        gllmmCreate=create
    }
}

shared
class LinkedListMultimap<Key, Item>
        satisfies Multimap<Key, Item> &
                  ListMultimap<Key, Item> &
                  MutableMultimap<Key, Item> &
                  MutableListMultimap<Key, Item>
        given Key satisfies Object
        given Item satisfies Object {

    shared actual
    GuavaLinkedListMultimap<Key, Item> delegate =
            gllmmCreate<Key, Item>();

    shared
    new ({<Key->Item>*} entries = {}) {
        for (key->item in entries) {
            delegate.put(key, item);
        }
    }

    shared actual
    LinkedListMultimap<Key, Item> clone()
        =>  package.LinkedListMultimap<Key, Item> { *this };

//  FIXME ceylon list like equals/hash
//    shared actual
//    Boolean equals(Object that)
//        =>  (super of List<Key->Item>).equals(that);
//
//    shared actual
//    Integer hash
//        =>  (super of List<Key->Item>).hash;

}
