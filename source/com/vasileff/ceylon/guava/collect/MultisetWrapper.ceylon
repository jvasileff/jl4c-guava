import com.google.common.collect {
    GuavaMultiset=Multiset
}

class MultisetWrapper<out Element>(delegate)
        satisfies Multiset<Element>
        given Element satisfies Object {

    shared actual
    GuavaMultiset<out Element> delegate;

    shared actual default
    ImmutableMultiset<Element> clone()
        =>  ImmutableMultiset(this);

}
