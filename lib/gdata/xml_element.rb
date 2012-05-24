class GDataXMLElement
  def self.with_html(html)
    error_ptr = Pointer.new(:id)
    elem = self.alloc.initWithHTMLString(html, error:error_ptr)
    raise GData::XMLError, error_ptr[0].description if error_ptr[0]
    elem
  end
  
  def self.with_xml(xml)
    error_ptr = Pointer.new(:id)
    elem = self.alloc.initWithXMLString(xml, error:error_ptr)
    raise GData::XMLError, error_ptr[0].description if error_ptr[0]
    elem
  end
end
