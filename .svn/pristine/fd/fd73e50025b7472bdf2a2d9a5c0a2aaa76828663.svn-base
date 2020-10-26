package java.util;

public abstract class AbstractSet<E> extends AbstractCollection<E> implements
		Set<E> {
	/**
	 * The main constructor, for use by subclasses.
	 */
	protected AbstractSet() {
	}

	/**
	 * Tests whether the given object is equal to this Set. This implementation
	 * first checks whether this set <em>is</em> the given object, and returns
	 * true if so. Otherwise, if o is a Set and is the same size as this one, it
	 * returns the result of calling containsAll on the given Set. Otherwise, it
	 * returns false.
	 * 
	 * @param o
	 *            the Object to be tested for equality with this Set
	 * @return true if the given object is equal to this Set
	 */
	public boolean equals(Object o) {
		return (o == this || (o instanceof Set && ((Set<?>) o).size() == size() && containsAll((Collection<?>) o)));
	}

	/**
	 * Returns a hash code for this Set. The hash code of a Set is the sum of
	 * the hash codes of all its elements, except that the hash code of null is
	 * defined to be zero. This implementation obtains an Iterator over the Set,
	 * and sums the results.
	 * 
	 * @return a hash code for this Set
	 */
	public int hashCode() {
		Iterator<E> itr = iterator();
		int hash = 0;
		int pos = size();
		while (--pos >= 0)
			hash += hashCode(itr.next());
		return hash;
	}

	/**
	 * Removes from this set all elements in the given collection (optional
	 * operation). This implementation uses <code>size()</code> to determine the
	 * smaller collection. Then, if this set is smaller, it iterates over the
	 * set, calling Iterator.remove if the collection contains the element. If
	 * this set is larger, it iterates over the collection, calling Set.remove
	 * for all elements in the collection. Note that this operation will fail if
	 * a remove methods is not supported.
	 * 
	 * @param c
	 *            the collection of elements to remove
	 * @return true if the set was modified as a result
	 * @throws UnsupportedOperationException
	 *             if remove is not supported
	 * @throws NullPointerException
	 *             if the collection is null
	 * @see AbstractCollection#remove(Object)
	 * @see Collection#contains(Object)
	 * @see Iterator#remove()
	 */
	public boolean removeAll(Collection<?> c) {
		int oldsize = size();
		int count = c.size();
		if (oldsize < count) {
			Iterator<E> i;
			for (i = iterator(), count = oldsize; count > 0; count--) {
				if (c.contains(i.next()))
					i.remove();
			}
		} else {
			Iterator<?> i;
			for (i = c.iterator(); count > 0; count--)
				remove(i.next());
		}
		return oldsize != size();
	}
}
