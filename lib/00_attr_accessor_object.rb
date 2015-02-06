class AttrAccessorObject
  def self.my_attr_accessor(*names)
    names.each do |name|
      ivar_sym = ("@"+name.to_s).to_sym
      define_method(name) { instance_variable_get(ivar_sym) }
      define_method(name.to_s+"=") {|arg| instance_variable_set(ivar_sym, arg)}

    end
  end
end
