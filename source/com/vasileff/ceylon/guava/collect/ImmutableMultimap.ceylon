import ceylon.interop.java {
    CeylonIterable
}

import com.google.common.collect {
    GuavaImmutableMultimap=ImmutableMultimap
}

import java.util {
    JCollection=Collection,
    JMap=Map {
        JMapEntry=Entry
    }
}

shared sealed
interface ImmutableMultimap<out Key, out Item>
    satisfies Multimap<Key, Item>
    given Key satisfies Object
    given Item satisfies Object {

    shared formal
    GuavaImmutableMultimap<out Key, out Item> delegate;

    shared actual
    Boolean defines(Object key)
        =>  delegate.containsKey(key);

    // TODO Ceylon inconvenience - has to be default so subclasses can choose this one?
    shared actual default
    Boolean contains(Object entry)
        =>  if (is Key->Item entry)
            then delegate.containsEntry(entry.key, entry.item)
            else false;

    shared actual
    Boolean containsItem(Object item)
        =>  delegate.containsValue(item);

    shared actual
    {Item*} items
        =>  CeylonIterable(delegate.values());

    shared actual
    ImmutableMultiset<Key> keys
        =>  ImmutableMultiset(delegate.keys());

    shared actual
    ImmutableSet<Key> keySet
        =>  ImmutableSet(delegate.keySet());

    shared actual
    Boolean empty
        =>  delegate.empty;

    shared actual
    Integer size
        =>  delegate.size();

    shared actual
    Iterator<Key->Item> iterator()
            // workaround https://github.com/ceylon/ceylon-compiler/issues/2028
        =>  let (JCollection<out JMapEntry<out Key,out Item>>
                    entries = delegate.entries())
            CeylonIterable(entries)
                .map((entry) => entry.key->entry.\ivalue)
                .iterator();
}
