import com.google.common.collect {
    GuavaHashBiMap=HashBiMap {
        ghbmCreate=create
    }
}

shared final
class HashBiMap<Key, Item>({<Key->Item>*} entries={})
        extends MutableBiMapWrapper<Key, Item>(ghbmCreate<Key, Item>(), entries)
        given Key satisfies Object
        given Item satisfies Object {}
