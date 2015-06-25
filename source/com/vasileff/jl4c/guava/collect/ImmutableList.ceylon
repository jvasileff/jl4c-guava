import com.google.common.collect {
    GuavaImmutableList=ImmutableList {
        GILBuilder=Builder
    }
}

shared final
class ImmutableList<out Element>
        satisfies List<Element>
        given Element satisfies Object {

    shared
    GuavaImmutableList<out Element> delegate;

    shared
    new ({Element*} elements) {
        value builder = GILBuilder<Element>();
        for (element in elements) {
            builder.add(element);
        }
        delegate = builder.build();
    }

    shared
    new wrap(GuavaImmutableList<out Element> delegate) {
        this.delegate = delegate;
    }

    // TODO trim, trimtrailing, trimleading, slice, initial, terminal, keys

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
    ImmutableList<Element> span(Integer from, Integer to)
        =>  if (size > 0) then
                let (end = size - 1)
                if (from <= to) then
                    if (from <= 0 && to >= end) then
                        this
                    else if (to >= 0 && from <= end) then
                        ImmutableList.wrap(delegate.subList(
                                largerInteger(from, 0),
                                smallerInteger(to + 1, size)))
                    else
                        emptyImmutableList
                else
                    if (end <= 0 && from >= end) then
                        this.reversed
                    else if (from >= 0 && to <= end) then
                        ImmutableList.wrap(delegate.subList(
                                largerInteger(to, 0),
                                smallerInteger(from + 1, size))
                                .reverse())
                    else
                        emptyImmutableList
            else
                emptyImmutableList;

    shared actual
    ImmutableList<Element> spanFrom(Integer from)
        =>  if (from < size)
            then span(from, size - 1)
            else emptyImmutableList;

    shared actual
    ImmutableList<Element> spanTo(Integer to)
        =>  if (to >= 0)
            then span(0, to)
            else emptyImmutableList;

    shared actual
    ImmutableList<Element> measure(Integer from, Integer length)
        =>  if (length > 0)
            then span(from, from + length - 1)
            else emptyImmutableList;

    shared actual
    List<Integer> keys
        =>  0:size;

    shared actual
    ImmutableList<Element> clone()
        =>  this;

    shared actual
    ImmutableList<Element> coalesced
        =>  this;

    shared actual
    ImmutableList<Element> reversed
        =>  ImmutableList.wrap(delegate.reverse());

    shared actual
    Boolean equals(Object that)
        =>  (super of List<Element>).equals(that);

    shared actual
    Integer hash
        =>  (super of List<Element>).hash;
}

ImmutableList<Nothing> emptyImmutableList = ImmutableList({});

Integer smallerInteger(Integer x, Integer y)
    =>  if (x < y) then x else y;

Integer largerInteger(Integer x, Integer y)
    =>  if (x > y) then x else y;
