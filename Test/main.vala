namespace GitSvnTools
{
	public class TestMain: GLib.Object {
		public static int main (string[] args) {
			GLib.Test.init (ref args);
			var root = TestSuite.get_root();
			
			root.add_suite(new GitSvnTools.Util.StringsTest().suite);
			root.add_suite(new GitSvnTools.Util.FilesTest().suite);
			
			return GLib.Test.run ();
		}
	}
}