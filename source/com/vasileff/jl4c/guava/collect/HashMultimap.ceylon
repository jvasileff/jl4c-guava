import com.google.common.collect {
    GuavaHashMultimap=HashMultimap {
        ghmmCreate=create
    }
}

shared
class HashMultimap<Key, Item>
        satisfies MutableSetMultimap<Key, Item>
        given Key satisfies Object
        given Item satisfies Object {

    shared actual
    GuavaHashMultimap<Key, Item> delegate =
            ghmmCreate<Key, Item>();

    shared
    new (entries = {}) {
        {<Key->Item>*} entries;
        for (key->item in entries) {
            delegate.put(key, item);
        }
    }

    shared actual
    HashMultimap<Key, Item> clone()
        =>  package.HashMultimap<Key, Item> { *this };

    shared actual
    Boolean equals(Object that)
        =>  (super of Set<Key->Item>).equals(that);

    shared actual
    Integer hash
        =>  (super of Set<Key->Item>).hash;
}
