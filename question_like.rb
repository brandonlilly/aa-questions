class QuestionLike < Table

  def self.table_name
    'question_likes'
  end

  def self.likers_for_question_id(question_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        users
      JOIN
        question_likes ON users.id = question_likes.user_id
      JOIN
        questions ON question_likes.question_id = questions.id
      WHERE
        questions.id = ?
    SQL
    results.map { |result| User.new(result) }
  end

  def self.num_likes_for_question_id(question_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        COUNT(*) AS num_likes
      FROM
        users
      JOIN
        question_likes ON users.id = question_likes.user_id
      JOIN
        questions ON question_likes.question_id = questions.id
      WHERE
        questions.id = ?
    SQL
    results.first['num_likes']
  end

  def self.liked_questions_for_user_id(user_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        questions
      JOIN
        question_likes ON questions.id = question_likes.question_id
      JOIN
        users ON question_likes.user_id = users.id
      WHERE
        users.id = ?
    SQL
    results.map { |result| Question.new(result) }
  end

  def self.most_liked_questions(n)
    results = QuestionsDatabase.instance.execute(<<-SQL, n)
      SELECT
        *
      FROM
        questions
      JOIN
        question_likes ON questions.id = question_likes.question_id
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
