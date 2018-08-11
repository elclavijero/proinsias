module Proinsias
  class AssemblyLine
    attr_writer :active

    def deferrals
      @deferrals ||= []
    end

    def active
      @active ||= Proinsias::Assembler.new
    end

    def issue(directive)
      if incoming = directive.particle
        active.feed(incoming)
        directive.commands.each { |cmd| send(cmd) }
      end
    end

    def defer
      deferrals.push(active)
      @active = nil
    end

    def reconvene
      tmp = deferrals.pop

      @active = tmp.feed(active.receiver)
    end

    def product
      deferrals.empty? ?
        active.receiver :
        nil
    end
  end
end
