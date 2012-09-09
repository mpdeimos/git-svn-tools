namespace GitSvnTools.Git
{
	public class SvnFacet: RepositoryFacet
	{
		/** Constructor. */
		internal SvnFacet(Repository repository)
		{
			base(repository);
		}
		
		/** Returns the externals as map in form of path -> target */
		public SvnExternal[] get_externals() throws Error
		{
			SvnExternal[] externals = {};
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
				
				externals += new SvnExternal(this.repository, anchor, chunks[1], chunks[0]);
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