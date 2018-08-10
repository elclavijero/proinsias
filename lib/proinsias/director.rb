require 'moory'

module Proinsias
  class Director
    Controller = Moory::Logistic::Controller.new(
      Configurations::PIP
    )

    def issue(token)
      Controller.issue(token.role)
    end
  end
end
