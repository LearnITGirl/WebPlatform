class PollsController < ApplicationController

  def create
    @poll = Poll.new(answer: params[:poll][:answer])

    if @poll.save
      render json: {msg: "Your vote was added successfully"}, status: 201
    else
      render json: {msg: @poll.errors.full_messages.join(', ')}, status: 422
    end
  end
end
