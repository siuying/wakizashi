describe "GDataXMLElement" do
  it "should create html node" do
    element = GDataXMLElement.with_html("<div><p>Hello World</p></div>")
    element.to_s.should == "Hello World"
    element.childCount.should == 1
  end
  
  it "should read and write attribute and value" do
    element = GDataXMLElement.with_xml("<a href='http://www.google.com'>Google</a>")
    element["href"].should == "http://www.google.com"

    element["href"] = "http://wikipedia.org"
    element.stringValue = "Wikipedia"
    element.to_xml.should == '<a href="http://wikipedia.org">Wikipedia</a>'
  end
end