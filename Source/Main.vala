namespace GitSvnTools
{
	public class Main: GLib.Object
	{
		public static int main (string[] args)
		{
			try
			{
				if (args.length >= 2)
				{
					if (args[1] == "externals")
					{
						return new Command.Externals(args[2:args.length]).return_code;
					}
				}
				
				return print_help();
			}
			catch (Error e)
			{
				GLib.stderr.printf(e.code.to_string() + ": " + e.message + "\n");
				return e.code;
			}
		}
		
		private static int print_help()
		{
			GLib.stdout.printf("Usage: git-svn-tools externals update\n");
			return -1;
		}
	}
}