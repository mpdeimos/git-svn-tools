namespace GitSvnTools.Process
{
	/** Helper class for convenient execution of processes. */
	class Executor: GLib.Object
	{
		/** The working directory of the process. default is current working directory (null). */
		public string? working_directory {get; set; default = null;}
		
		/** The arguments for execution. */
		private string[] arguments = {};
		
		public Executor(string executable)
		{
			this.arguments += executable;
		}
		
		/** Executes the process. return code is -1 for internal errors. */
		public Result execute()
		{
			string std_out = null;
			string std_err = null;
			int return_code = -1;
			try
			{
				GLib.Process.spawn_sync(working_directory, arguments, null, GLib.SpawnFlags.SEARCH_PATH, null, out std_out, out std_err, out return_code);
			}	
			catch (SpawnError e)
			{
       			// swallow, handled by return code
    		}
			return new Result(return_code, std_out, std_err);
		}
		
		/** Appends an argument to the list of all arguments. */
		public void add_argument(string argument)
		{
			this.arguments += argument;
		}
	}
}