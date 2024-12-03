# frozen_string_literal: true

class BloodPressureCalculatorController < ApplicationController
  SYSTOLIC_MIN = 70
  SYSTOLIC_MAX = 190
  DIASTOLIC_MIN = 40
  DIASTOLIC_MAX = 100
  CATEGORY_CSS_CLASSES = {
    'Low blood pressure' => 'low-blood-pressure',
    'Ideal blood pressure' => 'ideal-blood-pressure',
    'Pre-high blood pressure' => 'pre-high-blood-pressure',
    'High blood pressure' => 'high-blood-pressure'
  }.freeze

  before_action :track_homepage_view, only: [:new]

  def new
    # Only process form data if the request is POST
    return unless request.post?

    systolic = params[:systolic].to_i
    diastolic = params[:diastolic].to_i

    if valid_blood_pressure?(systolic, diastolic)
      # Valid input, show blood pressure category
      @category = categorize_blood_pressure(systolic, diastolic)
      @css_class = CATEGORY_CSS_CLASSES[@category]
      @error_message = nil
    else
      # Invalid input, set error message
      @error_message = "Please review the measurements you have entered, The Valid Values are: Systolic (#{SYSTOLIC_MIN}-#{SYSTOLIC_MAX}), Diastolic (#{DIASTOLIC_MIN}-#{DIASTOLIC_MAX})."
      @css_class = 'error-message'
      @category = nil
    end
  end

  def trackview
    # Track page view
    ApplicationInsights.track_page_view('Blood Pressure Calculator Homepage')
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
