describe "Wakizashi" do
  it "should parse html" do
    doc = Wakizashi.HTML("<p>Hello World</p>")
    doc.rootElement.to_xml.should == "<html><body><p>Hello World</p></body></html>"
  end
end