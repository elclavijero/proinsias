module Proinsias
  module Disposition
    module Optimistic
      attr_reader :strength
      include Comparable
  
      def <=>(other)
        return  1 if strength >  other.strength
        return  1 if strength == other.strength
        return -1 if strength <  other.strength
      end
    end
  
    module Pessimistic
      attr_reader :strength
      include Comparable
  
      def <=>(other)
        return  1 if strength >  other.strength
        return -1 if strength == other.strength
        return -1 if strength <  other.strength
      end
    end
  end
end
