namespace GitSvnTools.Util
{
	public class StringsTest : Test
	{
		public StringsTest()
		{
			add_test("strip_prefix", test_strip_prefix);
			add_test("strip_suffix", test_strip_suffix);
			add_test("times", test_times);
		}
		
		public void test_strip_suffix()
		{
			assert("foobar" == Strings.strip_suffix("foobarxxx", "xxx"));
			assert("foobar" == Strings.strip_suffix("foobar", ""));
			assert("" == Strings.strip_suffix("", "foo"));
			assert("" == Strings.strip_suffix("", ""));
		}
		
		public void test_strip_prefix()
		{
			assert("foobar" == Strings.strip_prefix("xxxfoobar", "xxx"));
			assert("foobar" == Strings.strip_prefix("foobar", ""));
			assert("" == Strings.strip_prefix("", "foo"));
			assert("" == Strings.strip_prefix("", ""));
		}
		
		public void test_times()
		{
			assert("" == Strings.times("xy", 0));
			assert("xy" == Strings.times("xy", 1));
			assert("xyxy" == Strings.times("xy", 2));
			
			assert("" == Strings.times("xy", 0, "."));
			assert("xy" == Strings.times("xy", 1, "."));
			assert("xy.xy" == Strings.times("xy", 2, "."));
			assert("xy.xy.xy" == Strings.times("xy", 3, "."));
		}
	}
}