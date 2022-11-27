# frozen_string_literal: true

module Users
  module PartnershipAwards
    module Create
      class Templates < Actor 
        input :award, type: Award

        def call
          ModalAwardTemplate.create!(
            
          )
          PageAwardTemplate.create!(
            
          )
          RewardTemplate.create!(
            
          )
        rescue StandardError => e
          fail!(error: e.message)
        end
      end
    end
  end
end
