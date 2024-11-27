# frozen_string_literal: true

class BloodPressureCalculatorController < ApplicationController
  SYSTOLIC_MIN = 70
  SYSTOLIC_MAX = 190
  DIASTOLIC_MIN = 40
  DIASTOLIC_MAX = 100

  def new
    # Only process form data if the request is POST
    return unless request.post?

    systolic = params[:systolic].to_i
    diastolic = params[:diastolic].to_i

    if valid_blood_pressure?(systolic, diastolic)
      # Valid input, show blood pressure category
      @category = categorize_blood_pressure(systolic, diastolic)
      @css_class = case @category # new
                   when 'Low blood pressure' then 'low-blood-pressure' # new
                   when 'Ideal blood pressure' then 'ideal-blood-pressure' # new
                   when 'Pre-high blood pressure' then 'pre-high-blood-pressure' # new
                   when 'High blood pressure' then 'high-blood-pressure' # new
                   end
      @error_message = nil # new
    else
      # Invalid input, set error message
      @error_message = "Please review the measurements you have entered, The Valid Values are: Systolic (#{SYSTOLIC_MIN}-#{SYSTOLIC_MAX}), Diastolic (#{DIASTOLIC_MIN}-#{DIASTOLIC_MAX})."
      @css_class = 'error-message' # new
      @category = nil # new
    end
  end

  private

  def valid_blood_pressure?(systolic, diastolic)
    systolic.between?(SYSTOLIC_MIN, SYSTOLIC_MAX) && diastolic.between?(DIASTOLIC_MIN, DIASTOLIC_MAX)
  end

  def categorize_blood_pressure(systolic, diastolic)
    if systolic < 90 || diastolic < 60
      'Low blood pressure'
    elsif systolic.between?(90, 120) && diastolic.between?(60, 80)
      'Ideal blood pressure'
    elsif systolic.between?(120, 139) && diastolic.between?(80, 89)
      'Pre-high blood pressure'
    else
      'High blood pressure'
    end
  end
end
