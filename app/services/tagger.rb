class Tagger
  def initialize(user_id:, taggable:, tag_list:)
    @user_id = user_id
    @taggable = taggable
    @tags = tag_list.split(", ")
  end

  def call
    associate_tags
    dissociate_tags
  end

  private

  def associate_tags
    tag_names = @tags - tags_on_taggable
    tag_names.each do |tag_name|
      tag = Tag.find_or_create_by(name: tag_name, user_id: @user_id)
      @taggable.tags << tag
    end
  end

  def dissociate_tags
    tag_names = tags_on_taggable - @tags
    tag_names.each do |tag_name|
      tag = Tag.find_by(name: tag_name, user_id: @user_id)
      @taggable.taggings.find_by(tag_id: tag.id).destroy
    end
  end

  def tags_on_taggable
    @taggable.tags.all.collect(&:name)
  end
end
