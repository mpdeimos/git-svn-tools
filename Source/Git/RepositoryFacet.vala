namespace GitSvnTools.Git
{
	public class RepositoryFacet: Object
	{
		/** the linked repository. */
		public Repository repository {get; private set;}
		
		/** Constructor. */
		protected RepositoryFacet(Repository repository)
		{
			this.repository = repository;
		}
	}
}
