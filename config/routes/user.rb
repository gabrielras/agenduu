# frozen_string_literal: true

namespace :user do
  routes :companies, only: %i[:new create]
end
