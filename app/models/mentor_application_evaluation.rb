class MentorApplicationEvaluation
  def initialize(evaluation:, user:, application:)
    @evaluation = evaluation
    @user = user
    @application = application
  end

  def evaluate
    Evaluation.create!(attrs)
  end

  private

  def attrs
    { score: score,
      user: @user,
      mentor_application: @application }
  end

  def score
    m = @evaluation[:M].values.map { |x| x.to_f }.sum
    a = @evaluation[:A].values.map { |x| x.to_f }.sum
    k = @evaluation[:K].values.map { |x| x.to_f }.sum

    m*3 + a*2 + k*2
  end
end
