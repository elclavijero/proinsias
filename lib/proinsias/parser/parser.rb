require_relative './filter'
require_relative './scanner'
require_relative './director'

module Proinsias
  class Parser
    def Parser.one_shot(str)
      new.tap { |psr| psr.analyse(str) }
    end

    def analyse(str)
      str.each_char { |c| issue(c) }
    end

    def ast
      assembly_line.product ?
      assembly_line.product.to_ast :
      nil
    end
    
    private

    def issue(char)
      scanner.issue(char)
    end

    def scanner
      @scanner ||= Proinsias::Scanner.new(
        consumer: director.method(:issue)
      )
    end

    def director
      @director ||= Proinsias::Director.new(
        consumer: assembly_line.method(:issue)
      )
    end

    def assembly_line
      @assembly_line ||= Proinsias::AssemblyLine.new
    end
  end
end
