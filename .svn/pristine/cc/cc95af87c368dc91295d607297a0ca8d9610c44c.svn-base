package java.util;


public class HashSet<T> extends AbstractSet<T> implements Set<T>, Cloneable {

	/**
	 * The HashMap which backs this Set.
	 */
	private transient HashMap<T, String> map;

	/**
	 * Construct a new, empty HashSet whose backing HashMap has the default
	 * capacity (11) and loadFacor (0.75).
	 */
	public HashSet() {
		this(HashMap.DEFAULT_CAPACITY, HashMap.DEFAULT_LOAD_FACTOR);
	}

	/**
	 * Construct a new, empty HashSet whose backing HashMap has the supplied
	 * capacity and the default load factor (0.75).
	 * 
	 * @param initialCapacity
	 *            the initial capacity of the backing HashMap
	 * @throws IllegalArgumentException
	 *             if the capacity is negative
	 */
	public HashSet(int initialCapacity) {
		this(initialCapacity, HashMap.DEFAULT_LOAD_FACTOR);
	}

	/**
	 * Construct a new, empty HashSet whose backing HashMap has the supplied
	 * capacity and load factor.
	 * 
	 * @param initialCapacity
	 *            the initial capacity of the backing HashMap
	 * @param loadFactor
	 *            the load factor of the backing HashMap
	 * @throws IllegalArgumentException
	 *             if either argument is negative, or if loadFactor is
	 *             POSITIVE_INFINITY or NaN
	 */
	public HashSet(int initialCapacity, float loadFactor) {
		map = init(initialCapacity, loadFactor);
	}

	/**
	 * Construct a new HashSet with the same elements as are in the supplied
	 * collection (eliminating any duplicates, of course). The backing storage
	 * has twice the size of the collection, or the default size of 11,
	 * whichever is greater; and the default load factor (0.75).
	 * 
	 * @param c
	 *            a collection of initial set elements
	 * @throws NullPointerException
	 *             if c is null
	 */
	public HashSet(Collection<? extends T> c) {
		this(Math.max(2 * c.size(), HashMap.DEFAULT_CAPACITY));
		addAll(c);
	}

	/**
	 * Adds the given Object to the set if it is not already in the Set. This
	 * set permits a null element.
	 * 
	 * @param o
	 *            the Object to add to this Set
	 * @return true if the set did not already contain o
	 */
	public boolean add(T o) {
		return map.put(o, "") == null;
	}

	/**
	 * Empties this Set of all elements; this takes constant time.
	 */
	public void clear() {
		map.clear();
	}

	/**
	 * Returns a shallow copy of this Set. The Set itself is cloned; its
	 * elements are not.
	 * 
	 * @return a shallow clone of the set
	 */
	public Object clone() {
		HashSet<T> copy = null;
		try {
			copy = (HashSet<T>) super.clone();
		} catch (CloneNotSupportedException x) {
			// Impossible to get here.
		}
		copy.map = (HashMap<T, String>) map.clone();
		return copy;
	}

	/**
	 * Returns true if the supplied element is in this Set.
	 * 
	 * @param o
	 *            the Object to look for
	 * @return true if it is in the set
	 */
	public boolean contains(Object o) {
		return map.containsKey(o);
	}

	/**
	 * Returns true if this set has no elements in it.
	 * 
	 * @return <code>size() == 0</code>.
	 */
	public boolean isEmpty() {
		return map.size == 0;
	}

	/**
	 * Returns an Iterator over the elements of this Set, which visits the
	 * elements in no particular order. For this class, the Iterator allows
	 * removal of elements. The iterator is fail-fast, and will throw a
	 * ConcurrentModificationException if the set is modified externally.
	 * 
	 * @return a set iterator
	 * @see ConcurrentModificationException
	 */
	public Iterator<T> iterator() {
		// Avoid creating intermediate keySet() object by using non-public API.
		return map.iterator(HashMap.KEYS);
	}

	/**
	 * Removes the supplied Object from this Set if it is in the Set.
	 * 
	 * @param o
	 *            the object to remove
	 * @return true if an element was removed
	 */
	public boolean remove(Object o) {
		return (map.remove(o) != null);
	}

	/**
	 * Returns the number of elements in this Set (its cardinality).
	 * 
	 * @return the size of the set
	 */
	public int size() {
		return map.size;
	}

	/**
	 * Helper method which initializes the backing Map. Overridden by
	 * LinkedHashSet for correct semantics.
	 * 
	 * @param capacity
	 *            the initial capacity
	 * @param load
	 *            the initial load factor
	 * @return the backing HashMap
	 */
	HashMap init(int capacity, float load) {
		return new HashMap(capacity, load);
	}
}
