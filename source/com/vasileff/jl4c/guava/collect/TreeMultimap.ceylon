import ceylon.interop.java {
    JavaComparator
}

import com.google.common.collect {
    GuavaTreeMultimap=TreeMultimap {
        gtmmCreate=create
    }
}

// TODO return SortedSets instead of Sets

shared
class TreeMultimap<Key, Item>
        satisfies Multimap<Key, Item> &
                  SetMultimap<Key, Item> &
                  MutableMultimap<Key, Item> &
                  MutableSetMultimap<Key, Item>
        given Key satisfies Object
        given Item satisfies Object {

    shared actual
    GuavaTreeMultimap<Key, Item> delegate;

    Comparison compareKeys(Key x, Key y);

    Comparison compareItems(Item x, Item y);

    shared
    new TreeMultimap(compareKeys, compareItems, entries = {}) {
        Comparison compareKeys(Key x, Key y);
        Comparison compareItems(Item x, Item y);
        this.compareKeys = compareKeys;
        this.compareItems = compareItems;
        delegate = gtmmCreate(JavaComparator(compareKeys),
                              JavaComparator(compareItems));
        {<Key->Item>*} entries;
        for (key->item in entries) {
            delegate.put(key, item);
        }
    }

    shared actual
    TreeMultimap<Key, Item> clone()
        =>  package.TreeMultimap<Key, Item>(compareKeys, compareItems, this);

    shared actual
    Boolean equals(Object that)
        =>  (super of Set<Key->Item>).equals(that);

    shared actual
    Integer hash
        =>  (super of Set<Key->Item>).hash;
}

shared
TreeMultimap<Key, Item> naturalOrderTreeMultimap<Key, Item>({<Key->Item>*} entries)
        given Key satisfies Object & Comparable<Key>
        given Item satisfies Object & Comparable<Item>
    =>  TreeMultimap(compare<Key>, compare<Item>, entries);

Comparison compare<Element>(Element x, Element y)
        given Element satisfies Comparable<Element>
    =>  x<=>y;
