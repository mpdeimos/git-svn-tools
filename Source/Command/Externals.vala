namespace GitSvnTools.Command
{
	
	public class Externals
	{
		public int return_code {get; private set; default = 0;}
		private Git.Repository repo;
		
		public Externals(string[] args) throws Error
		{
			this.repo = new Git.Repository();
			
			do_list_externals();
		}
		
		public void do_list_externals() throws Error
		{
			Git.SvnExternal[] externals = repo.svn.get_externals();
			foreach(var external in externals)
			{
				string target = external.target;
				string type = "A";
				if (external.external_type == Git.SvnExternalType.LINK_RELATIVE)
				{
					target = external.target_relative;
					type = "R";
				}
				GLib.stdout.printf(type + "  " + external.source + " -> " + target + "\n");
			}
		} 
	}
}
