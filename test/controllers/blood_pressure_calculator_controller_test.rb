# frozen_string_literal: true

require 'test_helper'

class BloodPressureCalculatorControllerTest < ActionDispatch::IntegrationTest
  test 'should get new' do
    get blood_pressure_calculator_new_url
    assert_response :success
  end

  test 'should get result' do
    get blood_pressure_calculator_result_url
    assert_response :success
  end
end
