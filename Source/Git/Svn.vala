namespace GitSvnTools.Git
{
	public class Svn: RepositoryFacette
	{
		/** Constructor. */
		internal Svn(Repository repository)
		{
			base(repository);
		}
		
		/** Returns the externals as map in form of path -> target */
		public Gee.Map<string, string> get_externals() throws Error
		{
			var externals = new Gee.HashMap<string, string>();
			string[] raw = Util.Strings.split_lines(raw_show_externals());
			
			string anchor = "/";
			foreach (var line in raw)
			{
				if (Util.Strings.is_empty(line))
				{
					continue;
				}
				
				if (line.has_prefix("# "))
				{
					anchor = line.substring(2);
					continue;
				}
				
				// strips the anchor prefix (git-svn bug)
				if (line.has_prefix(anchor))
				{
					line = line.substring(anchor.length);
				}
				
				string[] chunks = line.split(" ");
				if (chunks.length != 2)
				{
					throw new Error.MALFORMED_EXTERNAL("Malformed external " + line);
				}
				
				var source = chunks[0];
				var target = anchor + chunks[1];
				externals.set(target, source);
			}
			
			return externals;
		}

		/** Returns the raw contents of the .git/info/exclude file. */
		private string raw_show_externals()
		{
			var process = new Process.Executor("git");
			process.add_argument("svn");
			process.add_argument("show-externals");
			var result = process.execute();
			return result.std_out;
		}
	}
}