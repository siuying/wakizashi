describe "Wakizashi" do
  it "should parse html" do
    doc = Wakizashi::HTML("<p>Hello World</p>")
    doc.is_a?(GDataXMLDocument).should.be.true
    doc.rootElement.to_xml.should == "<html><body><p>Hello World</p></body></html>"
  end
  
  it "should parse xml" do
    doc = Wakizashi::XML("<p>Hello World</p>")
    doc.is_a?(GDataXMLDocument).should.be.true
    doc.rootElement.to_xml.should == "<p>Hello World</p>"
  end
  
  it "should search document and modify content" do
    html = "<html><body><h1>Hello World</h1><p>Welcome</p><p>Foo</p><a href='http://www.google.com'>Google</a></body></html>"
    doc = Wakizashi::HTML(html)

    link = doc.xpath("//a").first
    link["href"].should == "http://www.google.com"
    link.stringValue.should == "Google"

    link["href"] = "http://wikipedia.org"
    link.stringValue = "Wiki"

    link.to_html.should == "<a href=\"http://wikipedia.org\">Wiki</a>"
    
  end
end