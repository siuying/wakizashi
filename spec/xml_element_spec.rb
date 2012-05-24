describe "GDataXMLElement" do
  it "should create html node" do
    element = GDataXMLElement.with_html("<div><p>Hello World</p></div>")
    element.to_s.should == "Hello World"
    element.childCount.should == 1
  end
end