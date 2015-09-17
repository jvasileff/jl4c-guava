import com.google.common.collect {
    GuavaImmutableMultimap=ImmutableMultimap
}

shared sealed
interface ImmutableMultimap<out Key, out Item>
    satisfies Multimap<Key, Item>
    given Key satisfies Object
    given Item satisfies Object {

    shared actual formal
    GuavaImmutableMultimap<out Key, out Item> delegate;

    // TODO ImmutableCollection
    //Collection<Item> items

    shared actual
    ImmutableMultiset<Key> keyMultiset
        =>  ImmutableMultiset.wrap(delegate.keys());

    shared actual
    ImmutableSet<Key> keys
        =>  ImmutableSet.wrap(delegate.keySet());

    "Returns an immutable multimap which is the inverse of this one."
    shared formal
    ImmutableMultimap<Item, Key> inverse;
}
