namespace GitSvnTools.Git
{
	public class RepositoryFacette: Object
	{
		/** the linked repository. */
		public Repository repository {get; private set;}
		
		/** Constructor. */
		protected RepositoryFacette(Repository repository)
		{
			this.repository = repository;
		}
	}
}
