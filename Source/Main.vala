namespace GitSvnTools
{
	public class Main: GLib.Object
	{
		public static void main (string[] args)
		{
			try
			{
				var repo = new Git.Repository();
				//GLib.stdout.printf (Util.Strings.join_lines(repo.internal.read_excludes()) + "\n");
				
				Gee.Map<string, string> externals = repo.svn.get_externals();
				foreach(Gee.Map.Entry<string, string> entry in externals.entries)
				{
					GLib.stdout.printf (entry.key + " -> " + entry.value + "\n");
				}
			}
			catch (Error e)
			{
				GLib.stderr.printf(e.code.to_string() + ": " + e.message + "\n");
			}
		}
	}
}