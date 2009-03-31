require File.dirname(__FILE__) + '/../../spec_helper'

describe "Mixed TypeGroups (with non-generic member)" do
  csc <<-EOL
  public class StaticMethodTypeGroup {
    public static int Return(int retval) { return retval; }
  }
  public class StaticMethodTypeGroup<T> {
    public static T Return(T retval) { return retval;}
  }
  EOL

  it "allow static methods to be called on the non-generic member" do
    #regression for RubyForge 24106
    lambda {StaticMethodTypeGroup.Return(100)}.should_not raise_error
    StaticMethodTypeGroup.Return(100).should == 100
  end
end