require_relative './filter'
require_relative './scanner'
require_relative './director'

module Proinsias
  module NilExtension
    refine NilClass do
      def to_ast;end
    end
  end

  class Parser
    attr_accessor :consumer, :quarantine

    using NilExtension

    def Parser.one_shot(str)
      new.tap { |psr| psr.analyse(str) }
    end

    SKIP = proc {}

    def initialize(consumer:nil, quarantine:SKIP)
      @consumer   = consumer
      @quarantine = quarantine
    end

    def analyse(str)
      str.each_char { |c| issue(c) }
    end

    def issue(char)
      scanner.issue(char)
      forward
    end

    def ast
      product.to_ast
    end

    def product
      assembly_line.product
    end

    private

    def forward
      consumer.call(product) if product && consumer
    end

    def scanner
      @scanner ||= Proinsias::Scanner.new(
        consumer: director.method(:issue)
      )
    end

    def director
      @director ||= Proinsias::Director.new(
        consumer:   assembly_line.method(:issue),
        quarantine: quarantine
      )
    end

    def assembly_line
      @assembly_line ||= Proinsias::AssemblyLine.new
    end
  end
end
