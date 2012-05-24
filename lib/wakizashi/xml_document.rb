module Wakizashi
  module Options
    HTML_PARSE_RECOVER = 1 # Relaxed parsing
    HTML_PARSE_NODEFDTD = 4 # do not default a doctype if not found
    HTML_PARSE_NOERROR = 32 # suppress error reports
    HTML_PARSE_NOWARNING = 64 # suppress warning reports
    HTML_PARSE_PEDANTIC = 128 # pedantic error reporting
    HTML_PARSE_NOBLANKS = 256 # remove blank nodes
    HTML_PARSE_NONET = 2048 # Forbid network access
    HTML_PARSE_NOIMPLIED = 8192 # Do not add implied html/body... elements
    HTML_PARSE_COMPACT = 65536 # compact small text nodes
    HTML_PARSE_IGNORE_ENC = 2097152 # ignore internal document encoding hint
    HTML_PARSE_OPTIONS = {
      :recover => HTML_PARSE_RECOVER,
      :nodefdtd => HTML_PARSE_NODEFDTD,
      :noerror => HTML_PARSE_NOERROR,
      :nowarning => HTML_PARSE_NOWARNING,
      :pedantic => HTML_PARSE_PEDANTIC,
      :noblanks => HTML_PARSE_NOBLANKS,
      :nonet => HTML_PARSE_NONET,      
      :noimplied => HTML_PARSE_NOIMPLIED,      
      :compact => HTML_PARSE_COMPACT,
      :ignore_enc => HTML_PARSE_IGNORE_ENC
    }
    DEFAULT_HTML_OPTIONS = [:nowarning, :noerror]
    
    XML_PARSE_RECOVER = 1 # recover on errors
    XML_PARSE_NOENT = 2 # substitute entities
    XML_PARSE_DTDLOAD = 4 # load the external subset
    XML_PARSE_DTDATTR = 8 # default DTD attributes
    XML_PARSE_DTDVALID = 16 # validate with the DTD
    XML_PARSE_NOERROR = 32 # suppress error reports
    XML_PARSE_NOWARNING = 64 # suppress warning reports
    XML_PARSE_PEDANTIC = 128 # pedantic error reporting
    XML_PARSE_NOBLANKS = 256 # remove blank nodes
    XML_PARSE_SAX1 = 512 # use the SAX1 interface internally
    XML_PARSE_XINCLUDE = 1024 # Implement XInclude substitition
    XML_PARSE_NONET = 2048 # Forbid network access
    XML_PARSE_NODICT = 4096 # Do not reuse the context dictionnary
    XML_PARSE_NSCLEAN = 8192 # remove redundant namespaces declarations
    XML_PARSE_NOCDATA = 16384 # merge CDATA as text nodes
    XML_PARSE_NOXINCNODE = 32768 # do not generate XINCLUDE START/END nodes
    XML_PARSE_COMPACT = 65536 # compact small text nodes; no modification of the tree allowed afterwards (will possibly crash if you try to modify the tree)
    XML_PARSE_OLD10 = 131072 # parse using XML-1.0 before update 5
    XML_PARSE_NOBASEFIX = 262144 # do not fixup XINCLUDE xml:base uris
    XML_PARSE_HUGE = 524288 # relax any hardcoded limit from the parser
    XML_PARSE_OLDSAX = 1048576 # parse using SAX2 interface before 2.7.0
    XML_PARSE_IGNORE_ENC = 2097152 # ignore internal document encoding hint
    XML_PARSE_OPTIONS = {
      :recover => XML_PARSE_RECOVER,
      :noent => XML_PARSE_NOENT,
      :dtdload => XML_PARSE_DTDLOAD,
      :dtdattr => XML_PARSE_DTDATTR,
      :dtdvalid => XML_PARSE_DTDVALID,
      :noerror => XML_PARSE_NOERROR,
      :nowarning => XML_PARSE_NOWARNING,
      :pedantic => XML_PARSE_PEDANTIC,
      :noblanks => XML_PARSE_NOBLANKS,
      :sax1 => XML_PARSE_SAX1,
      :xinclude => XML_PARSE_XINCLUDE,
      :nonet => XML_PARSE_NONET,
      :nodict => XML_PARSE_NODICT,
      :nsclean => XML_PARSE_NSCLEAN,
      :nocdata => XML_PARSE_NOCDATA,
      :noxincnode => XML_PARSE_NOXINCNODE,
      :compact => XML_PARSE_COMPACT,
      :old10 => XML_PARSE_OLD10,
      :nobasefix => XML_PARSE_NOBASEFIX,
      :huge => XML_PARSE_HUGE,
      :oldsax => XML_PARSE_OLDSAX,
      :ignore_enc => XML_PARSE_IGNORE_ENC
    }

    DEFAULT_XML_OPTIONS = [:nocdata, :noblanks]
  end
  
  module DocCreationMethods
    include Options

    def with_html(html, *options)
      if options.size == 1 && options[0].is_a?(Fixnum)
        options_mask = options[0]
      else      
        options = DEFAULT_HTML_OPTIONS if options.size == 0
        options_mask = option_to_mask(options, HTML_PARSE_OPTIONS)
      end
      error_ptr = Pointer.new(:id)
      if html.is_a?(NSData)
        elem = self.alloc.initWithHTMLData(html, options:options_mask, error:error_ptr)
      else
        elem = self.alloc.initWithHTMLString(html, options:options_mask, error:error_ptr)
      end
      raise Wakizashi::ParseError, error_ptr[0].description if error_ptr[0]
      elem
    end
  
    def with_xml(xml, *options)
      if options.size == 1 && options[0].is_a?(Fixnum)
        options_mask = options[0]
      else
        options = DEFAULT_XML_OPTIONS if options.size == 0
        options_mask = option_to_mask(options, XML_PARSE_OPTIONS)
      end
      error_ptr = Pointer.new(:id)
      if xml.is_a?(NSData)
        elem = self.alloc.initWithData(xml, options:options_mask, error:error_ptr)
      else
        elem = self.alloc.initWithXMLString(xml, options:options_mask, error:error_ptr)
      end
      raise Wakizashi::ParseError, error_ptr[0].description if error_ptr[0]
      elem
    end
  
    protected
    # TODO fix me with proper mask
    def option_to_mask(options, all_options)
      mask = 0
      options.each do |key|
        if all_options.keys.include?(key)
          mask = mask | all_options[key]
        else
          raise "option not supported: #{key}. must be one of: #{all_options.keys}"
        end
      end
      mask
    end
  end
end

class GDataXMLDocument
  extend Wakizashi::DocCreationMethods
end