module Wakizashi
  class ParseError < StandardError; end
  
  module_function
  
  def XML(xml, *options)
    ::GDataXMLDocument.with_xml(xml, *options)
  end
  
  def HTML(html, *options)
    ::GDataXMLDocument.with_html(html, *options)
  end
end
