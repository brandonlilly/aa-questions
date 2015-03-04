class Table

  def self.find_by_id(id)
    result = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT * FROM #{self.table_name} WHERE id = ?
    SQL
    self.new(result.first)
  end

  def save
    variables = instance_variables[1..-1]
    values =  variables.map { |variable| instance_variable_get(variable).to_s }

    if self.id.nil?
      columns = variables.map { |variable| variable.to_s[1..-1] }.join(', ')
      question_marks = (["?"] * variables.count).join(", ")
      sql_code = <<-SQL
        INSERT INTO #{table_name} (#{columns})
        VALUES (#{question_marks})
      SQL
      QuestionsDatabase.instance.execute(sql_code, *values)
      @id = QuestionsDatabase.instance.last_insert_row_id
    else
      set = variables.map { |variable| "#{variable[1..-1]} = ?" }
      sql_code = <<-SQL
        UPDATE #{self.class.table_name} SET #{set.join(', ')}
        WHERE id = ?
      SQL
      QuestionsDatabase.instance.execute(sql_code, *values, id)
    end
  end

end
