class QuestionFollow < Table

  def self.table_name
    'question_follows'
  end

  # returns followers of question with that id
  def self.followers_for_question_id(question_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        users
      JOIN
        question_follows ON users.id = question_follows.user_id
      JOIN
        questions ON question_follows.question_id = questions.id
      WHERE
        questions.id = ?
    SQL
    results.map { |result| User.new(result) }
  end

  # return questions followed by particular user
  def self.followed_questions_for_user_id(user_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        questions
      JOIN
        question_follows ON questions.id = question_follows.question_id
      JOIN
        users ON users.id = question_follows.user_id
      WHERE
        users.id = ?
    SQL
    results.map { |result| Question.new(result) }
  end

  def self.most_followed_questions(n)
    results = QuestionsDatabase.instance.execute(<<-SQL, n)
      SELECT
        *
      FROM
        questions
      JOIN
        question_follows ON questions.id = question_follows.question_id
      GROUP BY
        questions.id
      ORDER BY
        COUNT(*) DESC
      LIMIT
        ?
    SQL
    results.map { |result| Question.new(result) }
  end

  attr_accessor :id, :user_id, :question_id

  def initialize(options = {})
    @id, @user_id, @question_id = options.values_at('id', 'user_id', 'question_id')
  end

end
