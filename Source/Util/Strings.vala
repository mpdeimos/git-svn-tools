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
			
			int start = 0;
			int end = input.length;
			while (start <= end)
			{
				if (input[start] == ' ')
				{
					start++;
				}
				else if (input[end] == ' ')
				{
					end--;
				}
				else
				{
					break;
				}
			}
			
			string str = trim(input);
			
			return str == "";
		}
		
		public static string? trim(string? input)
		{
			if (input == null)
			{
				return null;
			}
			
			int start = 0;
			int end = input.length;
			while (start < end)
			{
				if (input[start] == ' ')
				{
					start++;
				}
				else if (input[end - 1] == ' ')
				{
					end--;
				}
				else
				{
					break;
				}
			}
			
			return input[start:end];
		}
		
		public static string strip_prefix(string input, string prefix)
		{
			if (prefix.length > 0 && input.has_prefix(prefix))
			{
				return input.substring(prefix.length);
			}
			
			return input;
		}
		
		public static string strip_suffix(string input, string suffix)
		{
			if (suffix.length > 0 && input.has_suffix(suffix))
			{
				return input.substring(0, input.length - suffix.length);
			}
			
			return input;
		}
		
		public static string[] times_array(string part, int times)
		{
			string[] ret = {};
			for (int i = 0; i < times; i++)
			{
				ret += part;
			}
			return ret;
		}
		
		public static string times(string part, int times, string? clue = null)
		{
			string ret = "";
			for (int i = 0; i < times; i++)
			{
				if (clue != null && i > 0)
				{
					ret += clue;
				}
				ret += part;
			}
			return ret;
		}
	}
}