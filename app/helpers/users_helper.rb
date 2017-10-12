module UsersHelper
  def gravatar_for(user, size: 80)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://www.gravatar.com/avatar/#{gravatar_id}.png?d=monsterid&s=#{size}"
    image_tag(gravatar_url, alt: user.name, :class => "text-center")
  end

  def show_score(user)
    score = Score.where(user_id: user.id, is_quiz: true)
    score_sum = score.sum(:total)
    score_count = score.count
    if score_count == 0
      @rating = "Unrated"
    else
      @rating = score_sum/score_count
    end
  end

end