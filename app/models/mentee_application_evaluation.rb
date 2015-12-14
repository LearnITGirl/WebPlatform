class MenteeApplicationEvaluation
  def initialize(evaluation:, user:, application:, max_soundness:)
    @evaluation = evaluation
    @user = user
    @application = application
    @max_soundness = max_soundness
  end

  def evaluate
    Evaluation.create!(attrs)
  end

  private

  def attrs
    { score: score,
      user: @user,
      mentee_application: @application }
  end

  def score
    m = @evaluation[:M].values.map { |x| x.to_f }.sum
    c = @evaluation[:C].values.map { |x| x.to_f }.sum
    l = @evaluation[:L].values.map { |x| x.to_f }.sum
    if @evaluation[:E].present? 
      e = @evaluation[:E].values.map { |x| x.to_f }.sum
    else 
      e = 0
    end
    if @evaluation[:S].present?
      s = @evaluation[:S].values.map { |x| x.to_f }.sum
      sp = s / (@max_soundness.to_f*10)
    else 
      sp = 0
    end

    (m*2 + c*1 + l*2 + e*1)*(1-sp)
  end
end