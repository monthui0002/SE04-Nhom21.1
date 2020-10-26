package java.lang;

import java.util.HashMap;
import java.util.Map;

public class System {

	private static Map<String, String> properties;
	
	static {
		properties = new HashMap<String, String>();
		
		properties.put("line.separator", "\r\n");
	}

	public static int identityHashCode(Object object) {
		return VMSystem.identityHashCode(object);
	}

	public static void arraycopy(Object src, int srcOffset, Object dst, int dstOffset, int length) {
		VMSystem.arraycopy(src, srcOffset, dst, dstOffset, length);
	}

	public static long currentTimeMillis() {
		return VMSystem.currentTimeMillis();
	}

	public static String getProperty(String key) {
		return properties.get(key);
	}

	public static String getProperty(String key, String alternative) {
		String ret = getProperty(key);
		if (ret == null) {
			return alternative;
		} else {
			return ret;
		}
	}

}
