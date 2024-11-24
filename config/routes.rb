# frozen_string_literal: true

Rails.application.routes.draw do
  root 'blood_pressure_calculator#new' # this is the home page where user will enters values and get a result
  post '/', to: 'blood_pressure_calculator#new' # post the values to the same page
end
