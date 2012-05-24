describe "GDataXMLDocument" do
  it "should parse html document" do
    doc = GDataXMLDocument.with_html("<ul><li>Hello World</li></ul>")
    doc.rootElement.name.should == "html"    
  end
  
  it "should parse xml document" do
    doc = GDataXMLDocument.with_xml("<table><tr><td>Hi</td></tr></table>")
    doc.rootElement.name.should == "table"
  end
  
  it "should raise ParseError on invalid XML" do
    lambda { GDataXMLDocument.with_xml("<table><tr><td>Hi</td></tr>", :noerror, :nowarning) }.
      should.raise(Wakizashi::ParseError).
      message.should.match(/com.google.GDataXML error -1/)
  end
  
  it "search elment with xpath" do
    doc = GDataXMLDocument.with_html("<ul><li><p>Hello World</p></li><li>Boom</li></ul>")
    nodes = doc.xpath("//li")
    nodes.size.should == 2
    nodes.first.class.should == GDataXMLElement
  end
end