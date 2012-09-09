namespace GitSvnTools
{
	public class Test : GLib.Object
	{
		public GLib.TestSuite suite {get; private set;}
		private TestCase[] cases = {};
		
		protected delegate void TestMethod();
		
		public Test(string? name = null)
		{
			string testName = name ?? this.get_type().name();
			this.suite = new GLib.TestSuite(testName);
		}
		
		protected virtual void set_up()
		{
		}
		
		protected virtual void tear_down()
		{
		}
		
		protected void add_test(string name, owned TestMethod function)
		{
			var test_case = new TestCase(name, this, (owned) function);
			this.cases += test_case;
			suite.add(test_case.create_test_case());
		}
		
		private class TestCase
		{
			private string name;
			private Test test;
			private TestMethod method;
			
			public TestCase(string name, Test test, owned TestMethod method)
			{
				this.name = name;
				this.test = test;
				this.method = (owned) method;
			}
			
			public void set_up(void* fixture)
			{
				this.test.set_up();
			}
			
			public void tear_down(void* fixture)
			{
				this.test.tear_down();
			}
			
			public void execute(void* fixture)
			{
				this.method();
			}
			
			public GLib.TestCase create_test_case()
			{
 				return new GLib.TestCase(this.name, this.set_up, this.execute, this.tear_down);
			}
		}
	}
}