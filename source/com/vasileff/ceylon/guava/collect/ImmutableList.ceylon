import com.google.common.collect {
    GuavaImmutableList=ImmutableList {
        GILBuilder=Builder
    }
}

shared final
class ImmutableList<out Element>
        (GuavaImmutableList<out Element>|{Element*} elements)
        satisfies List<Element>
        given Element satisfies Object {

    shared
    GuavaImmutableList<out Element> delegate;

    if (is {Element*} elements) {
        value builder = GILBuilder<Element>();
        for (element in elements) {
            builder.add(element);
        }
        delegate = builder.build();
    }
    else {
        delegate = elements;
    }

    shared actual
    Element? getFromFirst(Integer index)
        =>  if (0 <= index < delegate.size())
            then delegate.get(index)
            else null;

    shared actual
    Integer size
        =>  delegate.size();

    shared actual
    Integer? lastIndex
        =>  let (index = size - 1)
            (index >= 0 then index);

    shared actual
    ImmutableList<Element> clone()
        =>  this;

    shared actual
    Boolean equals(Object that)
        =>  (super of List<Element>).equals(that);

    shared actual
    Integer hash
        =>  (super of List<Element>).hash;
}
