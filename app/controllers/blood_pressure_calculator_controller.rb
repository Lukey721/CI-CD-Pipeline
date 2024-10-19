class BloodPressureCalculatorController < ApplicationController
  SYSTOLIC_MIN = 70
  SYSTOLIC_MAX = 190
  DIASTOLIC_MIN = 40
  DIASTOLIC_MAX = 100

  def new
    # Only process form data if the request is POST
    if request.post?
      systolic = params[:systolic].to_i
      diastolic = params[:diastolic].to_i

      if valid_blood_pressure?(systolic, diastolic)
        # Valid input, show blood pressure category
        @category = categorize_blood_pressure(systolic, diastolic)
      else
        # Invalid input, set error message
        @error_message = "Please review the measurements you have entered, The Valid Values are: Systolic (#{SYSTOLIC_MIN}-#{SYSTOLIC_MAX}), Diastolic (#{DIASTOLIC_MIN}-#{DIASTOLIC_MAX})."
      end
    end
  end

  private

  def valid_blood_pressure?(systolic, diastolic)
    systolic.between?(SYSTOLIC_MIN, SYSTOLIC_MAX) && diastolic.between?(DIASTOLIC_MIN, DIASTOLIC_MAX)
  end

  def categorize_blood_pressure(systolic, diastolic)
    if systolic < 90 || diastolic < 60
      "Low blood pressure"
    elsif systolic.between?(90, 120) && diastolic.between?(60, 80)
      "Ideal blood pressure"
    elsif systolic.between?(120, 139) || diastolic.between?(80, 89)
      "Pre-high blood pressure"
    else
      "High blood pressure"
    end
  end
end