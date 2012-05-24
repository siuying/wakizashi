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
end