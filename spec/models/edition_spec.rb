require 'rails_helper'

RSpec.describe Edition, type: :model do
  describe 'tests model' do
    
    it 'should test the current edition' do
      edition = create(:edition)
      expect(Edition.current).to eq(edition)
    end

  end
end
