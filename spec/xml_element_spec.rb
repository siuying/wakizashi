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

  it "should query sub-elements" do
    doc = GDataXMLDocument.with_html <<-HTML
      <div><p>You found me!</p></div>
      <p>I hope, you didn't find me!</p>
    HTML
    element = doc.xpath("//div").first

    element.xpath("//p").map(&:stringValue).join('').should == "You found me!"
  end
end
