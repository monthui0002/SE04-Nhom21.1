/* MacDingbat.java -- Charset implementation for the MacDingbat character set.
   Copyright (C) 2005 Free Software Foundation, Inc.

This file is part of GNU Classpath.

GNU Classpath is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2, or (at your option)
any later version.

GNU Classpath is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
General Public License for more details.

You should have received a copy of the GNU General Public License
along with GNU Classpath; see the file COPYING.  If not, write to the
Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
02110-1301 USA.

Linking this library statically or dynamically with other modules is
making a combined work based on this library.  Thus, the terms and
conditions of the GNU General Public License cover the whole
combination.

As a special exception, the copyright holders of this library give you
permission to link this library with independent modules to produce an
executable, regardless of the license terms of these independent
modules, and to copy and distribute the resulting executable under
terms of your choice, provided that you also meet, for each linked
independent module, the terms and conditions of the license of that
module.  An independent module is a module which is not derived from
or based on this library.  If you modify this library, you may extend
this exception to your version of the library, but you are not
obligated to do so.  If you do not wish to do so, delete this
exception statement from your version. */

package java.nio.charset;

public final class MacDingbat extends ByteCharset {

	/**
	 * This is the lookup table for this encoding
	 */
	private static final char[] lookup = { 0x0000, 0x0001, 0x0002, 0x0003,
			0x0004, 0x0005, 0x0006, 0x0007, 0x0008, 0x0009, 0x000A, 0x000B,
			0x000C, 0x000D, 0x000E, 0x000F, 0x0010, 0x0011, 0x0012, 0x0013,
			0x0014, 0x0015, 0x0016, 0x0017, 0x0018, 0x0019, 0x001A, 0x001B,
			0x001C, 0x001D, 0x001E, 0x001F, 0x0020, 0x2701, 0x2702, 0x2703,
			0x2704, 0x260E, 0x2706, 0x2707, 0x2708, 0x2709, 0x261B, 0x261E,
			0x270C, 0x270D, 0x270E, 0x270F, 0x2710, 0x2711, 0x2712, 0x2713,
			0x2714, 0x2715, 0x2716, 0x2717, 0x2718, 0x2719, 0x271A, 0x271B,
			0x271C, 0x271D, 0x271E, 0x271F, 0x2720, 0x2721, 0x2722, 0x2723,
			0x2724, 0x2725, 0x2726, 0x2727, 0x2605, 0x2729, 0x272A, 0x272B,
			0x272C, 0x272D, 0x272E, 0x272F, 0x2730, 0x2731, 0x2732, 0x2733,
			0x2734, 0x2735, 0x2736, 0x2737, 0x2738, 0x2739, 0x273A, 0x273B,
			0x273C, 0x273D, 0x273E, 0x273F, 0x2740, 0x2741, 0x2742, 0x2743,
			0x2744, 0x2745, 0x2746, 0x2747, 0x2748, 0x2749, 0x274A, 0x274B,
			0x25CF, 0x274D, 0x25A0, 0x274F, 0x2750, 0x2751, 0x2752, 0x25B2,
			0x25BC, 0x25C6, 0x2756, 0x25D7, 0x2758, 0x2759, 0x275A, 0x275B,
			0x275C, 0x275D, 0x275E, NONE, 0x2768, 0x2769, 0x276A, 0x276B,
			0x276C, 0x276D, 0x276E, 0x276F, 0x2770, 0x2771, 0x2772, 0x2773,
			0x2774, 0x2775, NONE, NONE, NONE, NONE, NONE, NONE, NONE, NONE,
			NONE, NONE, NONE, NONE, NONE, NONE, NONE, NONE, NONE, NONE, NONE,
			0x2761, 0x2762, 0x2763, 0x2764, 0x2765, 0x2766, 0x2767, 0x2663,
			0x2666, 0x2665, 0x2660, 0x2460, 0x2461, 0x2462, 0x2463, 0x2464,
			0x2465, 0x2466, 0x2467, 0x2468, 0x2469, 0x2776, 0x2777, 0x2778,
			0x2779, 0x277A, 0x277B, 0x277C, 0x277D, 0x277E, 0x277F, 0x2780,
			0x2781, 0x2782, 0x2783, 0x2784, 0x2785, 0x2786, 0x2787, 0x2788,
			0x2789, 0x278A, 0x278B, 0x278C, 0x278D, 0x278E, 0x278F, 0x2790,
			0x2791, 0x2792, 0x2793, 0x2794, 0x2192, 0x2194, 0x2195, 0x2798,
			0x2799, 0x279A, 0x279B, 0x279C, 0x279D, 0x279E, 0x279F, 0x27A0,
			0x27A1, 0x27A2, 0x27A3, 0x27A4, 0x27A5, 0x27A6, 0x27A7, 0x27A8,
			0x27A9, 0x27AA, 0x27AB, 0x27AC, 0x27AD, 0x27AE, 0x27AF, NONE,
			0x27B1, 0x27B2, 0x27B3, 0x27B4, 0x27B5, 0x27B6, 0x27B7, 0x27B8,
			0x27B9, 0x27BA, 0x27BB, 0x27BC, 0x27BD, 0x27BE, NONE };

	public MacDingbat() {
		super("MacDingbat", new String[] {}, lookup);
	}

} // class MacDingbat
