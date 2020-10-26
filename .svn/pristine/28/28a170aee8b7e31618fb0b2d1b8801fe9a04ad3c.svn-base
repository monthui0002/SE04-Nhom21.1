package java.util;

public interface Map<K, V> {

	public void clear();
	public boolean containsKey(Object key);
	public boolean containsValue(Object value);
	public Set<Map.Entry<K, V>> entrySet();
	public boolean equals(Object o);
	public V get(Object key);
	public V put(K key, V value);
	public int hashCode();
	public boolean isEmpty();
	public Set<K> keySet();
	public void putAll(Map<? extends K, ? extends V> m);
	public V remove(Object o);
	public int size();
	public Collection<V> values();
	
	public interface Entry<K, V> {
		public K getKey();
		public V getValue();
		public V setValue(V value);
		public int hashCode();
		public boolean equals(Object o);
	}
}
