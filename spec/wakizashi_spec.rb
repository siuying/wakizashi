describe "Wakizashi" do
  it "should parse html" do
    doc = Wakizashi.HTML("<p>Hello World</p>")
    doc.is_a?(GDataXMLDocument).should.be.true
    doc.rootElement.to_xml.should == "<html><body><p>Hello World</p></body></html>"
  end
  
  it "should parse xml" do
    doc = Wakizashi.XML("<p>Hello World</p>")
    doc.is_a?(GDataXMLDocument).should.be.true
    doc.rootElement.to_xml.should == "<p>Hello World</p>"
  end
  
end