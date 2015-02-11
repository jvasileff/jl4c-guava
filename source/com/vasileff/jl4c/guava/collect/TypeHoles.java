package com.vasileff.jl4c.guava.collect;

class TypeHoles {
	/*
	 * Guava's Multimap interface declares 'get(K)' instead of 'get(Object'),
	 * making covariance via wild cards impossible (the K in get(K) is in a
	 * contravariant location).
	 *
	 * unsafeCast let's us work around issues like that.
	 */
	@SuppressWarnings("unchecked")
	static <T> T unsafeCast(Object o) {
		return (T) o;
	}
}
