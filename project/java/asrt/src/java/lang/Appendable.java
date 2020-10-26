package java.lang;

import java.io.IOException;

public interface Appendable {

	public Appendable append(char c) throws IOException;
	public Appendable append(CharSequence seq) throws IOException;
	public Appendable append(CharSequence seq, int start, int end) throws IOException;

}
