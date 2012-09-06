namespace GitSvnTools.Util
{
	/** Streamlined file utility functions. */
	public class Files
	{
		/** Resolves a relative path. */
		public static string resolve(string path, string? relative = null)
		{
			File file = File.new_for_path(path);
			if (relative != null)
			{
				File parent = file;
				file = parent.resolve_relative_path(relative);
				//parent.unref();
			}
			string ret = file.get_path();
			//file.unref();
			return ret;
		}
		
		/** Tests wether the file is path directory. */
		public static bool is_directory(string path)
		{
			return GLib.FileUtils.test(path, FileTest.IS_DIR);
		}
		
		/** Tests wether the file exists. */
		public static bool exists(string file)
		{
			return GLib.FileUtils.test(file, FileTest.EXISTS);
		}
		
		/** Reads a file and returns its content. */
		public static string read(string file) throws FileError
		{
			string contents;
			GLib.FileUtils.get_contents(file, out contents);
			
			return contents;
		}
		
		/** Reads a file line by line. */
		public static string[] read_lines(string file) throws FileError
		{
			return Strings.split_lines(read(file));
		}
	}
}
