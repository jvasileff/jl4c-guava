import com.google.common.collect {
    GuavaLinkedHashMultimap=LinkedHashMultimap {
        glhmmCreate=create
    }
}

shared
class LinkedHashMultimap<Key, Item>
        satisfies MutableSetMultimap<Key, Item>
        given Key satisfies Object
        given Item satisfies Object {

    shared actual
    GuavaLinkedHashMultimap<Key, Item> delegate =
            glhmmCreate<Key, Item>();

    shared
    new ({<Key->Item>*} entries = {}) {
        for (key->item in entries) {
            delegate.put(key, item);
        }
    }

    shared actual
    LinkedHashMultimap<Key, Item> clone()
        =>  package.LinkedHashMultimap<Key, Item> { *this };

    shared actual
    Boolean equals(Object that)
        =>  (super of Set<Key->Item>).equals(that);

    shared actual
    Integer hash
        =>  (super of Set<Key->Item>).hash;
}
