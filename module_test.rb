# class String
#   def underscore
#     self.gsub(/::/, '/').
#     gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
#     gsub(/([a-z\d])([A-Z])/,'\1_\2').
#     tr("-", "_").
#     downcase
#   end
# end

# module Table
#
# p self.name.underscore
# result = QuestionsDatabase.instance.execute(<<-SQL, (self.name+'s').underscore, id)
#   SELECT * FROM ? WHERE id = ?
# SQL
# self.class.new(result.first)
#
# end
