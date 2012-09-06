namespace GitSvnTools.Git
{
	/** Represents a Git repository. */	
	public class Repository: GLib.Object
	{
		/** The repository root. */
		public string root {get; private set;}
		
		public Internal internal {get; private set;}
		public Svn svn {get; private set;}
		
		/** Constructs a GitRepository for the current working directory (or parent directories). */
		public Repository() throws Error
		{
			this.with_root(get_repository_root());
		}
		
		/** Constructs a GitRepository with the given path as root. */
		public Repository.with_root(string? repository_path) throws Error
		{
			if (repository_path == null)
			{
				throw new Error.INVALID_REPOSITORY("null is no valid repository");
			}
			
			this.root = Util.Files.resolve(repository_path);
			
			if (!Util.Files.is_directory(Util.Files.resolve(this.root, ".git")))
			{
				throw new Error.INVALID_REPOSITORY(this.root + " is no valid repository");
			}
			
			this.internal = new Internal(this);
			this.svn = new Svn(this);
		}
		
		/** Returns the repository root of the current directory or any parent directory. Null if no repository is found. */
		private static string? get_repository_root()
		{
			var process = new Process.Executor("git");
			process.add_argument("rev-parse");
			process.add_argument("--show-cdup");
			var result = process.execute();
			
			if (result.return_code == 0)
			{
				return Util.Strings.split_lines(result.std_out)[0];
			}
			
			return null;
		}
	}
}