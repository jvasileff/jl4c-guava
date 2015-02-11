jl4c Guava
=================================

Guava style collections for Ceylon, backed by Guava.

The goal of this project is to create a good *Ceylon* library with the help of
Guava, and not to attempt to expose all of Guava in Ceylon.

Fortunately, Guava's collections framework works *very* well with Ceylon's
language features and standard library. In fact, Guava collections arguably
present themselves much *better* in Ceylon than in their native Java due to
Ceylon's declaration site variance and flexible base collections interfaces
including `Iterable`, `Collection`, and `Correspondence`.

## Highlights

- Immutable types including `ImmutableList`, `ImmutableSet`, `ImmutableMap`,
  and others. All immutable types have corresponding builder classes, such as
  `ImmutableListBuilder`.
- `BiMap` types, which are `Map<Key, Item>`s that are indexed on both `Key` and
  `Item`, with an available inverse view providing a `Map<Item, Key>`.
- `Multimap` types, which are `Collection`s of `Key->Item`s and
  `Correspondence`s of keys to `Collection<Item>`s. `ListMultimap`,
  `SetMultimap`, and `TreeMultimap` are important variations.
- `Multiset` types, which are efficient `Collection`s of elements, where each
  element may occur more than once. 

See Guava's [Documentation](https://code.google.com/p/guava-libraries/wiki/GuavaExplained)
for detailed overview of Guava's Collections.

## Non-Collections Classes

This library may be expanded to cover other areas of Guava. One package that
might be interesting is `com.google.common.cache` (well, yeah, that's a bit
collections-like too). But much of Guava is either Java specific or can easily
be used directly from Ceylon without wrappers.

## Status

Initial implementations of several collection types are working, but are
missing some functionality such as mutable views.

The source code must be compiled against the latest development version of
Ceylon, so a precompiled module will not be available until after Ceylon's
next release.

## License

The content of this repository is released under the ASL v2.0 as provided in
the LICENSE file that accompanied this code.

By submitting a "pull request" or otherwise contributing to this repository,
you agree to license your contribution under the license mentioned above.
