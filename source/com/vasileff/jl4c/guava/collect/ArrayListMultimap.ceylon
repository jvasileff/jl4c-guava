import com.google.common.collect {
    GuavaArrayListMultimap=ArrayListMultimap {
        galmmCreate=create
    }
}

shared
class ArrayListMultimap<Key, Item>
        satisfies MutableListMultimap<Key, Item>
        given Key satisfies Object
        given Item satisfies Object {

    shared actual
    GuavaArrayListMultimap<Key, Item> delegate =
            galmmCreate<Key, Item>();

    shared
    new ArrayListMultimap(entries = {}) {
        {<Key->Item>*} entries;
        for (key->item in entries) {
            delegate.put(key, item);
        }
    }

    shared actual
    ArrayListMultimap<Key, Item> clone()
        =>  package.ArrayListMultimap<Key, Item> { *this };

//  FIXME ceylon list like equals/hash
//    shared actual
//    Boolean equals(Object that)
//        =>  (super of List<Key->Item>).equals(that);
//
//    shared actual
//    Integer hash
//        =>  (super of List<Key->Item>).hash;

}
