package com.jkgh.jvm.parsing.parsers {
	
	
	import com.jkgh.jvm.parsing.types.ConstantPool;
	import com.jkgh.jvm.runtime.PrimitiveLong;
	import com.jkgh.jvm.runtime.classloading.JVMClassLoadingContext;
	import com.jkgh.jvm.runtime.execution.instructions.Instruction;
	import com.jkgh.jvm.runtime.execution.instructions.java.*;
	import com.jkgh.jvm.runtime.execution.instructions.special.SwideXloadInstruction;
	import com.jkgh.jvm.runtime.execution.instructions.special.SwideXstoreInstruction;
	import com.jkgh.jvm.runtime.execution.instructions.special.SwideiincInstruction;
	import com.jkgh.jvm.runtime.execution.instructions.special.SwideretInstruction;
	import com.jkgh.jvm.tools.JVMTools;
	
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	public class BytecodeParser {
		
		private static var READERS:Dictionary/*Integer, Function*/;
		
		{
			READERS = new Dictionary();
			
			READERS[0] = function(byteCode:ByteArray, i:int):Instruction {
				return new JnopInstruction(i-1);
			};
			
			READERS[1] = function(byteCode:ByteArray, i:int):Instruction {
				return new Jaconst_nullInstruction(i-1);
			};
			
			READERS[2] = function(byteCode:ByteArray, i:int):Instruction {			
				return new Jiconst_XInstruction(i-1, -1);
			};
			
			READERS[3] = function(byteCode:ByteArray, i:int):Instruction {
				return new Jiconst_XInstruction(i-1, 0);
			};
			
			READERS[4] = function(byteCode:ByteArray, i:int):Instruction {
				return new Jiconst_XInstruction(i-1, 1);
			};
			
			READERS[5] = function(byteCode:ByteArray, i:int):Instruction {
				return new Jiconst_XInstruction(i-1, 2);
			};
			
			READERS[6] = function(byteCode:ByteArray, i:int):Instruction {
				return new Jiconst_XInstruction(i-1, 3);
			};
			
			READERS[7] = function(byteCode:ByteArray, i:int):Instruction {
				return new Jiconst_XInstruction(i-1, 4);
			};
			
			READERS[8] = function(byteCode:ByteArray, i:int):Instruction {
				return new Jiconst_XInstruction(i-1, 5);
			};
			
			READERS[9] = function(byteCode:ByteArray, i:int):Instruction {
				return new Jlconst_XInstruction(i-1, PrimitiveLong.ZERO);
			};
			
			READERS[10] = function(byteCode:ByteArray, i:int):Instruction {
				return new Jlconst_XInstruction(i-1, PrimitiveLong.ONE);
			};
			
			READERS[11] = function(byteCode:ByteArray, i:int):Instruction {
				return new Jfconst_XInstruction(i-1, 0.0);
			};
			
			READERS[12] = function(byteCode:ByteArray, i:int):Instruction {
				return new Jfconst_XInstruction(i-1, 1.0);
			};
			
			READERS[13] = function(byteCode:ByteArray, i:int):Instruction {
				return new Jfconst_XInstruction(i-1, 2.0);
			};
			
			READERS[14] = function(byteCode:ByteArray, i:int):Instruction {
				return new Jdconst_XInstruction(i-1, 0.0);
			};
			
			READERS[15] = function(byteCode:ByteArray, i:int):Instruction {
				return new Jdconst_XInstruction(i-1, 1.0);
			};
			
			READERS[16] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JbipushInstruction(i-1);
				
			};
			
			READERS[17] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JsipushInstruction(i-1);
				
			};
			
			READERS[18] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JldcInstruction(i-1);
				
			};
			
			READERS[19] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new Jldc_wInstruction(i-1);
				
			};
			
			READERS[20] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new Jldc_wInstruction(i-1); // this acts exactly as ldc2_w.
				
			};
			
			READERS[21] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JXloadInstruction(i-1);
				
			};
			
			READERS[22] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JXloadInstruction(i-1);
				
			};
			
			READERS[23] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JXloadInstruction(i-1);
				
			};
			
			READERS[24] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JXloadInstruction(i-1);
				
			};
			
			READERS[25] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JXloadInstruction(i-1);
				
			};
			
			READERS[26] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JXload_YInstruction(i-1, 0);
				
			};
			
			READERS[27] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JXload_YInstruction(i-1, 1);
				
			};
			
			READERS[28] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JXload_YInstruction(i-1, 2);
				
			};
			
			READERS[29] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JXload_YInstruction(i-1, 3);
				
			};
			
			READERS[30] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JXload_YInstruction(i-1, 0);
				
			};
			
			READERS[31] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JXload_YInstruction(i-1, 1);
				
			};
			
			READERS[32] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JXload_YInstruction(i-1, 2);
				
			};
			
			READERS[33] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JXload_YInstruction(i-1, 3);
				
			};
			
			READERS[34] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JXload_YInstruction(i-1, 0);
				
			};
			
			READERS[35] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JXload_YInstruction(i-1, 1);
				
			};
			
			READERS[36] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JXload_YInstruction(i-1, 2);
				
			};
			
			READERS[37] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JXload_YInstruction(i-1, 3);
				
			};
			
			READERS[38] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JXload_YInstruction(i-1, 0);
				
			};
			
			READERS[39] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JXload_YInstruction(i-1, 1);
				
			};
			
			READERS[40] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JXload_YInstruction(i-1, 2);
				
			};
			
			READERS[41] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JXload_YInstruction(i-1, 3);
				
			};
			
			READERS[42] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JXload_YInstruction(i-1, 0);
				
			};
			
			READERS[43] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JXload_YInstruction(i-1, 1);
				
			};
			
			READERS[44] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JXload_YInstruction(i-1, 2);
				
			};
			
			READERS[45] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JXload_YInstruction(i-1, 3);
				
			};
			
			READERS[46] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JXaloadInstruction(i-1);
				
			};
			
			READERS[47] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JXaloadInstruction(i-1);
				
			};
			
			READERS[48] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JXaloadInstruction(i-1);
				
			};
			
			READERS[49] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JXaloadInstruction(i-1);
				
			};
			
			READERS[50] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JXaloadInstruction(i-1);
				
			};
			
			READERS[51] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JXaloadInstruction(i-1);
				
			};
			
			READERS[52] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JXaloadInstruction(i-1);
				
			};
			
			READERS[53] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JXaloadInstruction(i-1);
				
			};
			
			READERS[54] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JXstoreInstruction(i-1);
				
			};
			
			READERS[55] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JXstoreInstruction(i-1);
				
			};
			
			READERS[56] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JXstoreInstruction(i-1);
				
			};
			
			READERS[57] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JXstoreInstruction(i-1);
				
			};
			
			READERS[58] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JXstoreInstruction(i-1);
				
			};
			
			READERS[59] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JXstore_YInstruction(i-1, 0);
				
			};
			
			READERS[60] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JXstore_YInstruction(i-1, 1);
				
			};
			
			READERS[61] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JXstore_YInstruction(i-1, 2);
				
			};
			
			READERS[62] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JXstore_YInstruction(i-1, 3);
				
			};
			
			READERS[63] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JXstore_YInstruction(i-1, 0);
				
			};
			
			READERS[64] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JXstore_YInstruction(i-1, 1);
				
			};
			
			READERS[65] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JXstore_YInstruction(i-1, 2);
				
			};
			
			READERS[66] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JXstore_YInstruction(i-1, 3);
				
			};
			
			READERS[68] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JXstore_YInstruction(i-1, 0);
				
			};
			
			READERS[68] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JXstore_YInstruction(i-1, 1);
				
			};
			
			READERS[69] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JXstore_YInstruction(i-1, 2);
				
			};
			
			READERS[70] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JXstore_YInstruction(i-1, 3);
				
			};
			
			READERS[71] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JXstore_YInstruction(i-1, 0);
				
			};
			
			READERS[72] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JXstore_YInstruction(i-1, 1);
				
			};
			
			READERS[73] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JXstore_YInstruction(i-1, 2);
				
			};
			
			READERS[74] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JXstore_YInstruction(i-1, 3);
				
			};
			
			READERS[75] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JXstore_YInstruction(i-1, 0);
				
			};
			
			READERS[76] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JXstore_YInstruction(i-1, 1);
				
			};
			
			READERS[77] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JXstore_YInstruction(i-1, 2);
				
			};
			
			READERS[78] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JXstore_YInstruction(i-1, 3);
				
			};
			
			READERS[79] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JXastoreInstruction(i-1);
				
			};
			
			READERS[80] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JXastoreInstruction(i-1);
				
			};
			
			READERS[81] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JXastoreInstruction(i-1);
				
			};
			
			READERS[82] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JXastoreInstruction(i-1);
				
			};
			
			READERS[83] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JXastoreInstruction(i-1);
				
			};
			
			READERS[84] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JXastoreInstruction(i-1);
				
			};
			
			READERS[85] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JXastoreInstruction(i-1);
				
			};
			
			READERS[86] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JXastoreInstruction(i-1);
				
			};
			
			READERS[87] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JpopInstruction(i-1);
				
			};
			
			READERS[88] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new Jpop2Instruction(i-1);
				
			};
			
			READERS[89] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JdupInstruction(i-1);
				
			};
			
			READERS[90] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new Jdup_x1Instruction(i-1);
				
			};
			
			READERS[91] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new Jdup_x2Instruction(i-1);
				
			};
			
			READERS[92] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new Jdup2Instruction(i-1);
				
			};
			
			READERS[93] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new Jdup2_x1Instruction(i-1);
				
			};
			
			READERS[94] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new Jdup2_x2Instruction(i-1);
				
			};
			
			READERS[95] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JswapInstruction(i-1);
				
			};
			
			READERS[96] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JiaddInstruction(i-1);
				
			};
			
			READERS[97] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JladdInstruction(i-1);
				
			};
			
			READERS[98] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JfaddInstruction(i-1);
				
			};
			
			READERS[99] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JdaddInstruction(i-1);
				
			};
			
			READERS[100] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JisubInstruction(i-1);
				
			};
			
			READERS[101] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JlsubInstruction(i-1);
				
			};
			
			READERS[102] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JfsubInstruction(i-1);
				
			};
			
			READERS[103] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JdsubInstruction(i-1);
				
			};
			
			READERS[104] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JimulInstruction(i-1);
				
			};
			
			READERS[105] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JlmulInstruction(i-1);
				
			};
			
			READERS[106] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JfmulInstruction(i-1);
				
			};
			
			READERS[107] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JdmulInstruction(i-1);
				
			};
			
			READERS[108] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JidivInstruction(i-1);
				
			};
			
			READERS[109] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JldivInstruction(i-1);
				
			};
			
			READERS[110] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JfdivInstruction(i-1);
				
			};
			
			READERS[111] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JddivInstruction(i-1);
				
			};
			
			READERS[112] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JiremInstruction(i-1);
				
			};
			
			READERS[113] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JlremInstruction(i-1);
				
			};
			
			READERS[114] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JfremInstruction(i-1);
				
			};
			
			READERS[115] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JdremInstruction(i-1);
				
			};
			
			READERS[116] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JinegInstruction(i-1);
				
			};
			
			READERS[117] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JlnegInstruction(i-1);
				
			};
			
			READERS[118] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JfnegInstruction(i-1);
				
			};
			
			READERS[119] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JdnegInstruction(i-1);
				
			};
			
			READERS[120] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JishlInstruction(i-1);
				
			};
			
			READERS[121] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JlshlInstruction(i-1);
				
			};
			
			READERS[122] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JishrInstruction(i-1);
				
			};
			
			READERS[123] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JlshrInstruction(i-1);
				
			};
			
			READERS[124] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JiushrInstruction(i-1);
				
			};
			
			READERS[125] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JlushrInstruction(i-1);
				
			};
			
			READERS[126] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JiandInstruction(i-1);
				
			};
			
			READERS[127] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JlandInstruction(i-1);
				
			};
			
			READERS[128] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JiorInstruction(i-1);
				
			};
			
			READERS[129] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JlorInstruction(i-1);
				
			};
			
			READERS[130] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JixorInstruction(i-1);
				
			};
			
			READERS[131] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JlxorInstruction(i-1);
				
			};
			
			READERS[132] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JiincInstruction(i-1);
				
			};
			
			READERS[133] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new Ji2lInstruction(i-1);
				
			};
			
			READERS[134] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new Ji2fInstruction(i-1);
				
			};
			
			READERS[135] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new Ji2dInstruction(i-1);
				
			};
			
			READERS[136] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new Jl2iInstruction(i-1);
				
			};
			
			READERS[137] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new Jl2fInstruction(i-1);
				
			};
			
			READERS[138] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new Jl2dInstruction(i-1);
				
			};
			
			READERS[139] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new Jf2iInstruction(i-1);
				
			};
			
			READERS[140] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new Jf2lInstruction(i-1);
				
			};
			
			READERS[141] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new Jf2dInstruction(i-1);
				
			};
			
			READERS[142] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new Jd2iInstruction(i-1);
				
			};
			
			READERS[143] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new Jd2lInstruction(i-1);
				
			};
			
			READERS[144] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new Jd2fInstruction(i-1);
				
			};
			
			READERS[145] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new Ji2bInstruction(i-1);
				
			};
			
			READERS[146] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new Ji2cInstruction(i-1);
				
			};
			
			READERS[147] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new Ji2sInstruction(i-1);
				
			};
			
			READERS[148] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JlcmpInstruction(i-1);
				
			};
			
			READERS[149] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JfcmplInstruction(i-1);
				
			};
			
			READERS[150] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JfcmpgInstruction(i-1);
				
			};
			
			READERS[151] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JdcmplInstruction(i-1);
				
			};
			
			READERS[152] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JdcmpgInstruction(i-1);
				
			};
			
			READERS[153] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JifeqInstruction(i-1);
				
			};
			
			READERS[154] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JifneInstruction(i-1);
				
			};	
			
			READERS[155] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JifltInstruction(i-1);
				
			};	
			
			READERS[156] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JifgeInstruction(i-1);
				
			};	
			
			READERS[157] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JifgtInstruction(i-1);
				
			};	
			
			READERS[158] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JifleInstruction(i-1);
				
			};	
			
			READERS[159] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JicmpeqInstruction(i-1);
				
			};
			
			READERS[160] = function(byteCode:ByteArray, i:int):Instruction {
				
				
				return new JicmpneInstruction(i-1);
				
			};	
			
			READERS[161] = function(byteCode:ByteArray, i:int):Instruction {
				return new JicmpltInstruction(i-1);
			};	
			
			READERS[162] = function(byteCode:ByteArray, i:int):Instruction {
				return new JicmpgeInstruction(i-1);
			};	
			
			READERS[163] = function(byteCode:ByteArray, i:int):Instruction {
				return new JicmpgtInstruction(i-1);
			};	
			
			READERS[164] = function(byteCode:ByteArray, i:int):Instruction {
				return new JicmpleInstruction(i-1);
			};	
			
			READERS[165] = function(byteCode:ByteArray, i:int):Instruction {
				return new JacmpeqInstruction(i-1);
			};	
			
			READERS[166] = function(byteCode:ByteArray, i:int):Instruction {
				return new JacmpneInstruction(i-1);
			};
			
			READERS[167] = function(byteCode:ByteArray, i:int):Instruction {
				return new JgotoInstruction(i-1);
			};
			
			READERS[168] = function(byteCode:ByteArray, i:int):Instruction {
				return new JjsrInstruction(i-1);
			};
			
			READERS[169] = function(byteCode:ByteArray, i:int):Instruction {
				return new JretInstruction(i-1);
			};
			
			READERS[170] = function(byteCode:ByteArray, i:int):Instruction {
				return new JtableswitchInstruction(i-1);
			};
			
			READERS[171] = function(byteCode:ByteArray, i:int):Instruction {
				return new JlookupswitchInstruction(i-1);
			};
			
			READERS[172] = function(byteCode:ByteArray, i:int):Instruction {
				return new JreturnInstruction(i-1);
			};
			
			READERS[173] = function(byteCode:ByteArray, i:int):Instruction {
				return new JreturnInstruction(i-1);
			};
			
			READERS[174] = function(byteCode:ByteArray, i:int):Instruction {
				return new JreturnInstruction(i-1);
			};
			
			READERS[175] = function(byteCode:ByteArray, i:int):Instruction {
				return new JreturnInstruction(i-1);
			};
			
			READERS[176] = function(byteCode:ByteArray, i:int):Instruction {
				return new JreturnInstruction(i-1);
			};
			
			READERS[177] = function(byteCode:ByteArray, i:int):Instruction {
				return new JreturnInstruction(i-1);
			};
			
			READERS[178] = function(byteCode:ByteArray, i:int):Instruction {
				return new JgetstaticInstruction(i-1);
			};
			
			READERS[179] = function(byteCode:ByteArray, i:int):Instruction {
				return new JputstaticInstruction(i-1);
			};
			
			READERS[180] = function(byteCode:ByteArray, i:int):Instruction {
				return new JgetfieldInstruction(i-1);
			};
			
			READERS[181] = function(byteCode:ByteArray, i:int):Instruction {
				return new JputfieldInstruction(i-1);
			};
			
			READERS[182] = function(byteCode:ByteArray, i:int):Instruction {
				return new JinvokevirtualInstruction(i-1);
			};
			
			READERS[183] = function(byteCode:ByteArray, i:int):Instruction {
				return new JinvokespecialInstruction(i-1);
			};
			
			READERS[184] = function(byteCode:ByteArray, i:int):Instruction {
				return new JinvokestaticInstruction(i-1);
			};
			
			READERS[185] = function(byteCode:ByteArray, i:int):Instruction {
				return new JinvokeinterfaceInstruction(i-1);
			};
			
			READERS[186] = function(byteCode:ByteArray, i:int):Instruction {
				return new JinvokedynamicInstruction(i-1);
			};
			
			READERS[187] = function(byteCode:ByteArray, i:int):Instruction {
				return new JnewInstruction(i-1);
			};
			
			READERS[188] = function(byteCode:ByteArray, i:int):Instruction {
				return new JnewarrayInstruction(i-1);
			};
			
			READERS[189] = function(byteCode:ByteArray, i:int):Instruction {
				return new JanewarrayInstruction(i-1);
			};
			
			READERS[190] = function(byteCode:ByteArray, i:int):Instruction {
				return new JarraylengthInstruction(i-1);
			};
			
			READERS[191] = function(byteCode:ByteArray, i:int):Instruction {
				return new JathrowInstruction(i-1);
			};
			
			READERS[192] = function(byteCode:ByteArray, i:int):Instruction {
				return new JcheckcastInstruction(i-1);
			};
			
			READERS[193] = function(byteCode:ByteArray, i:int):Instruction {
				return new JinstanceofInstruction(i-1);
			};
			
			READERS[194] = function(byteCode:ByteArray, i:int):Instruction {
				return new JmonitorenterInstruction(i-1);
			};
			
			READERS[195] = function(byteCode:ByteArray, i:int):Instruction {
				return new JmonitorexitInstruction(i-1);
			};
			
			READERS[196] = function(byteCode:ByteArray, i:int):Instruction {
				var opcode:int = JVMTools.readUnsignedByte(byteCode, i);
				if (opcode == 132) {
					return new SwideiincInstruction(i-1);
				} else if (opcode == 169) {
					return new SwideretInstruction(i-1);
				} else if (opcode < 26) {
					return new SwideXloadInstruction(i-1);
				} else {
					return new SwideXstoreInstruction(i-1);
				}
			};
			
			READERS[197] = function(byteCode:ByteArray, i:int):Instruction {
				return new JmultianewarrayInstruction(i-1);
			};
			
			READERS[198] = function(byteCode:ByteArray, i:int):Instruction {
				return new JifnullInstruction(i-1);
			};
			
			READERS[199] = function(byteCode:ByteArray, i:int):Instruction {
				return new JifnonnullInstruction(i-1);
			};
			
			READERS[200] = function(byteCode:ByteArray, i:int):Instruction {
				return new Jgoto_wInstruction(i-1);
			};
			
			READERS[201] = function(byteCode:ByteArray, i:int):Instruction {
				return new Jjsr_wInstruction(i-1);
			};
		}
		
		private var byteCode:ByteArray;
		private var constantPool:ConstantPool;
		private var instructions:Dictionary/*Integer, Instruction*/;
		private var classLoadingContext:JVMClassLoadingContext;
		private var requested:Vector.<InstructionWaiter>;
		
		public function BytecodeParser(classLoadingContext:JVMClassLoadingContext, value:ByteArray, constantPool:ConstantPool) {
			this.classLoadingContext = classLoadingContext;
			this.byteCode = value;
			this.constantPool = constantPool;
			this.instructions = new Dictionary();
			this.requested = new Vector.<InstructionWaiter>();
			
			parseSpecific(0);
		}
		
		public function parseSpecific(i:int):void {
			requested.push(new InstructionWaiter(i, function(instruction:Instruction):void {
			}));
			while (requested.length > 0) {
				var waiter:InstructionWaiter = requested.pop();
				var ret:Instruction = instructions[waiter.getOffset()];
				if (ret == null) {
					var opcode:int = JVMTools.readUnsignedByte(byteCode, waiter.getOffset());
					var reader:Function = READERS[opcode];
					ret = reader(byteCode, waiter.getOffset()+1);
					instructions[waiter.getOffset()] = ret;
					ret.parseParameterBytecodes(byteCode, waiter.getOffset()+1, this);
				}
				waiter.waited(ret);
			}
		}

		public function parseInstructionAt(i:int):Instruction {
			parseSpecific(i);
			return instructions[i];
		}
		
		public function getEntryPoint():Instruction {
			return instructions[0];
		}
		
		public function getConstantPool():ConstantPool {
			return constantPool;
		}
		
		public function getClassLoadingContext():JVMClassLoadingContext {
			return classLoadingContext;
		}
		
		public function request(instructionWaiter:InstructionWaiter):void {
			var instruction:Instruction = instructions[instructionWaiter.getOffset()];
			if (instruction != null) {
				instructionWaiter.waited(instruction);
			} else {
				requested.push(instructionWaiter);
			}
		}
	}
}
