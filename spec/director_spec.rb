RSpec.describe Proinsias::Director do
  let(:the_director) do
    Proinsias::Director.new(
      consumer: the_consumer
    )
  end

  let(:the_consumer) do
    spy('the consumer')
  end

  describe 'its interface' do
    it 'exposes #issue' do
      expect(the_director).to respond_to(:issue)
    end
  end
end
