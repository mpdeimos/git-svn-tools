namespace GitSvnTools.Git
{
	public class SvnExternal : Object
	{
		public string anchor {get; private set;}
		public string source {get; private set;}
		public string target {get; private set;}
		public string target_relative {get; private set;}
		public SvnExternalType external_type {get; private set;}
		
		public SvnExternal(Repository repo, string anchor, string source, string target)
		{
			this.anchor = Util.Strings.strip_prefix(anchor, "/");
			this.source = (this.anchor + source);
			if (target.has_prefix("^/"))
			{
				this.external_type = SvnExternalType.LINK_ABSOLUTE;
				this.target = Util.Strings.strip_prefix(target, "^/");
				this.target_relative = Util.Files.get_relative_path(this.anchor, this.target);
			}
			else if (target.has_prefix(".."))
			{
				this.external_type = SvnExternalType.LINK_RELATIVE;
				this.target_relative = target;
				this.target = Util.Files.resolve_path(this.anchor, target);
			}
			else
			{
				this.external_type = SvnExternalType.OTHER;
				this.target = target;
			}
		}
	}
	
	public enum SvnExternalType
	{
		LINK_ABSOLUTE,
		LINK_RELATIVE,
		OTHER /* TBD */
	}
}
