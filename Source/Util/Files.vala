namespace GitSvnTools.Util
{
	/** Streamlined file utility functions. */
	public class Files
	{
		public static string combine_path(string first, string second)
		{
			string ret = first;
			if (!Strings.is_empty(first) && !Strings.is_empty(second) && !first.has_suffix("/") && !second.has_prefix("/"))
			{
				ret += "/";
			}
			return ret + second;
		}
		
		public static string resolve_path(string _path, string? relative = null)
		{
			string path = _path;
			if (relative != null)
			{
				path = combine_path(path, relative);
			}
			string[] parts = path.split("/");
			string[] ret = {};
			int relative_parts = 0;
					
			foreach (var part in parts)
			{
				if (Strings.is_empty(part) || part == ".")
				{
					continue;
				}
				
				if (part == "..")
				{
					if (ret.length > 0)
					{
						ret = ret[0: ret.length -1];
					}
					else
					{
						relative_parts++;
					}
					continue;
				}
				
				ret += part;
			}
			
			path = Files.combine_path(Strings.times("..", relative_parts, "/"), string.joinv("/", ret));
			if (_path.has_prefix("/"))
			{
				path = "/" + path;
			}
			return path;
		}
		
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
		
		/** Returns the relative path from a parent directory to another path. Assumes that parent_directory is Array directory (for resolving). */
		public static string get_relative_path(string parent_directory, string path)
		{
			string parent = Strings.strip_prefix(parent_directory, "/");
			parent = Strings.strip_suffix(parent, "/");
			
			string folder = Strings.strip_prefix(path, "/");
			folder = Strings.strip_suffix(folder, "/");
			
			string[] parentFolders = parent.split("/");
			string[] folders = folder.split("/");
			
			int i = 0;
			for (; i < int.min(folders.length, parentFolders.length); i++)
			{
				if (parentFolders[i] != folders[i])
				{
					break;
				}
			}
			
			string[] relative = Strings.times_array("..", parentFolders.length - i);
			
			foreach (var part in folders[i:folders.length])
			{
				relative += part;
			}
			
			return string.joinv("/",relative);
		}
	}
}
