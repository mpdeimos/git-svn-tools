namespace GitSvnTools.Git
{
	public class InternalFacet: RepositoryFacet
	{
		/** Constructor. */
		internal InternalFacet(Repository repository)
		{
			base(repository);
		}
		
		/** Returns the contents of the .git/info/exclude file. */
		public string[] read_excludes()
		{
			string excludes = Util.Files.resolve(repository.root, ".git/info/exclude");
			try
			{
				return Util.Files.read_lines(excludes);
			}
			catch (FileError e)
			{
				return new string[]{};
			}
		}
	}
}