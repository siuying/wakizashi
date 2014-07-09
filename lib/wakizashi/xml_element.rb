module Wakizashi
  module Element
    module CreationMethods
      def with_html(html)
        error_ptr = Pointer.new(:id)
        elem = self.alloc.initWithHTMLString(html, error:error_ptr)
        raise Wakizashi::ParseError, error_ptr[0].description if error_ptr[0]
        elem
      end

      def with_xml(xml)
        error_ptr = Pointer.new(:id)
        elem = self.alloc.initWithXMLString(xml, error:error_ptr)
        raise Wakizashi::ParseError, error_ptr[0].description if error_ptr[0]
        elem
      end
    end

    module InstanceMethods
      def []=(key, val)
        attr = self.attributeForName(key)
        if attr
          attr.stringValue = val
        else
          attr = self.addAttribute(GDataXMLNode.attributeWithName(key, stringValue:val))
        end
        val
      end

      def [](key)
        attr = self.attributeForName(key)
        if attr
          attr.stringValue
        else
          nil
        end
      end

      def xpath *args
        GDataXMLDocument.with_html(self.XMLString).xpath *args
      end
    end
  end
end

class GDataXMLElement
  extend Wakizashi::Element::CreationMethods
  include Wakizashi::Element::InstanceMethods
end
