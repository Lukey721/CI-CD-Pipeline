class BloodPressureCalculatorController < ApplicationController
  
  def new
    if request.post?
      systolic = params[:systolic].to_i
      diastolic = params[:diastolic].to_i

      # Call the categorize method to determine what is the blood pressure status 
      @category = categorize_blood_pressure(systolic, diastolic)
    end
  end

  private

  #add method for validation of user answer TODO

  def categorize_blood_pressure(systolic, diastolic)
    case
    when systolic < 90 || diastolic < 60
      "Low blood pressure"
    when systolic.between?(90, 120) && diastolic.between?(60, 80)
      "Ideal blood pressure"
    when systolic.between?(120, 139) || diastolic.between?(80, 89)
      "Pre-high blood pressure"
    else
      "High blood pressure"
    end
  end
end