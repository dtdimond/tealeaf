module Speak
  def speak(sound)
    puts "#{sound}"
  end
end


class BadDog
  include Speak
end

rover = BadDog.new
rover.speak("meow")
