namespace GitSvnTools.Process
{
	/**
	 * Represents the ruslt of an executed process.
	 */
	public class Result: GLib.Object
	{
		/** The return code of a process. */
		public int return_code { get; private set; default = 0; }
		
		/** The standard output of a process. */
		public string? std_out { get; private set; default = null; }
		
		/** The error output of a process. */
		public string? std_err { get; private set; default = null; }
		
		/** Constructor. */
		public Result(int return_code, string? std_out, string? std_err)
		{
			this.return_code = return_code;
			this.std_out = std_out;
			this.std_err = std_err;
		}
	}
}