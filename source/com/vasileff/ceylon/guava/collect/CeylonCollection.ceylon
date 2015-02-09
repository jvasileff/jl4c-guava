import java.util {
    JCollection=Collection,
    ArrayList
}
import ceylon.interop.java {
    CeylonIterator
}

class CeylonCollection<Element>(JCollection<out Element> collection)
        satisfies Collection<Element> {

    shared actual
    Integer size
        =>  collection.size();

    shared actual default
    Collection<Element> clone()
        =>  CeylonCollection(ArrayList(collection));

    shared actual
    Iterator<Element> iterator()
        =>  CeylonIterator(collection.iterator());

}