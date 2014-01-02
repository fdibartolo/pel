begin
  DummyAuthRails.load_config(File.expand_path('../../users.yml',__FILE__))
rescue NameError
end