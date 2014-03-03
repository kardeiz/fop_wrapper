module FopWrapper
  class Transformer
  
    def initialize(input, output)
      @input, @output = input, output
    end
    
    def fop_factory
      @fop_factory ||= org.apache.fop.apps.FopFactory.new_instance
    end
    
    def output_stream
      @output_stream ||= begin
        fs = java.io.FileOutputStream.new(@output)
        java.io.BufferedOutputStream.new(fs)
      end
    end
    
    def fop
      @fop ||= begin
        mime_type = org.apache.fop.apps.MimeConstants::MIME_PDF
        fop_factory.new_fop(mime_type, output_stream)
      end
    end
    
    def source
      @source ||= javax.xml.transform.stream.StreamSource.new(@input)
    end
    
    def transformer_factory
      @transformer_factory ||= begin
        javax.xml.transform.TransformerFactory.new_instance
      end
    end
    
    def transformer
      @transformer ||= transformer_factory.new_transformer
    end
    
    def result
      @result ||= javax.xml.transform.sax.SAXResult.new(fop.get_default_handler)
    end
    
    def transform
      transformer.transform(source, result).tap do |o|
        output_stream.close
      end
    end
    
  end
end
