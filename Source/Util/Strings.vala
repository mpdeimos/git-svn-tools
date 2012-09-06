namespace GitSvnTools.Util
{
	/** String utility functions. */
	class Strings
	{
		public static const string NEWLINE_DELIMITER = "\n";
		
		public static string[] split_lines(string input)
		{
			return input.split(NEWLINE_DELIMITER);
		} 
		
		public static string join_lines(string[] input)
		{
			return string.joinv(NEWLINE_DELIMITER, input);
		}
		
		/** Returns true if the string is null or empty. */
		public static bool is_empty(string? input)
		{
			if (input == null)
			{
				return true;
			}
			
			string str = input.strip();
			return str == "";
		}
	}
}
