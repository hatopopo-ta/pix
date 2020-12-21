(1..50).each do |number|
  Post.create(name: 'test user', content: 'test content ' + number.to_s)
end