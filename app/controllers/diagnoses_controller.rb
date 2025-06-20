class DiagnosesController < ApplicationController
  before_action :authenticate_user!
  def new
  end

  def result
  @diagnosis = Diagnose.new(
    q1: params[:q1],
    q2: params[:q2],
    q3: params[:q3]
  )

  @result = if @diagnosis.q1.blank? || @diagnosis.q2.blank? || @diagnosis.q3.blank?
      nil
  else
    @diagnosis.result
  end
  end
end
