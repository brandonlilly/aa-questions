class Reply < Table

  def self.table_name
    'replies'
  end

  def self.find_by_user_id(user_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT * FROM replies WHERE user_id = ?
    SQL
    results.map { |result| Reply.new(result) }
  end

  def self.find_by_question_id(question_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT * FROM replies WHERE question_id = ?
    SQL
    results.map { |result| Reply.new(result) }
  end

  attr_accessor :id, :body, :user_id, :question_id, :parent_id

  def initialize(options = {})
    @id, @body, @user_id, @question_id, @parent_id =
    options.values_at('id', 'body', 'user_id', 'question_id', 'parent_id')
  end

  def author
    User.find_by_id(user_id)
  end

  def question
    Question.find_by_id(question_id)
  end

  def parent_reply
    Reply.find_by_id(parent_id)
  end

  def child_replies
    results = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT * FROM replies WHERE parent_id = ?
    SQL
    results.map { |result| Reply.new(result) }
  end

end
