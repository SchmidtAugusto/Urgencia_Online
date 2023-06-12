class HospitalChannel < ApplicationCable::Channel
  def subscribed
    hospital = Hospital.find(params[:id])
    stream_for hospital
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
