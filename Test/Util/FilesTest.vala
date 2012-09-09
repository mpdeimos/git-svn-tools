namespace GitSvnTools.Util
{
	public class FilesTest : Test
	{
		public FilesTest()
		{
			add_test("get_relative_path", test_get_relative_path);
			add_test("path_combine", test_path_combine);
			add_test("resolve_relative_path", test_resolve_relative_path);
		}
		
		public void test_get_relative_path()
		{
			assert("" == Files.get_relative_path("", ""));
			assert("foo" == Files.get_relative_path("", "foo"));
			assert("foo/bar" == Files.get_relative_path("", "foo/bar"));
			assert("foo/bar" == Files.get_relative_path("/", "/foo/bar"));
			
			assert("../foo/bar" == Files.get_relative_path("gosh", "foo/bar"));
			assert("../../foo/bar" == Files.get_relative_path("gosh/dah", "foo/bar"));
			
			assert("../../foo/bar" == Files.get_relative_path("/gosh/dah", "foo/bar"));
			
			assert("" == Files.get_relative_path("/gosh/dah/foo/bar", "/gosh/dah/foo/bar"));
			assert(".." == Files.get_relative_path("/gosh/dah/foo/bar", "/gosh/dah/foo"));
			
		}
		
		public void test_resolve_relative_path()
		{
			assert("" == Files.resolve_path(""));
			assert("/foo/bar" == Files.resolve_path("/foo/bar"));
			assert("/foo" == Files.resolve_path("/foo/bar/../"));
			assert("/foo/baz" == Files.resolve_path("/foo/bar/../baz"));
			assert("gaz" == Files.resolve_path("foo/bar/../baz/../../gaz"));
			assert("../gaz" == Files.resolve_path("foo/bar/../../../gaz"));
			assert("../gaz" == Files.resolve_path("foo/bar/","../../../gaz"));
			assert("../../doh" == Files.resolve_path("foo/bar/../../../gaz/goh/../../../doh"));
			assert(".." == Files.resolve_path(".."));
			assert("../gaz" == Files.resolve_path("../gaz"));
			assert("/.." == Files.resolve_path("/.."));
			assert("/../gaz" == Files.resolve_path("/../gaz"));
		}
				
		public void test_path_combine()
		{
			assert("" == Files.combine_path("", ""));
			assert("foo" == Files.combine_path("", "foo"));
			assert("/foo" == Files.combine_path("/", "foo"));
			assert("foo/bar" == Files.combine_path("foo", "bar"));
			assert("/foo/bar" == Files.combine_path("/foo", "bar"));
			assert("foo/bar/../../gaz" == Files.combine_path("foo/bar/","../../gaz"));
		}
	}
}